//
//  Food.swift
//  RxCocoaTest
//
//  Created by Константин on 23.09.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit
import RxSwift

struct FormCreateCarField {
    
    let field: String

     static let form = [
        FormCreateCarField(field: "Марка"),
        FormCreateCarField(field: "Модель"),
        FormCreateCarField(field: "Выбрать фотографии"),
        FormCreateCarField(field: "Отправить данные")
    ]
}
