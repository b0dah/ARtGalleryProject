//
//  PaintingZoomModeViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 19.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class PaintingZoomModeViewController: UIViewController {
    
    var imageData: Data?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data = self.imageData else {
            print("No imagedata passed!")
            return
        }
        
        self.imageView.image = UIImage(data: data)
    }
    
    
}
