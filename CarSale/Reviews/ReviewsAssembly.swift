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
        let carDataManager = CarDataManager()
        let interactor = ReviewsInteractor()
        let presenter = ReviewsPresenter()
        let router = ReviewsRouter()
        
        //Router
        router.view = viewController
        presenter.router = router
        
        //View
        viewController.presenter = presenter
        presenter.view = viewController
        
        //Present - Interactor - DataStore (Entity)
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.apiDataProvider = carDataManager
    }
}


