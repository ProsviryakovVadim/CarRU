//
//  Form.swift
//  CarsSell
//
//  Created by Vadim on 5/19/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import ObjectMapper


final class Marks: Mappable {
    var marks: [Models]?
    
    init?(map: Map) {}
    func mapping(map: Map) {
        marks <- map["marks"]
    }
}

final class Models: Mappable {
    var title: String?
    var model: [String]?
    
    init?(map: Map) {}
    func mapping(map: Map) {
        title <- map["title"]
        model <- map["models"]
    }
}



