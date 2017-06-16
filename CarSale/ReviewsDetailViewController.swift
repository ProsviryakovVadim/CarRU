//
//  ReviewsDetailViewController.swift
//  CarSale
//
//  Created by Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import KVNProgress

protocol ReviewsDetailViewControllerInput: class {
    func displayCarInformation(_ info: Car, _ image: [UIImage])
}

protocol ReviewsDetailViewControllerOutput: class {
    func saveSelecterCarModel(_ carModel: Car)
    func loadOriginalImage()
}

final class ReviewsDetailViewController: UIViewController, ReviewsDetailViewControllerInput {
    
    @IBOutlet weak var tableView: UITableView!
    var reviewsDetailViewControllerOutput: ReviewsDetailViewControllerOutput!
    var car: Car?
    var imageCar: [UIImage]?
    
    override func awakeFromNib() {
        super .awakeFromNib()
        ReviewsDetailAssembly.sharedInstanceReviewsDetail.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.register(ReviewsDetailViewCell.self as AnyClass, forCellReuseIdentifier: "ReviewsDetailCell")
        tableView.register(ReviewsDetailCollectionCell.self, forCellReuseIdentifier: "NewFormCell")
        self.reviewsDetailViewControllerOutput.loadOriginalImage()
    }
    
    func displayCarInformation(_ info: Car, _ image: [UIImage]) {
        self.car = info
        self.imageCar = image
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource -
extension ReviewsDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsDetailCell", for: indexPath) as! ReviewsDetailViewCell
        let row = indexPath.row
        switch row {
        case 0:
            cell.markCar.text = self.car?.mark
            cell.modelCar.text = self.car?.model
        case 1:
            cell.textLabel?.text = "1. Внешний вид. Ну конечно, это первое с чего хочу начать. Я каждый раз оборачиваюсь уходя. Внешний вид автомобиля мне более чем нравится. Не могу и представить что же ещё доработать) много думал про винил, может стоит заморочиться, как считаете? 2. Эргономика. Спустя несколько километров пробега я уже точно осознавал где и какая кнопочка находится. Точно знал куда мне нужно нажать, чтобы выпало то или иное меню. Очень быстро настроил весь автомобиль под себя."
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = .darkGray
            
        case 2:
            if self.imageCar != nil {
                let cell: ReviewsDetailCollectionCell = tableView.dequeueReusableCell(withIdentifier: "NewFormCell", for: indexPath) as! ReviewsDetailCollectionCell
                cell.newFormImage = self.imageCar
                cell.collectionView.reloadData()
            } else {
                cell.imageCar?.contentMode = .scaleAspectFill
                cell.imageCar?.image = UIImage(named: "race")
            }
            return cell
            
        default:
            return cell
        }
        return cell
    }
}



// MARK: - UITableViewDelegate -
extension ReviewsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return 250
        case 2:
            return 250
        default:
            tableView.rowHeight = UITableViewAutomaticDimension;
        }
        return 55
    }
}
