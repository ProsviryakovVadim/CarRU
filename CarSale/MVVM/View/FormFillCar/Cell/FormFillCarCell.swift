//
//  FormFillCarCell.swift
//  CarSale
//
//  Created by Vadim on 6/15/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

final class FormFillCarCell: UITableViewCell {
    
    var titleFormFillCar: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let titleView: UILabel = {
            titleFormFillCar = UILabel(frame: CGRect(x: self.contentView.bounds.origin.x + 10,
                                                     y: self.contentView.bounds.origin.y,
                                                     width: self.contentView.frame.width,
                                                     height: self.contentView.frame.height))
            titleFormFillCar.textAlignment = .left
            titleFormFillCar.font = UIFont(name: "Verdana", size: 18)
            return titleFormFillCar
        }()
        contentView.addSubview(titleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
