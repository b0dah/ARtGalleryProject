//
//  ImageRecognitionHandlingExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 23.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import ARKit
import SceneKit

extension ExplorationViewController {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        
        handleRecognizedPainting(imageAnchor, node)
        
    }
    
    private func handleRecognizedPainting(_ imageAnchor: ARImageAnchor, _ node: SCNNode) {
        
        print("Painting detected!")
        DispatchQueue.main.async {
            self.feedbackLabel.text = "Painting Detected!"
        }
        
        let referenceImage = imageAnchor.referenceImage
        let imagePhysicalSize = referenceImage.physicalSize
        
        let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = UIColor.cyan
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.opacity = 0.3
        planeNode.eulerAngles.x = -Float.pi/2
        
        planeNode.runAction(highlightPaintingAction)
        node.addChildNode(planeNode)
        
        let titleNode = createPaintingTitleNode(paintingName: referenceImage.name!, paintingSize: imagePhysicalSize)
        node.addChildNode(titleNode)
        
        let description = "George Nick\n2011\nNick comments: In the beginning, I always felt I couldn't remake the world but I would like to try."
        let descriptionNode = createPaintingDescriptionNode(description: description, paintingSize: imagePhysicalSize)
        node.addChildNode(descriptionNode)
        
        let authorName = "George Nick"
        let authorNode = createAuthorNode(authorName: authorName, size: imagePhysicalSize)
        node.addChildNode(authorNode)
    }
    
    
//    I didn't know how so I tried different ways. I am still doing that. I am not that focused. I go out to paint. I look for something to paint. All these ideas stay in the background, out of sight, until I am through painting. I get ideas from the act of painting and it guides me either into a dogma or chaos. All my paintings start from what is seen. The painting marries in different ways and set up its own laws, which I try to deduce and follow. The awareness did not change the painting. The conclusions of the finished piece changed the process of translating the seen.
//
}
