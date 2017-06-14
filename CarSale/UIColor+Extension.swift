//
//  UIColor+Extension.swift
//  CarSale
//
//  Created by Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//


import UIKit

extension UIColor {
    
    convenience init(hex: UInt32) {
        self.init(
            red: CGFloat((hex >> 24) & 0xff) / 255,
            green: CGFloat((hex >> 16) & 0xff) / 255,
            blue: CGFloat((hex >> 8) & 0xff) / 255,
            alpha: CGFloat(hex & 0xff) / 255
        )
    }
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
    static var carAccent: UIColor {
        return UIColor(hex: 0x17396cff)
    }
    
    static var carInbox: UIColor {
        return UIColor(hex: 0x0000FF)
    }
    
    static var cartOutbox: UIColor {
        return .carAccent
    }
    
    public class var carSecondText: UIColor {
        return UIColor(hex: 0x969696ff)
    }
    
    static var carSeparator: UIColor {
        return UIColor(hex: 0xe9e9e9ff)
    }

    static var redInbox: UIColor {
        return UIColor(red: 219/255, green: 55/255, blue: 39/255, alpha: 1.0)
    }
}
