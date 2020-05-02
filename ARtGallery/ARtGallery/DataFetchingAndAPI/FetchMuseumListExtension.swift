//
//  FetchMuseumListExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 30.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension MuseumSelectionTableViewController {
    
    func fetchMuseumList(url: String) {
        
        guard let url = URL(string: url) else {
            print("WRONG Endpoint URL for the museums list")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil, response != nil else {
                print("http request error!")
                return
            }
                        
            do {
//                let stringData = String(data: data, encoding: .utf8)
//                print(stringData)
                let jsonDecoder = JSONDecoder()
                
                let fetchedObject = try jsonDecoder.decode(FetchedMuseumsObject.self, from: data)
                
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
