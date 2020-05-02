//
//  FetchPaintingsListExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 02.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension MuseumDetailsViewController {
    
    func fetchPaintingsListForMuseum(url: String, museumId: Int) {
        
//        print("\n" + String(museumId))
        
        let parameters = ["museum_id" : String(museumId)]
        
        guard let url = URL(string: url)?.withQueries(parameters) else {
            print("WRONG Endpoint URL for the paintings list")
            return
        }
        
        print(url.absoluteString)
        print()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil, response != nil else {
                print("http request error! " + error.debugDescription)
                return
            }
                
            do {
//                let jsonString = String(data: data, encoding: .utf8)
//                print()
//                print(jsonString)
//                print()
                let jsonDecoder = JSONDecoder()
                let fetchedObject = try jsonDecoder.decode(FetchedPaintingsObject.self, from: data)
                print(fetchedObject.paintings)
                DispatchQueue.main.async {
                    self.paintings = fetchedObject.paintings
                    print(self.paintings)
                }
            }
            catch {
                print("JSON parsing error!")
            }
            
        }.resume()
        
    }
}
