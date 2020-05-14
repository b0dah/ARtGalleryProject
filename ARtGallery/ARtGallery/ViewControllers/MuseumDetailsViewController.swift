//
//  MuseumDetailsViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 01.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit
import ARKit

class MuseumDetailsViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var appearenceImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resourcesButton: ARResourcesButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Class Fields
    var paintings : [Painting]?
    var referenceImages = Set<ARReferenceImage>()
    
    var museum: Museum?
    var museumAssetCatalogName: String?
    
    let context = DataBaseManager.sharedInstance.persistentContainer.viewContext
    
    @IBAction func resourcesButtonTapped(_ sender: ARResourcesButton) {
        
//        if sender.titleLabel?.text == "Go to AR Experience" {
//            performSegue(withIdentifier: "PresentExplorationMode", sender: self)
//            return
//        }
//
//        if let museum = museum {
//
//            self.downloadResourcesButton.showLoading()
//
//            // ! moving to Secondary thread
//            DispatchQueue.global().async {
//                let dispatchGroup = DispatchGroup()
//
//                //1.
//                dispatchGroup.enter()
//                self.fetchPaintingsListForMuseum(url: Constants.paintingListForPArticularMuseumEndpoint, museumId: museum.id) {
//                        dispatchGroup.leave()
//                    }
//                dispatchGroup.wait()
//
//                //2.
//                dispatchGroup.enter()
//                self.fetchImagesForAllPaintings{
//                    dispatchGroup.leave()
//                }
//                dispatchGroup.wait()
//
//                //3.
//                dispatchGroup.enter()
//                self.createReferenceImageSet{
//                    dispatchGroup.leave()
//                }
//                dispatchGroup.wait()
//
//                // To main thread
//                DispatchQueue.main.async {
//                    print("Number of assets created: \(self.referenceImages.count)")
//                    self.downloadResourcesButton.hideLoading()
//                    self.downloadResourcesButton.setTitle("Go to AR Experience", for: .normal)
//                    self.downloadResourcesButton.setImage(UIImage(systemName: "arrow.left.circle"), for: .normal)
//                }
//            }
//
//        } else {
//            print("No museum object")
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let museum = museum else {
            print("No museum passed!")
            return
        }
            
        updateUI()
        
        // MARK:- lifecycle
        
        ///1. fetch paintings array and check for relevance
        fetchPaintingsListForMuseum(url: Constants.paintingListForPArticularMuseumEndpoint, museumId: museum.id) { (array) in
            if let paintingsArray = array {
                print()

                // Compare Counts
                print("Count in DB is :")
                if let localPaintingsCount = self.getNumberOfPaintingsForMuseum(museumId: museum.id, context: self.context) {

                    if paintingsArray.count == localPaintingsCount {
                        print("first cond: OK")

                        // Compare IDs Sets
                        if let remotePaintingsIDs = self.getPaintingsIDsForMuseumFromArray(paintingsArray: paintingsArray)
                            , let localPaintingsIDs = self.getPaintingsIDsForMuseumFromCoreData(museumId: museum.id, context: self.context) {

                            if remotePaintingsIDs == localPaintingsIDs {
                                print("second cond: OK")
                                
                                self.resourcesButton.customState = .preparing
                                self.fetchPaintingsFromLocalStorage(context: self.context)
                                print(self.paintings?.count)                                
                                
                            } else {
                                print("second condition: failed")
                                self.resavePaintingsLocally(jsonPaintingsArray: paintingsArray, context: self.context)
                            }

                        } else {
                            print("Makin' up IDs list failed!")
                        }
                    }
                    else {
                        print("first condition: failed")
                        self.resavePaintingsLocally(jsonPaintingsArray: paintingsArray, context: self.context)
                    }

                } else {
                    print("Can't count local paintings")
                }
            } else {
                print("nil dict passed in the closure")
            }

        }
        
    }
    
    // MARK: - UI Drawing
    func updateUI() {
        if let museum = museum {
            self.nameLabel.text = museum.name
            self.locationLabel.text = museum.city + ", " + museum.country
            self.descriptionLabel.text = "  " + museum.description
            
            //images
            let urlToAppearenceImage = Constants.museumsAppearencesPath + museum.appearenceImageTitle
            print(urlToAppearenceImage)
            self.appearenceImage.downloadImage(from: urlToAppearenceImage)
            
            let urlToLogoImage = Constants.museumsLogosPath + museum.logoImageTitle
            self.logoImageView.downloadImage(from: urlToLogoImage)
            
            // button
            self.resourcesButton.layer.cornerRadius = 10
            self.resourcesButton.clipsToBounds = true
//            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "PresentExplorationMode" else {
            print("Not a segue to the exploration mode")
            return
        }
        
        if let destination = segue.destination as? ExplorationViewController {
            destination.referenceImages = referenceImages
        } else {
            print("Casting To ExplorationViewController failed")
        }
    }
    
   
}
