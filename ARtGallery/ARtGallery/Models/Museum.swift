//
//  Emoji.swift
//  TableViewExample
//
//  Created by Иван Романов on 19.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

class FetchedMuseumsObject: Codable {
    var museums: [Museum]
}

class Museum: Codable {
    var id: Int
    var name: String
    var country: String
    var city: String
    var description: String
    var logoImageTitle: String
    var appearenceImageTitle: String
    
    init(id: Int, name: String, country: String, city: String, description: String, logoImageTitle: String, appearenceImageTitle: String) {
        self.id = id
        self.name = name
        self.country = country
        self.city = city
        self.description = description
        self.logoImageTitle = logoImageTitle
        self.appearenceImageTitle = appearenceImageTitle
    }
}
