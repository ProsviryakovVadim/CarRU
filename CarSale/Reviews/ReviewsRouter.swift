//
//  ReviewsRouter.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

protocol ReviewsRouterInput: class {
    func showDetailCarCell()
    func passDataReviewsDetail(_ segue: UIStoryboardSegue)
}

class ReviewsRouter: ReviewsRouterInput {
    
    weak var reviewsViewController: ReviewsViewController!
    
    
    // MARK: - Navigation -
    func showDetailCarCell() {
        self.reviewsViewController.performSegue(withIdentifier: "passDataReviewsDetail", sender: nil)
    }
    
    func passDataReviewsDetail(_ segue: UIStoryboardSegue) {
        if segue.identifier == "passDataReviewsDetail" {
            showReviewsDetailScene(segue)
        }
    }
    
    func showReviewsDetailScene(_ segue: UIStoryboardSegue) {
        if let selectedIndexPath = self.reviewsViewController.tableView.indexPathsForSelectedRows?.first {
            let selectedCarModel = self.reviewsViewController.markCar?[selectedIndexPath.row]
            let showDetailViewController = segue.destination as! ReviewsDetailViewController
                showDetailViewController.reviewsDetailViewControllerOutput.saveSelecterCarModel(selectedCarModel!)
        }
    }
}
