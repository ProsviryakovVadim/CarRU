//
//  AddCarProtocols.swift
//  CarSale
//
//  Created Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol AddCarWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol AddCarPresenterProtocol: class {
}

//MARK: Interactor -
protocol AddCarInteractorProtocol: class {
    var presenter: AddCarPresenterProtocol?  { get set }
}

//MARK: View -
protocol AddCarViewProtocol: class {
    func setupMenuBar()
    var presenter: AddCarPresenterProtocol?  { get set }
}
