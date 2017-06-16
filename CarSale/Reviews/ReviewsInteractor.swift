//
//  ReviewsInteractor.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import RxSwift

class ReviewsInteractor: ReviewsInteractorInput {
    
    weak var reviewsInteractorOutput: ReviewsInteractorOutput!
    var carDataManagerDelegte: CarDataManagerDelegte!
    fileprivate var disposeBag = DisposeBag()
    
    func getCarsDataManager() {
        carDataManagerDelegte.getCars().subscribe(onNext: {(car) in
            self.reviewsInteractorOutput.provideCars(car)
        }, onError: { [weak self] error in
            print(error)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self?.getCarsDataManager()
            }
        }).addDisposableTo(disposeBag)
    }
}
