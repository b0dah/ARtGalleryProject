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
    
    var museum: Museum?
    var museumAssetCatalogName: String?
    
    // Fields
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
        
        guard let museum = museum else {
            print("No museum passed!")
            return
        }
        
        //  print(museum.name + " situated in " + museum.city)
        
        // Ref Images Set Name
        museumAssetCatalogName = museum.name
        guard let refereceImages = ARReferenceImage.referenceImages(inGroupNamed: museumAssetCatalogName!, bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = refereceImages
        
        self.sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK:- ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        
        print("Painting detected!")
        DispatchQueue.main.async {
            self.feedbackLabel.text = "Painting Detected!"
        }
        
        let referenceImage = imageAnchor.referenceImage
        let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = UIColor.cyan
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.opacity = 0.3
        planeNode.eulerAngles.x = -Float.pi/2
        
        planeNode.runAction(highlightPaintingAction)
        node.addChildNode(planeNode)
        
        let titleNode = createPaintingTitleNode(paintingName: referenceImage.name!)
        node.addChildNode(titleNode)
        
    }
    
    var highlightPaintingAction: SCNAction {
        return .sequence([ .fadeIn(duration: 1.0), .wait(duration: 0.5), .fadeOut(duration: 1.0), .removeFromParentNode()])
    }
    
    
    //MARK: - Text Creation Functionality
    private func createPaintingTitleNode(paintingName: String) -> SCNNode {
        let title = SCNText(string: paintingName, extrusionDepth: 0.5)
        let titleNode = SCNNode(geometry: title)
        
        titleNode.scale = SCNVector3(0.003, 0.003, 0.002)
        titleNode.position = SCNVector3(0,0,0)
        titleNode.eulerAngles.x = -Float.pi/2
        return titleNode
    }
    
    
}
