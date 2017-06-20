//
//  LoginController.swift
//  CarSale
//
//  Created by Vadim on 6/20/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    //TODO
    @IBOutlet weak var logoVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoVerticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoMovedToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightOriginalConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightSmallerConstraint: NSLayoutConstraint!
    
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        gradientColors()
        load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animtedLogo()
        animatedFields()
    }
    
    private func load() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            self.loginButton.isHidden = false
            self.login.isHidden = false
            self.password.isHidden = false
        }
    }
    
    @IBAction func next() {
        clientDidLoad()
        login.text?.removeAll()
    }
    
    
    private func clientDidLoad() {
        let client = Client.instance
        let login = self.login.text!
        if login == client.login {
            let newVc = self.storyboard?.instantiateViewController(withIdentifier: "Start")
            self.present(newVc!, animated: true, completion: nil)
        } else {
            self.viewDidAppear(true)
        }
    }
    
    
    func animtedLogo() {
        // Orientation for x or y
        logoVerticalCenterConstraint.isActive = false
        logoVerticalConstraint.isActive = true
        logoMovedToTopConstraint.isActive = true
        logoHeightOriginalConstraint.isActive = false
        logoHeightSmallerConstraint.isActive = true
    }

    func animatedFields() {
        UIView.animate(withDuration: 1.5, animations: {
            // Animation Twit
            self.view.layoutIfNeeded()
            
            self.login.alpha = 1
            self.password.alpha = 1
            self.loginButton.alpha = 1
            
            self.login.alpha = 1
            self.password.alpha = 1
            self.loginButton.alpha = 1
            self.login.frame = self.login.frame.offsetBy(dx: 0, dy: -20)
            self.password.frame = self.password.frame.offsetBy(dx: 0, dy: -20)
            self.loginButton.frame = self.loginButton.frame.offsetBy(dx: 0, dy: -20)
        })
    }
    
    func gradientColors() {
        // Do any additional setup after loading the view.
        //Gradient
        let color1 = UIColor(red: 42.0/255.0, green: 163.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        let color2 = UIColor(red: 88.0/255.0, green: 178.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        let color3 = UIColor(red: 141.0/255.0, green: 192.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        let color4 = UIColor(red: 224.0/255.0, green: 226.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        
        let gradientColors: [CGColor] = [color1.cgColor, color2.cgColor, color3.cgColor, color4.cgColor]
        let gradientLocations: [Float] = [0.0, 0.25, 0.75, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        loginButton.layer.cornerRadius = 5
        loginButton.alpha = 0.0
        login.alpha = 0.0
        password.alpha = 0.0
        
        
        loginButton.setBackgroundImage(UIImage(color: .redInbox), for: .normal)
        loginButton.isHidden = true
        login.isHidden = true
        password.isHidden = true
    }
}

