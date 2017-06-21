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
    @IBOutlet weak var loginButtonTop: NSLayoutConstraint!
    @IBOutlet weak var loginButtonTopOpen: NSLayoutConstraint!
    
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    
    // MARK: - View -
    override func viewDidLoad() {
        gradientColors()
    }

    override func viewDidDisappear(_ animated: Bool) {
        login.text?.removeAll()
        password.text?.removeAll()
        loginButtonTop.isActive = false
        loginButtonTopOpen.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animtedLogo()
        animatedFields()
        loginButtonTop.isActive = true
        loginButtonTopOpen.isActive = false
    }
    
    
    // MARK: - Action -
    @IBAction func next() {
        clientDidLoad()
    }
    
    @IBAction func registration(_ sender: Any) {
        //TODO
    }
    
    private func clientDidLoad() {
        let client = Client.instance
        let login = self.login.text!
        if login == client.login {
            let newVc = self.storyboard?.instantiateViewController(withIdentifier: "Start")
            self.present(newVc!, animated: true, completion: nil)
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
            self.registrationButton.alpha = 1
            
            self.login.frame = self.login.frame.offsetBy(dx: 0, dy: -20)
            self.password.frame = self.password.frame.offsetBy(dx: 0, dy: -20)
            self.loginButton.frame = self.loginButton.frame.offsetBy(dx: 0, dy: 10)
            self.registrationButton.frame = self.registrationButton.frame.offsetBy(dx: 0, dy: 10)
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
        loginButton.clipsToBounds = true
        loginButton.alpha = 0.0
        registrationButton.layer.cornerRadius = 5
        registrationButton.clipsToBounds = true
        registrationButton.alpha = 0.0
        login.alpha = 0.0
        password.alpha = 0.0
        loginButton.setBackgroundImage(UIImage(color: .redInbox), for: .normal)

    }
}
