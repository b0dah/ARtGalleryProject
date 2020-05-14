//
//  Artist+CoreDataProperties.swift
//  ARtGallery
//
//  Created by Иван Романов on 14.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist")
    }

    @NSManaged public var country: String
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var portraitImageTitle: String
    @NSManaged public var yearsOfLife: String
    @NSManaged public var portraitImage: Data?

}
