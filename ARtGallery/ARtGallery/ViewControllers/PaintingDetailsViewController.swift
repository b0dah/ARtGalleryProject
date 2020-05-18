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
    @IBOutlet weak var authorView: UIView!
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
            
            // touch Handler
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.authorViewTapped(_:)))
            self.authorView.addGestureRecognizer(tapRecognizer)
        }
        
        self.ttitleLabel.text = painting?.title
        self.descriptionLabel.text = painting!.details
        self.linkButton.layer.cornerRadius = self.linkButton.frame.height/4
        
    }
    
    @objc func authorViewTapped(_ sender: UITapGestureRecognizer? = nil) {
        performSegue(withIdentifier: "PresentArtistDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let artistToPass = self.painting?.author else {
            fatalError("No artist to pass")
        }
        
        if let destination = segue.destination as? ArtistDetailsViewController {
            destination.artist = artistToPass
        } else {
            print("wrong segue")
        }
    }
}
