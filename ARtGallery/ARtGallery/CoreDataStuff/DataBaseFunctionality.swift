//
//  DataBaseFunctionality.swift
//  ARtGallery
//
//  Created by Иван Романов on 17.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import CoreData

extension DataBaseManager {
    
    func getPaintingObjectWithImageTitle(imageTitle: String) -> Painting? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PaintingKeys.entityName)
        
        fetchRequest.predicate = NSPredicate(format: "ANY imageName = %@", imageTitle)
        
        do {
            let paintingsArray = try self.persistentContainer.viewContext.fetch(fetchRequest) as? [Painting]
            if let desiredPainting = paintingsArray?[0] {
                return desiredPainting
            } else {
                print("No paintings found")
                return nil
            }
            
        } catch let error as NSError {
            print("Couldn't fetch full paintings : \(error) \(error.userInfo)")
            return nil
        }
        
    }
    
    func getPaintingObjectWithId(id: Int32) -> Painting? {
        
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PaintingKeys.entityName)
        let fetchRequest: NSFetchRequest<Painting> = Painting.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ANY id = %@", NSNumber(value: id))
        
        do {
            let paintingsArray = try self.persistentContainer.viewContext.fetch(fetchRequest) as? [Painting]
            if let paintingsArray = paintingsArray, paintingsArray.count > 0 {
                return paintingsArray[0]
            } else {
                print("No paintings found")
                return nil
            }
            
        } catch let error as NSError {
            print("Couldn't fetch full paintings : \(error) \(error.userInfo)")
            return nil
        }
    }
    
    func getPaintingsArrayWithIdsArray(ids: [Int32]) -> [Painting] {
        
        var result: [Painting] = []
        
        ids.map {
            guard let painting = getPaintingObjectWithId(id: $0) else {
                print("No such painting in current DB State")
                return
            }
            
            result.append(painting)
        }
        
        return result
    }
    
    func savePaintingToRecognized(id: Int32) {
        
        let recosnizedPainting = RecognizedPainting(context: self.persistentContainer.viewContext)
        recosnizedPainting.paintingId = id
        
        do {
            try self.persistentContainer.viewContext.save()
            print("Saved To Recognized")
        } catch let error as NSError {
            print("Couldn't save to recognized! \(error) \(error.userInfo)")
        }
    }
    
    func getRecongnizedPaintingsIDs() -> [Int32]? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: RecognizedPaintingsKeys.entityName)
        var result: [Int32] = []
        
        do {
            let paintings = try self.persistentContainer.viewContext.fetch(request) as? [RecognizedPainting]
            
            guard paintings != nil else {
                print("Nil array!")
                return nil
            }
            
            for painting in paintings! {
                result.append(painting.paintingId)
            }
            return result
        } catch let error as NSError {
            print("\(error) \(error.userInfo)")
            return nil
        }
    }
    
}
