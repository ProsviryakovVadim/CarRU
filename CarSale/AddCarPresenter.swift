//
//  AddCarPresenter.swift
//  CarSale
//
//  Created Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//
//

import UIKit

class AddCarPresenter: AddCarPresenterProtocol {

    weak private var view: AddCarViewProtocol?
    private let interactor: AddCarInteractorProtocol
    private let router: AddCarWireframeProtocol

    init(interface: AddCarViewProtocol, interactor: AddCarInteractorProtocol, router: AddCarWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.interactor.presenter = self        
    }
}
