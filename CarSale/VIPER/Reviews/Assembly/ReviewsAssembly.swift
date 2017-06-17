//
//  ReviewsAssembly.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//


final class ReviewsAssembly {
    
    static let sharedInstanceReviews = ReviewsAssembly()
    
    func configure(_ viewController: ReviewsViewController) {
        let carDataManager    = CarDataManager()
        let reviewsInteractor = ReviewsInteractor()
        let reviewsPresenter  = ReviewsPresenter()
        let reviewsRouter     = ReviewsRouter()
        
        //Router
        reviewsRouter.reviewsViewController = viewController
        reviewsPresenter.reviewsRouterInput = reviewsRouter
        
        //View
        viewController.reviewsViewControllerOutput = reviewsPresenter
        reviewsPresenter.reviewsViewControllerInput = viewController
        
        //Present - Interactor - DataStore (Entity)
        reviewsPresenter.reviewsInteractorInput = reviewsInteractor
        reviewsInteractor.reviewsInteractorOutput = reviewsPresenter
        reviewsInteractor.carDataManagerDelegte = carDataManager
    }
}


