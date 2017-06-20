//
//  ReviewsDetailInteractor.swift
//  CarSale
//
//  Created by Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

final class ReviewsDetailInteractor: ReviewsDetailInteractorInput {
    
    var reviewsDetailInteractorOutput: ReviewsDetailInteractorOutput!
    var carModel: Car?
    var loadImageCar: LoadImageCarDelegate!
    var url: NSURL?
    var images = [UIImage]()
    
    // Input Interactor
    func configureCarModel(_ carModel: Car) {
        self.carModel = carModel
    }
    
    // Output Interactor to Presenter
    func loadUIImageFromUrl() {
        guard let urlImage = self.carModel?.images else {
            return
        }
        for i in 0..<urlImage.count {
            DispatchQueue.main.async {
                self.url = NSURL(string: urlImage[i].original)!
                self.loadImageCar.loadImageFromUrl(self.url!) { (images, error) in
                    self.images.append(images!)
                    if self.images.count == urlImage.count {
                        self.reviewsDetailInteractorOutput.sendLoadedInfoCar(self.carModel!, self.images)
                        self.images.removeAll()
                    }
                }
            }
        }
    }
}
