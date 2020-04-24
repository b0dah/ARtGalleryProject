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
    func createPaintingTitleNode(paintingName: String, paintingSize: CGSize) -> SCNNode {
        let title = SCNText(string: paintingName, extrusionDepth: 0.5)
        let titleNode = SCNNode(geometry: title)
        
        let xPosition = -paintingSize.width/2.0
        let zPosition = -paintingSize.height/2.0-Constants.scenePaddingWidth
        
        
        
        titleNode.position = SCNVector3(xPosition,0,zPosition)
        
        titleNode.scale = SCNVector3(0.0015, 0.0015, 0.002)
//    titleNode.pivot = SCNMatrix4MakeTranslation(0, 0, 0)
       titleNode.eulerAngles.x = -Float.pi/2
       return titleNode
   }
    
    func createPaintingDescriptionNode(description: String, paintingSize: CGSize) -> SCNNode {
        let descriptionTextGeometry = SCNText(string: description, extrusionDepth: 0.7)
        let descriptionNode = SCNNode(geometry: descriptionTextGeometry)
        
        // position
        let xPosition = paintingSize.width/2.0 + Constants.scenePaddingWidth
        
        descriptionNode.scale = SCNVector3(0.0008, 0.0008, 0.001)
        descriptionNode.position = SCNVector3(xPosition, 0, 0.0)
        
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
    
    func createAuthorNode(authorName: String, size: CGSize) -> SCNNode {
        // image
        let artistImageView = UIImage(named: authorName)
        let material = SCNMaterial()
        material.diffuse.contents = artistImageView
            
        // size n position
        let scaleCoefficient = CGFloat(4.0)
        let imageGeometry = SCNPlane(width: size.width/scaleCoefficient, height: size.height/scaleCoefficient)
        imageGeometry.materials = [material]
        
        let imageNode = SCNNode(geometry: imageGeometry)
        imageNode.eulerAngles.x = -.pi/2.0
        
        let authorNodeXPosition = size.width/2.0 + size.width/scaleCoefficient/2.0 + Constants.scenePaddingWidth
        let authorNodeZPosition = -size.height/2.0 + size.height/scaleCoefficient/2.0
        imageNode.position = SCNVector3(authorNodeXPosition, 0.005, authorNodeZPosition)
            
        return imageNode
    }
}


