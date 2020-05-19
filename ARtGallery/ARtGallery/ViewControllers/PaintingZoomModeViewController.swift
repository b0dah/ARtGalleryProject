//
//  PaintingZoomModeViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 19.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class PaintingZoomModeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topImageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingImageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var trialingImageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomImageViewConstraint: NSLayoutConstraint!
    
    var imageData: Data?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        guard let data = self.imageData else {
            print("No imagedata passed!")
            return
        }
        
        self.imageView.image = UIImage(data: data)
        
        updateConstraintsForSize(view.bounds.size)

    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
      let widthScale = size.width / imageView.bounds.width
      let heightScale = size.height / imageView.bounds.height
      let minScale = min(widthScale, heightScale)
        
      scrollView.minimumZoomScale = minScale
      scrollView.zoomScale = minScale
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
//

    
   
    
    
}

extension PaintingZoomModeViewController: UIScrollViewDelegate {
//
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    //1
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//      updateConstraintsForSize(view.bounds.size)
//    }

    //2
    func updateConstraintsForSize(_ size: CGSize) {
      //3
        
        let height: CGFloat = self.view.bounds.size.height - (self.navigationController?.navigationBar.frame.size.height)!;
        
        let yOffset = max(0, (height - imageView.frame.height) / 2)
        topImageViewConstraint.constant = yOffset
        bottomImageViewConstraint.constant = yOffset
        
        //4
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        leadingImageViewConstraint.constant = xOffset
        trialingImageViewConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
}


