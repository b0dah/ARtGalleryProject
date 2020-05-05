//
//  ConvertImagesToReferenceImagesExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 02.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit
import ARKit
import CoreImage

extension MuseumDetailsViewController {
    
//    func createReferenceImageSet() {
//        guard (self.paintingsImages != nil) else {
//            print("paintingImages array is empty")
//            return
//        }
//
//        for image in self.paintingsImages! {
//            // Convert It To A CIImage
//            guard let ciImage = CIImage(image: image),
//            // Then Convert The CIImage To A CGImage
//                let cgImage = convertCIImageToCGImage(inputImage: ciImage) else {
//                    continue
//            }
//
//            // Create An ARReference Image (Remembering Physical Width Is In Metres)
//            /*FIX*/let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: 0.15)
//            /*FIX*/referenceImage.name = "painting"
//
//            self.referenceImages.append(referenceImage)
//
//        }
//    }
    
    
    
//    func convertAndSaveAsReferenceImage(painting: Painting) {
//
//        guard let image = painting.image else {
//            print("Image for Paintings object is not set")
//            return
//        }
//
//            // Convert It To A CIImage
//        guard let ciImage = CIImage(image: image),
//            // Then Convert The CIImage To A CGImage
//            let cgImage = convertCIImageToCGImage(inputImage: ciImage) else {
//                print("Image Converting Error!")
//                return
//            }
//
//        // Create An ARReference Image (Remembering Physical Width Is In Metres)
//        let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: CGFloat(painting.physicalWidth))
//        referenceImage.name = painting.imageTitle
//
//        self.referenceImages.append(referenceImage)
//        print("APPENDED! now there are " + String(referenceImages.count) + " reference images!")
//
//    }
    
    
    func createReferenceImageSet(completion: @escaping ()->Void) {
        
        guard self.paintings != nil else {
            print("paintings array is set to nil")
            return
        }
        
        for painting in self.paintings! {
            guard let image = painting.image  else {
                print("painting image is not set")
                continue
            }
            
            // Convert It To A CIImage
            guard let ciImage = CIImage(image: image),
            // Then Convert The CIImage To A CGImage
                let cgImage = convertCIImageToCGImage(inputImage: ciImage) else {
                    continue
            }

            // Create An ARReference Image (Remembering Physical Width Is In Metres)
            let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: CGFloat(painting.physicalWidth))
            referenceImage.name = painting.imageTitle

            self.referenceImages.append(referenceImage)
            
            completion()
        }
  
    }
        
    
    
    /// Converts A CIImage To A CGImage
    ///
    /// - Parameter inputImage: CIImage
    /// - Returns: CGImage
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        
        let context = CIContext(options: nil)
        
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
         return cgImage
        }
        return nil
    }
}
