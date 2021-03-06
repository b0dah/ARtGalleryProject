//
//  ExplorationViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 19.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ExplorationViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    var referenceImages: Set<ARReferenceImage>?
    var lastRecognizedPainting: Painting?
    
    // Private Fields
    private let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        // sceneView conf
        sceneView.showsStatistics = true
//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        self.sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard referenceImages != nil else {
            print("No reference images array passed!")
            return
        }
        print(self.referenceImages?.count)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = self.referenceImages!

        self.sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "PresentPaintingDetails":
            if let destination = segue.destination as? PaintingDetailsViewController {
                destination.painting = lastRecognizedPainting
            } else {
                fatalError("Couldn't prepare segue to Painting Details Screen")
            }
        
        case "PresentAuthorDetails":
            if let destination = segue.destination as? ArtistDetailsViewController,
                let artist = self.lastRecognizedPainting?.author {
                destination.artist = artist
            } else {
                fatalError("Couldn't prepare segue to Artist Details Screen")
            }
            
        default:
            print("Wrong Segue Identifier")
        }
    }
    
}
