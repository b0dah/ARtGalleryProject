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
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 1
//        self.layer.shadowOffset = CGSize.zero
//        self.layer.shadowRadius = 10
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
    }
    
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 6
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
//        self.layer.cornerRadius = cornerRadious
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
