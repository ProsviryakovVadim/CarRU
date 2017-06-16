//
//  ReviewsDelegate.swift
//  CarSale
//
//  Created by Vadim on 6/16/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

// MARK: - ReviewsViewController -
protocol ReviewsViewControllerOutput: class {
    func getCarsInteractor()
    func performSegueCarDetail()
    func passDataReviewsDetail(_ segue: UIStoryboardSegue)
}

protocol ReviewsViewControllerInput: class {
    func displayCars(_ car: [Car])
    var reloadCar: Bool { get set }
}


// MARK: - ReviewsPresenter -
protocol ReviewsPresenterInput: ReviewsViewControllerOutput, ReviewsInteractorOutput {}


// MARK: - ReviewsInteractor -
protocol ReviewsInteractorOutput: class {
    func provideCars(_ car: [Car])
}

protocol ReviewsInteractorInput: class {
    func getCarsDataManager()
}
