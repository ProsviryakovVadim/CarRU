//
//  Car.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import ObjectMapper

final class Vehicles: Mappable {
    var vehicles: [Car]?
    init?(map: Map) {}
    func mapping(map: Map) {
        vehicles <- map["vehicles"]
    }
}

final class Vehicle: Mappable {
    var vehicle: Car?
    init?(map: Map) {}
    func mapping(map: Map) {
        vehicle <- map["vehicle"]
    }
}

final class Car: Mappable {
    
    var id: String?
    var mark: String?
    var model: String?
    var price: String?
    var images: [Images]?
    var created: Date?
    
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
    var original: String?
    var small: String?
    
    init?(map: Map) {}
    
    func mapping(map: Map) {
        original <- map["original"]
        small <- map["small"]
    }
}
