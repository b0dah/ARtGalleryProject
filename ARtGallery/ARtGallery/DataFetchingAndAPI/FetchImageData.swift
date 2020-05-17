//
//  FetchImageData.swift
//  ARtGallery
//
//  Created by Иван Романов on 14.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension MuseumDetailsViewController {

    func downloadImageDataWithCompletion(from url: String, completion: @escaping (Data?)->Void) {
        print(url)
        guard let url = URL(string: url) else {
            print("Wrong IMAGE URL!")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Http response error")
                completion(nil)
                return
            }
            
            print("download finished")
            
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
    
}
