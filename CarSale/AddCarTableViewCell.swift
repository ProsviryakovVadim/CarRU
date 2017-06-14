//
//  AddCarTableViewCell.swift
//  CarSale
//
//  Created by Vadim on 5/17/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class AddCarTableViewCell: UITableViewCell {
    
    var addTextCar: UITextView!
    var addButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let addTextCarView: UITextView = {
            addTextCar = UITextView(frame: CGRect(x: UIScreen.main.bounds.origin.x + 10, y: 10, width: UIScreen.main.bounds.width - 20, height: bounds.height * 2))
            addTextCar.isScrollEnabled = false
            addTextCar.isSelectable = false
            addTextCar.textAlignment = .center
            addTextCar.font = UIFont(name: "Verdana", size: 14)
            return addTextCar
        }()
        
        let addButtonView: UIButton = {
            addButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.origin.x + 10, y: bounds.height * 1.5, width: UIScreen.main.bounds.width - 20, height: bounds.height))
            addButton.setTitle("Добавить объявление", for: .normal)
            addButton.titleLabel?.font = UIFont(name: "Verdana", size: 15)
            addButton.setTitleColor(UIColor.white, for: .normal)
            addButton.backgroundColor = UIColor(red: 85, green: 187, blue: 0)
            addButton.layer.cornerRadius = 2
            return addButton
        }()
        
        
        
        contentView.addSubview(addTextCarView)
        contentView.addSubview(addButtonView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
