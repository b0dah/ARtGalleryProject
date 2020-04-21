//
//  Emoji.swift
//  TableViewExample
//
//  Created by Иван Романов on 19.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

class Museum {
    var imageName: String
    var name: String
    var city: String
    
    init(name: String, city: String) {
        self.imageName = name.filter {!$0.isWhitespace} + ".jpg"
        self.name = name
        self.city = city
    }
}
