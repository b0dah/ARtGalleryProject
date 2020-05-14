//
//  DataBaseFunctionalityExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 14.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import CoreData

extension MuseumDetailsViewController {
    
    func getNumberOfPaintingsForMuseum(museumId: Int, context: NSManagedObjectContext) -> Int? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: PaintingKeys.entityName)
        request.predicate = NSPredicate(format: "ANY museumId = %@", NSNumber(integerLiteral: museumId))
        
        do {
            let count = try context.count(for: request)
            return count
        } catch let error as NSError {
            print("Error counting rows in CoreData \(error.userInfo)")
            return nil
        }
    }
}
