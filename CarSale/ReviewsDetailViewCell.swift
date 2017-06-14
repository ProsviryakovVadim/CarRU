//
//  ReviewsDetailViewCell.swift
//  CarSale
//
//  Created by Vadim on 5/31/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class ReviewsDetailViewCell: UITableViewCell {
    
    var markCar: UILabel!
    var modelCar: UILabel!
    var imageCar: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: Fields
        let imageCarView: UIImageView = {
            imageCar = UIImageView(frame: CGRect(x: self.bounds.midX / 4, y: 8, width: self.bounds.width, height: self.bounds.width))
            return imageCar
        }()
        
        let markCarLabel: UILabel = {
            markCar = UILabel(frame: CGRect(x: self.bounds.origin.x + 16, y: 0, width: self.bounds.width - 8, height: self.bounds.width / 6))
            markCar.numberOfLines = 0
            return markCar
        }()
        
        let modelCarLabel: UILabel = {
            modelCar = UILabel(frame: CGRect(x: self.bounds.origin.x + 16, y: 0, width: self.bounds.width - 8, height: self.bounds.width / 3.7))
            modelCar.font = UIFont(name: modelCar.font.fontName, size: 14)
            modelCar.textColor = .lightGray
            return modelCar
        }()
        
        // MARK: Views
        self.contentView.addSubview(imageCarView)
        self.contentView.addSubview(markCarLabel)
        self.contentView.addSubview(modelCarLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

