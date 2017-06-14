//
//  AddCarAssembly.swift
//  CarSale
//
//  Created Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//
//

import UIKit

class AddCarRouter: AddCarWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = AddCarViewController()
        let interactor = AddCarInteractor()
        let router = AddCarRouter()
        let presenter = AddCarPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
