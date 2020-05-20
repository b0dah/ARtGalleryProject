//
//  MuseumDetailsViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 01.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//




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

//************************************************************************************

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
    var paintingsJSONArray: [[String: AnyObject]]?
    var paintings : [Painting]?
    var referenceImages = Set<ARReferenceImage>()
    var museum: Museum?
    
    let context = DataBaseManager.sharedInstance.persistentContainer.viewContext
    
    @IBAction func resourcesButtonTapped(_ sender: ARResourcesButton) {
                
        switch sender.customState {
            
        case .readyToGoToAR:
            performSegue(withIdentifier: "PresentExplorationMode", sender: self)
            return
            
        case .readyToDownload:
            
            sender.customState = .downloading
            
            guard let paintingsJSONArray = self.paintingsJSONArray else {
                fatalError("no array downloaded")
            }
            
            DispatchQueue.global().async { // ! moving to Secondary thread
            
                let dispatchGroup = DispatchGroup()
                
                dispatchGroup.enter()
                
                // Sself.AVE TO COREDATA
                self.resavePaintingsLocally(jsonPaintingsArray: paintingsJSONArray, context: self.context) { (error) in
                    guard error ==  nil else {
                        dispatchGroup.leave()
                        return
                    }
                    
                    dispatchGroup.leave()
                }
                dispatchGroup.wait()
                
                
                self.fetchPaintingsFromLocalStorage(context: self.context) {
                    (error) in
                    
                    guard error == nil else {
                        print("fetch failed")
                        return
                    }
                }
                
                dispatchGroup.enter()
                self.createReferenceImageSet{
                    dispatchGroup.leave()
                }
                dispatchGroup.wait()
                
                // To main thread
                DispatchQueue.main.async {
                    guard self.referenceImages.count > 0 else {
                        print("No assets created")
                        return
                    }
                    print("Number of new assets created: \(self.referenceImages.count)")
                    sender.customState = .readyToGoToAR
                }
            }
            
        default:
            print("WRONG BUTTON STATE!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(Constants.pathToDocuments)
        
        guard let museum = museum else {
            print("No museum passed!")
            return
        }
            
        updateUI()
        
        self.resourcesButton.customState = .preparing
        // MARK:- lifecycle
        
        DispatchQueue.global().async {
            
            let dispatchGroup = DispatchGroup()

            ///1. fetch paintings array
            dispatchGroup.enter()

            self.fetchPaintingsListForMuseum(url: Constants.paintingListForPArticularMuseumEndpoint, museumId: museum.id) { (array) in
                if array != nil {
                    self.paintingsJSONArray = array
                    dispatchGroup.leave()
                } else {
                    print("Downloaded nil array")
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.wait()

            
            guard let paintingsJSONArray = self.paintingsJSONArray else {
                print("nil array")
                return
            }

            // 2. MARK: - Checks for relevance
            ///. Compare Counts
            guard let localPaintingsCount = self.getNumberOfPaintingsForMuseum(museumId: museum.id, context: self.context) else {
                print("Can't count local paintings")
                self.switchResourcesButtonToReadyToDownloadState()
                return
            }

            /// Compare IDs Sets
            guard let remotePaintingsIDs = self.getPaintingsIDsForMuseumFromArray(paintingsArray: paintingsJSONArray), let localPaintingsIDs = self.getPaintingsIDsForMuseumFromCoreData(museumId: museum.id, context: self.context) else {
                print("Makin' up IDs list failed!")
                self.switchResourcesButtonToReadyToDownloadState()
                return
            }

            guard paintingsJSONArray.count == localPaintingsCount  else {
                print("first condition: failed")
                self.resourcesButton.customState = .readyToDownload
                return
            }
            print("first cond: OK")

            guard remotePaintingsIDs == localPaintingsIDs else {
                print("second condition: failed")
                self.switchResourcesButtonToReadyToDownloadState()
                return
            }
            print("second cond: OK")

            // Set in CoreData storage is relevant
//            dispatchGroup.enter()
            self.fetchPaintingsFromLocalStorage(context: self.context) { (error) in
                guard error == nil else {
                    print("fetch failed")
//                    dispatchGroup.leave()
                    return
                }
//                dispatchGroup.leave()
            }
//            dispatchGroup.wait()

            ///2
            dispatchGroup.enter()
            self.createReferenceImageSet{
                dispatchGroup.leave()
            }
            dispatchGroup.wait()

            ///3
            DispatchQueue.main.async {
                guard self.referenceImages.count > 0 else {
                    print("No assets created")
                    return
                }
                print("Number of assets created: \(self.referenceImages.count)")
                self.resourcesButton.customState = .readyToGoToAR
            }

        }
    }
    
    func switchResourcesButtonToReadyToDownloadState() {
        DispatchQueue.main.async {
            self.resourcesButton.customState = .readyToDownload
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
