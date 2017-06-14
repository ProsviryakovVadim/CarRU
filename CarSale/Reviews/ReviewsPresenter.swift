//
//  ReviewsPresenter.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import KVNProgress

protocol ReviewsPresenterInput: ReviewsViewControllerOutput, ReviewsInteractorOutput {
}

class ReviewsPresenter: ReviewsPresenterInput {
    
    weak var view: ReviewsViewControllerInput!
    var interactor: ReviewsInteractorInput!
    var router: ReviewsRouterInput!
    
    func getCarsInteractor() {
        KVNProgress.show()
        interactor.getCarsDataProvide()
    }
    
    func provideCars(_ car: [Car]) {
        KVNProgress.dismiss()
        self.view.displayCars(car)
    }
    
    
    // MARK: - Changed View -
    func performSegueCarDetail () {
        self.router.showDetailCarCell()
    }
    
    func passDataReviewsDetail(_ segue: UIStoryboardSegue) {
        self.router.passDataReviewsDetail(segue)
    }
}
