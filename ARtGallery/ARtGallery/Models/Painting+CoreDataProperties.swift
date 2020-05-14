//
//  Painting+CoreDataProperties.swift
//  ARtGallery
//
//  Created by Иван Романов on 14.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//
//

import Foundation
import CoreData


extension Painting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Painting> {
        return NSFetchRequest<Painting>(entityName: "Painting")
    }

    @NSManaged public var details: String
    @NSManaged public var genre: String
    @NSManaged public var id: Int32
    @NSManaged public var image: Data?
    @NSManaged public var imageName: String
    @NSManaged public var museumId: Int32
    @NSManaged public var physicalHeight: Double
    @NSManaged public var physicalWidth: Double
    @NSManaged public var title: String
    @NSManaged public var year: Int16
    @NSManaged public var author: Artist?

}
