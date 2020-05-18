//
//  RecognizedPainting+CoreDataProperties.swift
//  ARtGallery
//
//  Created by Иван Романов on 17.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//
//

import Foundation
import CoreData


extension RecognizedPainting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecognizedPainting> {
        return NSFetchRequest<RecognizedPainting>(entityName: "RecognizedPainting")
    }

    @NSManaged public var paintingId: Int32

}
