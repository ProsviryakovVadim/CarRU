//
//  ReviewsPresenter.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import KVNProgress

class ReviewsPresenter: ReviewsPresenterInput {
    
    weak var reviewsViewControllerInput: ReviewsViewControllerInput!
    var reviewsInteractorInput: ReviewsInteractorInput!
    var reviewsRouterInput: ReviewsRouterInput!
    
    func getCarsInteractor() {
        KVNProgress.show()
        reviewsInteractorInput.getCarsDataManager()
    }
    
    func provideCars(_ car: [Car]) {
        KVNProgress.dismiss()
        self.reviewsViewControllerInput.displayCars(car)
    }
    
    // MARK: - Changed View -
    func performSegueCarDetail () {
        self.reviewsRouterInput.showDetailCarCell()
    }
    
    func passDataReviewsDetail(_ segue: UIStoryboardSegue) {
        self.reviewsRouterInput.passDataReviewsDetail(segue)
    }
}
