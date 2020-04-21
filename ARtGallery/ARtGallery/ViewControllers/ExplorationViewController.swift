//
//  ExplorationViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 19.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit
import ARKit

class ExplorationViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var museum: Museum?
    
    // Fields
    private let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let museum = museum {
            print(museum.name + " situated in " + museum.city)
        }
        
        // sceneView conf
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}
