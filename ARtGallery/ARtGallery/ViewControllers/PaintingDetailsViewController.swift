//
//  PaintingDetailsViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 18.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class PaintingDetailsViewController: UIViewController {
    @IBOutlet weak var ttitleLabel: UILabel!
    @IBOutlet weak var paintingImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    var painting: Painting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard painting != nil else {
            print("Received np painting")
            return
        }
        
        updateUI()
    }
    
    func updateUI() {
        
        if let imageData = painting?.image {
            self.paintingImageView.image = UIImage(data: imageData)
        }
        
        if let author = painting?.author {
            self.authorLabel.text = author.name
            if let authorImageData = author.portraitImage {
                self.authorImageView.image = UIImage(data: authorImageData)
            }
        }
        
        self.ttitleLabel.text = painting?.title
        self.descriptionLabel.text = painting!.details
        
        
    }
}
