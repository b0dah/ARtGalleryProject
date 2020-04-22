//
//  Painting.swift
//  ARtGallery
//
//  Created by Иван Романов on 21.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

class Painting {
    var title: String
    var author: String
    var year: Int
    var imageTitle: String
    
    init(title: String, author: String, year: Int) {
        self.title = title
        self.author = author
        self.year = year
        self.imageTitle = author + " - " + title + ".jpg"
    }
}
