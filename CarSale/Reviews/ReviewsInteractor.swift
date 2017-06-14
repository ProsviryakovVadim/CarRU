//
//  ReviewsInteractor.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import RxSwift

protocol ReviewsInteractorOutput: class {
    func provideCars(_ car: [Car])
}

protocol ReviewsInteractorInput: class {
    func getCarsDataProvide()
}

class ReviewsInteractor: ReviewsInteractorInput {
    
    weak var presenter: ReviewsInteractorOutput!
    var apiDataProvider: GetCarsProtocol!
    fileprivate var disposeBag = DisposeBag()
    
    func getCarsDataProvide() {
        apiDataProvider.getCars().subscribe(onNext: {(car) in
            self.presenter.provideCars(car)
        }, onError: { [weak self] error in
            print(error)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self?.getCarsDataProvide()
            }
        }).addDisposableTo(disposeBag)
    }
}
