//
//  NavigationController.swift
//  CarSale
//
//  Created by Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

final class NavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = String.attributes(.sysFont(16, .light))
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        navigationBar.barTintColor = .redInbox
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}
