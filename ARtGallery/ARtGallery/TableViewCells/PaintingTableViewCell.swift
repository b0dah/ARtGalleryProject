//
//  PaintingTableViewCell.swift
//  ARtGallery
//
//  Created by Иван Романов on 21.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class PaintingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func updateUI(painting: Painting) {
//        backView.layer.cornerRadius = pictureView.frame.width / 4
//        
//        pictureView.image = UIImage(named: painting.imageTitle)
//        titleLabel.text = painting.title + ", " + String(painting.year)
//        
//        authorLabel.text = "CHANGE IT"//painting.author
        
    }

}
