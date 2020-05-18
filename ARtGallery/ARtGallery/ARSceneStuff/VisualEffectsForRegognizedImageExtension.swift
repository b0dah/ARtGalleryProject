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
        let zPosition = -paintingSize.height/2.0 - ARConstants.scenePaddingWidth
        
        titleNode.position = SCNVector3(xPosition, 0, zPosition)
        titleNode.scale = SCNVector3(0.003, 0.003, 0.002)
//    titleNode.pivot = SCNMatrix4MakeTranslation(0, 0, 0)
       titleNode.eulerAngles.x = -Float.pi/2
       return titleNode
   }
    
    func createPaintingDescriptionNode(description: String, paintingSize: CGSize) -> SCNNode {
        
        let descriptionTextGeometry = SCNText(string: description, extrusionDepth: 0.0)
        descriptionTextGeometry.font = UIFont(name: "Helvetica", size: 12)
        descriptionTextGeometry.firstMaterial?.diffuse.contents = UIColor.white
        let descriptionNode = SCNNode(geometry: descriptionTextGeometry)
        
        
        let coefficient = ARConstants.descriptionNodeScaleCoefficient
        descriptionNode.scale = SCNVector3(coefficient, coefficient, 0.001)
        
        // position
        let portraitImageHeight = paintingSize.width/ARConstants.authorNodeScaleCoefficient * 1.33
        
        let (minVector, maxVector) = descriptionNode.boundingBox
        
        print(minVector)
        print(maxVector)
        
        let textNodeHeight = CGFloat(maxVector.y - minVector.y) * ARConstants.descriptionNodeScaleCoefficient
        print("TEXT NODE HEIGHT")
        print(textNodeHeight)
        
        let xPosition = paintingSize.width/2.0 + ARConstants.scenePaddingWidth
        let zPosition = -paintingSize.height/2.0 + portraitImageHeight + ARConstants.scenePaddingWidth + textNodeHeight
        
        
        descriptionNode.position = SCNVector3(xPosition, 0, zPosition)
        
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
    
    func createAuthorNode(author: Artist, size: CGSize) -> SCNNode {
        
        let material = SCNMaterial()
        
        if let portraitImageData = author.portraitImage {
            // image
            let artistImage = UIImage(data: portraitImageData)
            material.diffuse.contents = artistImage
        }
        else {
            print("No author portait")
            
            let dummyImage = UIImage(named: "imagePlaceHolder")
            material.diffuse.contents = dummyImage
        }
        
        // size
        let portraitImageWidth = size.width/ARConstants.authorNodeScaleCoefficient
        let portraitImageHeight = portraitImageWidth * 1.33
        
        let imageGeometry = SCNPlane(width: portraitImageWidth, height: portraitImageHeight)
        imageGeometry.materials = [material]
        
        let imageNode = SCNNode(geometry: imageGeometry)
        imageNode.eulerAngles.x = -.pi/2.0
        
        let authorNodeXPosition = size.width/2.0 + portraitImageWidth/2.0 + ARConstants.scenePaddingWidth
        let authorNodeZPosition = -size.height/2.0 + portraitImageHeight/2.0
        imageNode.position = SCNVector3(authorNodeXPosition, 0.001, authorNodeZPosition)
            
        return imageNode
    }
    
    func createAnimation(paintingSize: CGSize) -> SCNNode {
        
        // painting
        let paintingFrame = CGRect(x: 100, y: 100, width: 200, height: 250)
        let paintingView = UIView(frame: paintingFrame)
        paintingView.backgroundColor = .black
        
        // flare
        let flareFrame = CGRect(x: 0, y: 0, width: 700, height: 20)
        let flare = UIView(frame: flareFrame)
        flare.backgroundColor = .white
        
        // blur
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)

        blurView.frame = paintingView.bounds
        blurView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
//        self.view.insertSubview(blurView, at: 0)
//        blurView.alpha = 0.8

        
        // set up scene
        paintingView.addSubview(flare)
        paintingView.addSubview(blurView)
        let rotateTransform = CGAffineTransform(rotationAngle: .pi/6)
        flare.transform = rotateTransform
        
        
        
        // animate
        UIView.animate(withDuration: 1.5, animations: {
            let translateTransform = CGAffineTransform(translationX: 0, y: paintingView.frame.height)
            flare.transform = translateTransform
        })
        {
            (_) in UIView.animate(withDuration: 1.5, animations: {
                let translateTransform = CGAffineTransform(translationX: 0, y: -paintingView.frame.height)
                flare.transform = translateTransform.concatenating(rotateTransform)
            })
        }
        
        // material
        let material = SCNMaterial()
        material.diffuse.contents = paintingView
        
        //
        let imageGeometry = SCNPlane(width: paintingSize.width, height: paintingSize.height)
        imageGeometry.materials = [material]
        
        //
        let imageNode = SCNNode(geometry: imageGeometry)
        imageNode.eulerAngles.x = -.pi/2.0
        
        return imageNode
    }
}


