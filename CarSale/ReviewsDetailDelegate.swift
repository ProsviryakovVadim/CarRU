//
//  ReviewsDetailDelegate.swift
//  CarSale
//
//  Created by Vadim on 6/16/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

// MARK: - ReviewsDetailViewController -
protocol ReviewsDetailViewControllerInput: class {
    func displayCarInformation(_ info: Car, _ image: [UIImage])
}

protocol ReviewsDetailViewControllerOutput: class {
    func saveSelecterCarModel(_ carModel: Car)
    func loadOriginalImage()
}

// MARK: - ReviewsDetailInteractor -
protocol ReviewsDetailInteractorOutput: class {
    func sendLoadedInfoCar(_ car: Car, _ image: [UIImage])
}

protocol ReviewsDetailInteractorInput: class {
    func configureCarModel(_ carModel: Car)
    func loadUIImageFromUrl()
}

// MARK: - ReviewsDetaiPresenter -
protocol ReviewsDetaiPresenterInput: ReviewsDetailViewControllerOutput, ReviewsDetailInteractorOutput {}
