//
//  FetchPaintingsListExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 02.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension MuseumDetailsViewController {
    
    func fetchPaintingsListForMuseum(url: String, museumId: Int, completion: @escaping ()->Void) {
                
        let parameters = ["museum_id" : String(museumId)]
        
        guard let url = URL(string: url)?.withQueries(parameters) else {
            print("WRONG Endpoint URL for the paintings list")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil, response != nil else {
                print("http request error! " + error.debugDescription)
                return
            }
                
            do {

                let jsonDecoder = JSONDecoder()
                let fetchedObject = try jsonDecoder.decode(FetchedPaintingsObject.self, from: data)
                
//           Start some async maybe {
                self.paintings = fetchedObject.paintings
                
                print("1 paintings fetched: ")
                print(self.paintings)
                
                completion()
                
//                for painting in self.paintings! {
//                    self.fetchAndSavePaintingImage(painting: painting)
//                }
                
                
//                self.createReferenceImageSet(completion:  {
//                    DispatchQueue.main.async {
//                        self.downloadResourcesButton.titleLabel?.text = "Go to AR!"
//                    }
//                })
                
            }
            catch {
                print("JSON parsing error!")
            }
            
        }.resume()
        
    }
    
    
    // MARK: - IMAGES
//    func fetchAndSavePaintingImage(painting: Painting) {
//
//        guard let url = URL(string: Constants.paintingsReproductionsPath + painting.imageTitle) else {
//            print("WRONG URL to the image")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data, error == nil, response != nil  else {
//                print("http request error! " + error.debugDescription)
//                return
//            }
//
//            if let image = UIImage(data: data) {
//                // Here is some async queue maybe
//                painting.image = image
//            }
//            else {
//                print("Couldn't parse as an Image")
//            }
//        }.resume()
//    }
    func fetchImagesForAllPaintings(completion: @escaping ()->Void) {
        
        guard self.paintings != nil else {
            print("no paintings prefetched!")
            return
        }
        
        for painting in self.paintings! {
            guard let url = URL(string: Constants.paintingsReproductionsPath + painting.imageTitle) else {
                print("wrong url for the current image!")
                return//continue
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let data = data, error == nil, response != nil  else {
                    print("http request error! " + error.debugDescription)
                    return
                }
                
                if let image = UIImage(data: data) {
                    // Here is some async queue maybe
                    painting.image = image
                    print("2: image" + painting.title + " downloaded")
                    completion()
                }
                else {
                    print("Couldn't parse as an Image")
                }
                
            }.resume()
            
           
        }
    }
}
