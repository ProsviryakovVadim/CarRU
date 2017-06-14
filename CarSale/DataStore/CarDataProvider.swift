//
//  CarDataProvider.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import Foundation
import Alamofire
import SDWebImage
import RxSwift

// MARK: - Error -
enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

// MARK: - Protocol Car Model -
protocol GetCarsProtocol: class {
    func getCars () -> Observable<[Car]>
    func getMarks() -> Observable<[Models]>
}

protocol LoadImageCarProtocol: class {
    func loadImageFromUrl(_ url: NSURL, closure: @escaping (UIImage?, NSError?) -> Void)
}

// MARK: - CarDataStore -
class CarDataManager: GetCarsProtocol, LoadImageCarProtocol {
    
    static let instance = CarDataManager()
    private let path = "http://ec2-34-209-34-16.us-west-2.compute.amazonaws.com/api/"
    var request = Alamofire.request
    
    struct Error {
        static let invalidPrice = "price"
    }
    
    
    func getCars() -> Observable<[Car]> {
        return Observable.create({ (observer) -> Disposable in
            let req = Alamofire.request(self.path + "vehicles/").responseObject {(response: DataResponse<Vehicles>) in
                switch response.result {
                case .success(let res):
                    if let car = res.vehicles {
                        observer.onNext(car)
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                req.cancel()
            }
        })
    }
    
        func getMarks() -> Observable<[Models]> {
            return Observable.create({ (observer) -> Disposable in
                let req = Alamofire.request(self.path + "vehicles/marks").responseObject {(response: DataResponse<Marks>) in
                    switch response.result {
                    case .success(let res):
                        if let mark = res.marks {
                            observer.onNext(mark)
                            observer.onCompleted()
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                return Disposables.create {
                    req.cancel()
                }
            })
        }
    
    
    func prepareRequest(image: [UIImage], mark: String, model: String) {
        
        var imageData = Data()
        var imageString = [NSDictionary]()
        for img in image {
            imageData = UIImageJPEGRepresentation(img, 0.1)!
            imageString.append(["source": "\(String(describing: imageData.base64EncodedString()))"])
        }
        
        let json: [String: Any] =
            ["vehicles":["mark": mark, "model": model, "price": "1000", "images": imageString]]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://ec2-34-209-34-16.us-west-2.compute.amazonaws.com/api/vehicles/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // insert json data to the request
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
        }
        task.resume()
    }
    
//    fileprivate func createMarkModelList() -> Models {
//        
//        
//        let modelData = ModelList(title: String, model: [String])
//        
//        return modelData
//    }

    
    //    func getCar(searchCarId: String, completionHandler: @escaping (NSError, Car?) -> Void) {
    //        let escapedSearchId = searchCarId.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    //        let path = String(format: Url.selectCarId, arguments: [escapedSearchId!])
    //        Alamofire.request(path).responseObject { (response: DataResponse<Vehicle>) in
    //            guard let vehiclesResponse = response.result.value?.vehicle else {
    //                print(response.error!)
    //                return
    //            }
    //            completionHandler(response.error! as NSError, vehiclesResponse)}
    //    }
    
    
    // MARK: - Load images -
    func loadImageFromUrl(_ url: NSURL, closure: @escaping (UIImage?, NSError?) -> Void) {
        SDWebImageManager.shared().downloadImage(with: url as URL!, options: .cacheMemoryOnly, progress: nil) { (image, error, cache, finished, withUrl) in
            if ((image != nil) && finished) {
                closure(image, error as NSError?)
            }
        }
    }
}


