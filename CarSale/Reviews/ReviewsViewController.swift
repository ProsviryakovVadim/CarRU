//
//  ReviewsViewController.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import KVNProgress
import RxSwift

// MARK: - Protocol -
protocol ReviewsViewControllerOutput: class {
    func getCarsInteractor()
    func performSegueCarDetail()
    func passDataReviewsDetail(_ segue: UIStoryboardSegue)
}

protocol ReviewsViewControllerInput: class {
    func displayCars(_ car: [Car])
    var reloadCar: Bool { get set }
}

class ReviewsViewController: UIViewController, ReviewsViewControllerInput {
    
    @IBOutlet var tableView: UITableView!
    let cellString = String(describing: "\(ReviewsViewCell.self)")
    var presenter: ReviewsViewControllerOutput!
    var reloadCar = false
    var markCar: [Car]?
    
//        {
//            didSet {
//                guard isViewLoaded else { return }
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ReviewsAssembly.sharedInstanceReviews.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        tableView.register(ReviewsViewCell.self as AnyClass, forCellReuseIdentifier: cellString)
        presenter.getCarsInteractor()
    }
    
    
    func displayCars(_ car: [Car]) {
        self.markCar = car
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.reloadCar = true
        }
        //TODO imitation pagination
        //        let result = self.markCar.contains { (carEquals) -> Bool in
        //            for carObj in car {
        //                return carEquals.id == carObj.id
        //            }
        //            return false
        //        }
        //        for carObj in car {
        //            if result != true {
        //                self.markCar.append(carObj)
        //                DispatchQueue.main.async {
        //                    self.tableView.reloadData()
        //                }
        //            }
        //        }
        //        self.reloadCar = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.passDataReviewsDetail(segue)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // TODO - temporary solution load car
        if reloadCar == true {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            let deltaOffset = maximumOffset - currentOffset + 40
            if deltaOffset >= 0 {
                DispatchQueue.main.async {
                    self.presenter.getCarsInteractor()
                    self.reloadCar = false
                }
            }
        }
    }
}



// MARK: - UITableViewDataSource -
extension ReviewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.markCar != nil{
            return (self.markCar!.count)
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellString, for: indexPath) as! ReviewsViewCell
        cell.markCar.text = self.markCar?[indexPath.row].mark
        cell.modelCar.text = self.markCar?[indexPath.row].model
        if let images = self.markCar?[indexPath.row].images {
            let url = NSURL(string: (images[0].small)!)
            cell.imageCar.sd_setImage(with: url! as URL, completed: { (image, error, cache, url) in
                cell.imageCar?.image = image
            })
        } else {
            cell.imageCar?.image = UIImage(named: "race")
        }
        return cell
    }
}



// MARK: - UITableViewDelegate -
extension ReviewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.0) // very light gray
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.performSegueCarDetail()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - UITableViewCell -
class ReviewsViewCell: UITableViewCell {
    
    var markCar: UILabel!
    var modelCar: UILabel!
    var imageCar: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: Fields
        let imageCarView: UIImageView = {
            imageCar = UIImageView(frame: CGRect(x: 8, y: 8, width: self.bounds.width / 3, height: self.bounds.width / 3.5 - 8))
            return imageCar
        }()
        
        let markCarLabel: UILabel = {
            markCar = UILabel(frame: CGRect(x: self.bounds.width / 3 + 16, y: 0, width: self.contentView.bounds.width, height: self.bounds.width / 6))
            markCar.numberOfLines = 0
            return markCar
        }()
        
        let modelCarLabel: UILabel = {
            modelCar = UILabel(frame: CGRect(x: self.bounds.width / 3 + 16, y: 0, width: self.contentView.bounds.width, height: self.bounds.width / 3.5))
            modelCar.font = UIFont(name: modelCar.font.fontName, size: 14)
            modelCar.textColor = .lightGray
            return modelCar
        }()
        
        // MARK: Views
        self.contentView.addSubview(imageCarView)
        self.contentView.addSubview(markCarLabel)
        self.contentView.addSubview(modelCarLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



