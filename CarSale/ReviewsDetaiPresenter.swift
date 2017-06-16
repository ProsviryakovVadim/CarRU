//
//  ReviewsDetaiPresenter.swift
//  CarSale
//
//  Created by Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit


final class ReviewsDetailPresenter: ReviewsDetaiPresenterInput {

    var reviewsDetailViewControllerInput: ReviewsDetailViewControllerInput!
    var reviewsDetailInteractorInput: ReviewsDetailInteractorInput!
    
    
    func saveSelecterCarModel(_ carModel: Car) {
        self.reviewsDetailInteractorInput.configureCarModel(carModel)
    }
    
    // Command from View to Present to Interactor for load images and 
    func loadOriginalImage() {
        self.reviewsDetailInteractorInput.loadUIImageFromUrl()
    }
    
    // Output Presenter to View
    func sendLoadedInfoCar(_ car: Car, _ image: [UIImage]) {
        self.reviewsDetailViewControllerInput.displayCarInformation(car, image)
    }
}
