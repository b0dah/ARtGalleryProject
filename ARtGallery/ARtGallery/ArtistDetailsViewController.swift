//
//  ArtistDetailsViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 19.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class ArtistDetailsViewController: UIViewController {
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    var artist: Artist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let artist = self.artist else {
            print("No artist passed!")
            return
        }
        
        updateUI(artist: artist)
    }
    
    func updateUI(artist: Artist) {
        
        self.nameLabel.text = artist.name
        self.descriptionLabel.text = artist.yearsOfLife + "\n" + artist.biography
        self.countryLabel.text = artist.country
        
        if let artistImageData = artist.portraitImage {
            self.portraitImageView.image = UIImage(data: artistImageData)
        }
        
        self.linkButton.layer.cornerRadius = self.linkButton.frame.height/4
    }
    
    
    @IBAction func linkButtonTapped(_ sender: Any) {
        guard let artist = self.artist else {return}
        if let url = URL(string: artist.link) {
            UIApplication.shared.open(url)
        }
    }
}
