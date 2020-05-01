//
//  Emoji.swift
//  TableViewExample
//
//  Created by Иван Романов on 19.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

class FetchedObject: Codable {
    var museums: [Museum]
}

class Museum: Codable {
    var id: Int
    var name: String
    var country: String
    var city: String
    var description: String
    var logoImagePath: String
    var appearenceImagePath: String
    
    init(id: Int, name: String, country: String, city: String, description: String, logoImagePath: String, appearenceImagePath: String) {
        self.id = id
        self.name = name
        self.country = country
        self.city = city
        self.description = description
        self.logoImagePath = logoImagePath
        self.appearenceImagePath = appearenceImagePath
    }
}
