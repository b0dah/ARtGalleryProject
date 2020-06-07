//
//  ARResourcesButton.swift
//  ARtGallery
//
//  Created by Иван Романов on 14.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

enum ARResourcesButtonState: String {
    case checking = "Минутку!"
    case preparing = "Готовим все необходимое"
    case readyToDownload = "Загрузить ресурсы для AR "
    case downloading = "Загрузка"
    case readyToGoToAR = "Перейти к AR-сцене "
}

class ARResourcesButton: LoadingButton {
    var customState: ARResourcesButtonState = .checking  {
        didSet {
            DispatchQueue.main.async {
                self.setTitle(self.customState.rawValue, for: .normal)

                switch self.customState {
                case .checking:
                    self.isEnabled = false
                case .downloading:
                    self.showLoading()
                    self.isEnabled = false
                case .preparing:
                    self.hideLoading()
                    self.setImage(nil, for: .normal)
                    self.isEnabled = false
                case .readyToDownload:
                    self.isEnabled = true
                    self.setReadyToDownloadAppearence()
                case .readyToGoToAR:
                    self.hideLoading()
                    self.isEnabled = true
                    self.setReadyToSegueAppearence()
                }
            }
        }
    }
    
    func setReadyToDownloadAppearence() {
        setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
    }
    
    func setReadyToSegueAppearence() {
        self.backgroundColor = UIColor.init(red: 0/255, green: 144/255, blue: 106/255, alpha: 1.0)
        setImage(UIImage(systemName: "arrow.left.circle"), for: .normal)
    }
    
}
