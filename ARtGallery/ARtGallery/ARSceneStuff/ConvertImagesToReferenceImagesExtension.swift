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
    
    
    func createReferenceImageSet(completion: @escaping ()->Void) {
        
        guard self.paintings != nil else {
            print("paintings array is set to nil")
            return
        }
        
        let dispatchGroup = DispatchGroup()
        
        for painting in self.paintings! {
            
            dispatchGroup.enter()
            
            guard let data = painting.image  else {
                print("painting image is not set")
                continue
            }
            
            // Convert Data to UIImage
            guard let image = UIImage(data: data) else {
                print("Can't convert Data to UIImage")
                continue
            }
            
            // Convert It To A CIImage (CREATE CIIMage из Data)
            guard let ciImage = CIImage(image: image),
            // Then Convert The CIImage To A CGImage
                let cgImage = convertCIImageToCGImage(inputImage: ciImage) else {
                    continue
            }

            // Create An ARReference Image (Remembering Physical Width Is In Metres)
            let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: CGFloat(painting.physicalWidth))
            referenceImage.name = painting.imageName

            self.referenceImages.insert(referenceImage)
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global()) {
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
