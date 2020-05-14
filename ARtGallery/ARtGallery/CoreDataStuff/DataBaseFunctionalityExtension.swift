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
    
    func getPaintingsIDsForMuseumFromCoreData(museumId: Int, context: NSManagedObjectContext) -> Set<Int>? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: PaintingKeys.entityName)
        request.predicate = NSPredicate(format: "ANY museumId = %@", NSNumber(value: museumId))
        request.propertiesToFetch = ["id"]
        request.resultType = .dictionaryResultType
        
        var result = Set<Int>()
        
        do {
            if  let fetchedIDsArray = try context.fetch(request) as? [NSDictionary] {
                fetchedIDsArray.map { result.insert($0["id"] as! Int) }
                return result
            } else {
                print("Can't convert as specified!")
            }
        } catch let error as NSError {
            print("Error fetching \(error) \(error.userInfo)")
        }
        
        return nil
    }
    
    func getPaintingsIDsForMuseumFromArray(paintingsArray: [[String: AnyObject]]) -> Set<Int>? {
        var result = Set<Int>()
        
        do {
            try paintingsArray.map {
                if let id = try $0["id"] as? Int {
                    result.insert(id)
                } else {
                    print("error")
                }
            }
            return result
        } catch {
            print("error mapping array")
            return nil
        }
    }
    
    func resavePaintingsLocally(jsonPaintingsArray: [[String: AnyObject]], context: NSManagedObjectContext) {
        
        let dispatchGroup = DispatchGroup()
        
        clearLocalPaintings(context: context)
        
        jsonPaintingsArray.map {
            
            dispatchGroup.enter()
            
            guard let imageName = $0[PaintingKeys.imageName] as? String else {
                print("Can't parse imageName")
                return
            }
            
            let currentPaintingDict = $0
            let currentEntity = self.createPaintingEntity(context: context, dictionary: currentPaintingDict)
            
            self.downloadImageDataWithCompletion(from: Constants.paintingsReproductionsPath + imageName) {
                (data) in
                if let imageData = data {
                    currentEntity?.image = imageData
                }
                dispatchGroup.leave()
            }
        }
        
        
        dispatchGroup.notify(queue: .global()) {
        
            do {
                try context.save()
                print("Saved!")
            } catch let error {
                print(error)
            }
        }
    }
    
    
    func clearLocalPaintings(context: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PaintingKeys.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            print("error \(error) \(error.userInfo)")
        }
    }
    
    
    func fetchPaintingsFromLocalStorage(context: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PaintingKeys.entityName)
        
        do {
            self.paintings = try context.fetch(fetchRequest) as? [Painting]
            print("fetched!")
        } catch let error as NSError {
            print("Couldn't fetch full paintings : \(error) \(error.userInfo)")
        }
    }
    
        
    
    
    
}
