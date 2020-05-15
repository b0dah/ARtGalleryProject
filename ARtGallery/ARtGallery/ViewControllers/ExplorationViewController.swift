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
    
    // Private Fields
    private let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        // sceneView conf
        sceneView.showsStatistics = true
//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
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
    
}
