//
//  VisualEffectsForRegognizedImageExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 23.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import ARKit
import SceneKit

extension ExplorationViewController {
    
    // MARK:- ARSCNViewDelegate
    
    var highlightPaintingAction: SCNAction {
        return .sequence([ .fadeIn(duration: 1.0), .wait(duration: 0.5), .fadeOut(duration: 1.0), .removeFromParentNode()])
    }
       
       
   //MARK: - Text Creation Functionality
   func createPaintingTitleNode(paintingName: String) -> SCNNode {
       let title = SCNText(string: paintingName, extrusionDepth: 0.5)
       let titleNode = SCNNode(geometry: title)
       
       titleNode.scale = SCNVector3(0.0015, 0.0015, 0.002)

//       titleNode.position = SCNVector3(0.0,0,-0.1)
    titleNode.pivot = SCNMatrix4MakeTranslation(0, 0, 0)
       titleNode.eulerAngles.x = -Float.pi/2
       return titleNode
   }
    
    func createPaintingDescriptionNode(description: String) -> SCNNode {
        let descriptionTextGeometry = SCNText(string: description, extrusionDepth: 0.7)
        let descriptionNode = SCNNode(geometry: descriptionTextGeometry)
        
        descriptionNode.scale = SCNVector3(0.0008, 0.0008, 0.001)
        descriptionNode.position = SCNVector3(0.07, 0, 0.0)
        
        // material
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemYellow
        descriptionTextGeometry.materials = [material]
        
        // form
        let billboardConstraint = SCNBillboardConstraint()
        descriptionNode.constraints = [billboardConstraint]
        
        return descriptionNode
    }
    
    // MARK: - Author Node with Picture
    
    func createAuthorNode(authorName: String) -> SCNNode {
        let artistImageView = UIImageView(image: UIImage(named: authorName))
        
        let material = SCNMaterial()
        material.diffuse.contents = artistImageView
            
        let imageGeometry = SCNPlane()
        imageGeometry.materials = [material]
        
        let imageNode = SCNNode(geometry: imageGeometry)
        imageNode.eulerAngles.x = -.pi/2
        imageNode.scale = SCNVector3(0.1,0.1,0.1)
        imageNode.position = SCNVector3(0.07, 0, 0.03)
            
        return imageNode
    }
}


