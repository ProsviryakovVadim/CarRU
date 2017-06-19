//
//  Form.swift
//  CarsSell
//
//  Created by Vadim on 5/19/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import ObjectMapper


final class Marks: Mappable {
    private(set) var marks: [Models] = []
    
    init?(map: Map) {}
    func mapping(map: Map) {
        marks <- map["marks"]
    }
}

final class Models: Mappable {
    private(set) var title: String = ""
    private(set) var model: [String] = []
    
    init?(map: Map) {}
    func mapping(map: Map) {
        title <- map["title"]
        model <- map["models"]
    }
}




