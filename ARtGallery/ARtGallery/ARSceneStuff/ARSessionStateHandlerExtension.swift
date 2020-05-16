//
//  ARSessionStateHandlerExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 23.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import ARKit
import SceneKit

extension ExplorationViewController: ARSessionDelegate {
    // MARK: session failed Handler
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard
            let error = error as? ARError,
            let code = ARError.Code(rawValue: error.errorCode)
        else {
            return
        }
        // Error Occured: Hadling
        feedbackLabel.isHidden = false
        
        switch code {
        case .cameraUnauthorized:
            feedbackLabel.text = "Camera tracking is not available. Please check your camera permissions."
        default:
            feedbackLabel.text = "Error starting session. Try to relaunch the app!"
        }
    }
    
    // MARK: camera state has changed
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        
        switch camera.trackingState {
        case .limited(let reasonForTrackingToBeLimited):
            
            feedbackLabel.isHidden = false
            
            switch reasonForTrackingToBeLimited {
            case .excessiveMotion:
                feedbackLabel.text = "You move to fast. Slow down!"
            case .initializing, .relocalizing:
                feedbackLabel.text = "AR Scene is warming up! Move around slowly, some extra time needed."
            case .insufficientFeatures:
                feedbackLabel.text = "Move ARound a bit more or turn on the light!"
            @unknown default:
                feedbackLabel.text = "Tracking is limited due to the unknown circumstances"
            }
        case .normal:
            feedbackLabel.isHidden = false
            feedbackLabel.text = "Point camera at any painting!"
        case .notAvailable:
            feedbackLabel.isHidden = false
            feedbackLabel.text = "Camera tracking is not available for now"
        }
    }
}
