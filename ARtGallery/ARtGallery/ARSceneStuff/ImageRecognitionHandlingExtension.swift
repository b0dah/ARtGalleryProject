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
            self.feedbackLabel.textColor = .systemYellow
            self.feedbackLabel.text = "Painting Detected!"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.feedbackLabel.textColor = .white
            self.feedbackLabel.text = "Point Camera at the next painting"
        }
        
        DispatchQueue.global().async {
        
            let referenceImage = imageAnchor.referenceImage
            let imagePhysicalSize = referenceImage.physicalSize
            
            guard let recognizedImageName = referenceImage.name,
                let recognizedPainting = DataBaseManager.sharedInstance.getPaintingObjectWithImageTitle(imageTitle: recognizedImageName) else {
                    print("!Wrong image title for painting!")
                    return
            }
        
            self.lastRecognizedPainting = recognizedPainting
            
            // visualization with plane
            let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor.cyan
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 0.3
            planeNode.eulerAngles.x = -Float.pi/2
            
            planeNode.runAction(self.highlightPaintingAction)
            node.addChildNode(planeNode)
            
            // title
            let titleNode = self.createPaintingTitleNode(paintingName: recognizedPainting.title, paintingSize: imagePhysicalSize)
            node.addChildNode(titleNode)
            
            // description
            let formattedDescription = Essentials.prettifyString(string: recognizedPainting.details, span: 8)
            let descriptionNode = self.createPaintingDescriptionNode(description: formattedDescription, paintingSize: imagePhysicalSize)
            node.addChildNode(descriptionNode)
            
            // Author picture
            guard let author = recognizedPainting.author else {
                print("no author")
                return
            }
            
            let authorNode = self.createAuthorNode(author: author, size: imagePhysicalSize)
            node.addChildNode(authorNode)
        
        
            // MARK: - Info Nodes :
            let detailsInfoNode = self.createDetailsInfoNode(size: imagePhysicalSize)
            node.addChildNode(detailsInfoNode)
            
            let authorInfoNode = self.createAuthorInfoNode(size: imagePhysicalSize)
            node.addChildNode(authorInfoNode)
        
            // save it to Recognized
            DataBaseManager.sharedInstance.savePaintingToRecognized(id: recognizedPainting.id)
        }
    }
    
}

extension ExplorationViewController {
    // MARK: - hitting to get to details
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 1. get the current touch location
        // 2. check if we have a hit to SCNNode by performing an SCNHitTest
        // 3. check to what it hit
        
        guard let touchLocation = touches.first?.location(in: self.sceneView),
            let hitTestNode = self.sceneView.hitTest(touchLocation, options: nil).first?.node,
            let hitNodeName = hitTestNode.name
        else {
            print("Wrong Hit")
            return
        }
        
        print("HIT!")
        
        switch hitNodeName {
            case "DetailsInfoNode":
                performSegue(withIdentifier: "PresentPaintingDetails", sender: self)
            case "AuthorInfoNode":
                performSegue(withIdentifier: "PresentAuthorDetails", sender: self)
            default: break
        }
    }
}
