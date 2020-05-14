//
//  FetchPaintingsListExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 02.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension MuseumDetailsViewController {
    
    func fetchPaintingsListForMuseum(url: String, museumId: Int, completion: @escaping ([[String: AnyObject]]?)->Void) {
                
        let parameters = ["museum_id" : String(museumId)]
        
        guard let url = URL(string: url)?.withQueries(parameters) else {
            print("WRONG Endpoint URL for the paintings list")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil, response != nil else {
                print("http request error! " + error.debugDescription)
                completion(nil)
                return
            }
                
            do {
                
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    
                    guard let paintingsArray = jsonArray["paintings"] as? [[String: AnyObject]] else {
                        print("Couldn't retrieve array with key\"paintings\"")
                        completion(nil)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(paintingsArray)
                    }
                    
                    
                } else {
                    print("Can't create json object")
                }
                
            }
            catch let error as NSError {
                print("JSON parsing error : \(error.userInfo)")
            }
            
        }.resume()
        
    }
    
//    func fetchImagesForAllPaintings(completion: @escaping ()->Void) {
//
//        guard self.paintings != nil else {
//            print("no paintings prefetched!")
//            return
//        }
//
//        let dispatchGroup = DispatchGroup()
//
//        // Interate over all the paintings
//        for painting in self.paintings! {
//
//            dispatchGroup.enter()
//
//            guard let url = URL(string: Constants.paintingsReproductionsPath + painting.imageTitle) else {
//                print("wrong url for the current image!")
//                return//continue
//            }
//
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//                guard let data = data, error == nil, response != nil  else {
//                    print("http request error! " + error.debugDescription)
//                    return
//                }
//
//                if let image = UIImage(data: data) {
//                    // Here is some async queue maybe
//                    painting.image = image
//                    print("2: image" + painting.title + " downloaded")
//                }
//                else {
//                    print("Couldn't parse as an Image")
//                }
//
//                dispatchGroup.leave()
//
//            }.resume()
//
//
//        }
//
//        dispatchGroup.notify(queue: .global()) {
//            completion()
//        }
//    }
    
}
    
    
