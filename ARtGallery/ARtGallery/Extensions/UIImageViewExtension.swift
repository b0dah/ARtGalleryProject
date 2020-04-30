//
//  UIImageViewExtension.swift
//  TableViewExample
//
//  Created by Иван Романов on 20.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func makeRounded() {
        // pictureView.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    func downloadImage(from url: String) {
        
        guard let url = URL(string: url) else {
            print("Wrong IMAGE URL!")
            return
        }
           
       URLSession.shared.dataTask(with: url) { (data, response, error) in
           guard let data = data, error == nil else {
               return
           }
               
            print("download finished")
//            print(response?.suggestedFilename!)
               
               DispatchQueue.main.async {
                self.image = UIImage(data: data)
               }
           }.resume()
       }
}
