//
//  ReviewsDetailAssembly.swift
//  CarSale
//
//  Created by Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

final class ReviewsDetailAssembly {
    
    static let sharedInstanceReviewsDetail = ReviewsDetailAssembly()
    
    func configure(_ viewController: ReviewsDetailViewController) {
        let loadImageCar: LoadImageCarDelegate = CarDataManager()
        let reviewsDetailInteractor = ReviewsDetailInteractor()
        let reviewsDetailPresenter = ReviewsDetailPresenter()
        
        // View
        viewController.reviewsDetailViewControllerOutput = reviewsDetailPresenter
        reviewsDetailPresenter.reviewsDetailViewControllerInput = viewController
        
        // Presenter
        reviewsDetailPresenter.reviewsDetailInteractorInput = reviewsDetailInteractor
        
        // Interactor
        reviewsDetailInteractor.reviewsDetailInteractorOutput = reviewsDetailPresenter
        reviewsDetailInteractor.loadImageCar = loadImageCar
    }
}
