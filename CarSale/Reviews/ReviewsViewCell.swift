//
//  ReviewsViewCell.swift
//  CarSale
//
//  Created by Vadim on 6/16/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class ReviewsViewCell: UITableViewCell {
    
    var markCar: UILabel!
    var modelCar: UILabel!
    var imageCar: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: Fields
        let imageCarView: UIImageView = {
            imageCar = UIImageView(frame: CGRect(x: 8, y: 8, width: self.bounds.width / 3, height: self.bounds.width / 3.5 - 8))
            return imageCar
        }()
        
        let markCarLabel: UILabel = {
            markCar = UILabel(frame: CGRect(x: self.bounds.width / 3 + 16, y: 0, width: self.contentView.bounds.width, height: self.bounds.width / 6))
            markCar.numberOfLines = 0
            return markCar
        }()
        
        let modelCarLabel: UILabel = {
            modelCar = UILabel(frame: CGRect(x: self.bounds.width / 3 + 16, y: 0, width: self.contentView.bounds.width, height: self.bounds.width / 3.5))
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
    
    func setupCell(car: [Car], row: Int) {
        markCar.text = car[row].mark
        modelCar.text = car[row].model
        if let images = car[row].images {
            let url = NSURL(string: (images[0].small)!)
            imageCar.sd_setImage(with: url! as URL, completed: { (image, error, cache, url) in
                self.imageCar.image = image
            })
        } else {
            imageCar?.image = UIImage(named: "race")
        }

    }
}
