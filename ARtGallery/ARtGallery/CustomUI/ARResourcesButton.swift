//
//  ARResourcesButton.swift
//  ARtGallery
//
//  Created by Иван Романов on 14.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

enum ARResourcesButtonState: String {
    case checking = "Just a sec ..."
    case preparing = "We are preparing all u need"
    case readyToDownload = "Download AR Resources "
    case downloading = "Downloading"
    case readyToGoToAR = "Go to AR Experience"
}

class ARResourcesButton: LoadingButton {
    var customState: ARResourcesButtonState = .checking  {
        didSet {
            self.setTitle(customState.rawValue, for: .normal)
            
            switch customState {
            case .checking:
                isEnabled = false
            case .downloading:
                showLoading()
                isEnabled = false
            case .preparing:
                hideLoading()
                setImage(nil, for: .normal)
                isEnabled = false
            case .readyToDownload:
                setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
                setActiveAppearence()
            default:
                hideLoading()
            }
        }
    }
    
    func setActiveAppearence() {
        self.backgroundColor = UIColor.init(red: 0/255, green: 144/255, blue: 106/255, alpha: 1.0)
    }
    
}
