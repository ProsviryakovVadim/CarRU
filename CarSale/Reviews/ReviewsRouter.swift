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
    
    weak var view: ReviewsViewController!
    
    
    // MARK: - Navigation -
    func showDetailCarCell() {
        self.view.performSegue(withIdentifier: "passDataReviewsDetail", sender: nil)
    }
    
    func passDataReviewsDetail(_ segue: UIStoryboardSegue) {
        if segue.identifier == "passDataReviewsDetail" {
            showReviewsDetailScene(segue)
        }
    }
    
    func showReviewsDetailScene(_ segue: UIStoryboardSegue) {
        if let selectedIndexPath = self.view.tableView.indexPathsForSelectedRows?.first {
            let selectedCarModel = self.view.markCar?[selectedIndexPath.row]
            let showDetailViewController = segue.destination as! ReviewsDetailViewController
                showDetailViewController.presenter.saveSelecterCarModel(selectedCarModel!)
        }
    }
}
