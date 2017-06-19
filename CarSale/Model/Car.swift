//
//  Car.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import ObjectMapper

final class Vehicles: Mappable {
    var vehicles: [Car] = []
    init?(map: Map) {}
    func mapping(map: Map) {
        vehicles <- map["vehicles"]
    }
}

final class Car: Mappable {
    
    private(set) var id: String = ""
    private(set) var mark: String = ""
    private(set) var model: String = ""
    private(set) var price: String = ""
    private(set) var images: [Images] = []
    private(set) var created: Date = Date()
    
    init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        mark <- map["mark"]
        model <- map["model"]
        price <- map["price"]
        images <- map["images"]
        created <- map["created"]
        
    }
}

final class Images: Mappable {
    private(set) var original: String = ""
    private(set) var small: String = ""
    
    init?(map: Map) {}
    
    func mapping(map: Map) {
        original <- map["original"]
        small <- map["small"]
    }
}
