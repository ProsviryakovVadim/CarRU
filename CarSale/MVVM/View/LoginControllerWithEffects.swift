//
//  LoginControllerWithEffects.swift
//  CarSale
//
//  Created by Vadim on 6/20/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class LoginControllerWithEffects: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        delay(1.0) {
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
            self.activityIndicator.stopAnimating()
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
