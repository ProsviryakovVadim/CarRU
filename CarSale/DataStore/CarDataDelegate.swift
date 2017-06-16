//
//  CarDataDelegate.swift
//  CarSale
//
//  Created by Vadim on 6/16/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - CarDataManagerDelegte -
protocol CarDataManagerDelegte: class {
    func getCars () -> Observable<[Car]>
    func getMarks() -> Observable<[Models]>
    func prepareRequest(image: [UIImage], mark: String, model: String)
}

protocol LoadImageCarDelegate: class {
    func loadImageFromUrl(_ url: NSURL, closure: @escaping (UIImage?, NSError?) -> Void)
}
