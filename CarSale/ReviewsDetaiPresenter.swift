//
//  ReviewsDetaiPresenter.swift
//  CarSale
//
//  Created by Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

protocol ReviewsDetaiPresenterInput: ReviewsDetailViewControllerOutput, ReviewsDetailInteractorOutput {
}

final class ReviewsDetailPresenter: ReviewsDetaiPresenterInput {

    var view: ReviewsDetailViewControllerInput!
    var interactor: ReviewsDetailInteractorInput!
    
    
    func saveSelecterCarModel(_ carModel: Car) {
        self.interactor.configureCarModel(carModel)
    }
    
    // Command from View to Present to Interactor for load images and 
    func loadOriginalImage() {
        self.interactor.loadUIImageFromUrl()
    }
    
    // Output Presenter to View
    func sendLoadedInfoCar(_ car: Car, _ image: [UIImage]) {
        self.view.displayCarInformation(car, image)
    }
}
