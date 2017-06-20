//
//  UIImage+Extension.swift
//  CarSale
//
//  Created by Vadim on 6/20/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: img.cgImage!)
    }
    
}
