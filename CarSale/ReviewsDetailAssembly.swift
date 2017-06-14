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
        let loadImageCar: LoadImageCarProtocol = CarDataManager()
        let interactor = ReviewsDetailInteractor()
        let presenter = ReviewsDetailPresenter()
        
        // View
        viewController.presenter = presenter
        presenter.view = viewController
        
        // Presenter
        presenter.interactor = interactor
        
        // Interactor
        interactor.presenter = presenter
        interactor.loadImageCar = loadImageCar
    }
}
