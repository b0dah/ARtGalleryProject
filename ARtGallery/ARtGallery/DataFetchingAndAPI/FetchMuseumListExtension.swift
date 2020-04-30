//
//  FetchMuseumListExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 30.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension MuseumSelectionTableViewController {
    
    func fetchMuseumList() {
        
        URLSession.shared.dataTask(with: Constants.museumsListAPIEndpoint) { (data, response, error) in
            
            guard let data = data, error == nil, response != nil else {
                print("http request error!")
                return
            }
                        
            do {
                let stringData = String(data: data, encoding: .utf8)
//                print(stringData)
                let jsonDecoder = JSONDecoder()
                
                let fetchedObject = try jsonDecoder.decode(FetchedObject.self, from: data)
                
                self.museums = fetchedObject.museums
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            catch {
                print("JSON parsing error!")
            }
        }.resume()
        
        
    }
}
