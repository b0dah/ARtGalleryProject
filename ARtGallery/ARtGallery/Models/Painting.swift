//
//  Painting.swift
//  ARtGallery
//
//  Created by Иван Романов on 21.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

class FetchedPaintingsObject: Codable {
    var paintings: [Painting]
}

class Painting: Codable {
    var id: Int
    var title: String
    var year: Int
    var description: String
    var author: Artist
    var genre: String
    var museumId: Int
    var imageTitle: String
    var physicalWidth: Double
    var physicalHeight: Double
    
    init(id: Int, title: String, year: Int, description: String, author: Artist, genre: String, museumId: Int, imageTitle: String, physicalWidth: Double, physicalHeight: Double) {
        self.id = id
        self.title = title
        self.year = year
        self.author = author
        self.genre = genre
        self.museumId = museumId
        self.description = description
        self.imageTitle = imageTitle
        self.physicalWidth = physicalWidth
        self.physicalHeight = physicalHeight
    }
}
