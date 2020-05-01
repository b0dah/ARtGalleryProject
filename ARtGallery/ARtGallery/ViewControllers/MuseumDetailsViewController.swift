//
//  MuseumDetailsViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 01.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class MuseumDetailsViewController: UIViewController {
    
    var museum: Museum?
    var museumAssetCatalogName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let museum = museum else {
            print("No museum passed!")
            return
        }
    }
    
   
}
