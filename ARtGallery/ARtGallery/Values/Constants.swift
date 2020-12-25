//
//  Constants.swift
//  ARtGallery
//
//  Created by Иван Романов on 30.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

enum Constants {
//    static let serverURL = "http://IvansMacBookPro.local:8000/"
    static let serverURL = "http://52.28.107.16:8000/"
    
    //API Endpoints URLs
    static let museumsListAPIEndpoint = serverURL + "api/museums"
    static let paintingListForPArticularMuseumEndpoint = serverURL + "api/paintings"
    
    // API Resourcs Pathes
    static let serverStaticResorceFolderPath = serverURL + "static/"
    static let museumsLogosPath = serverStaticResorceFolderPath + "museums_logos/"
    static let museumsAppearencesPath = serverStaticResorceFolderPath + "museums_appearences/"
    static let artistsPortraitsPath = serverStaticResorceFolderPath + "artists_portraits/"
    static let paintingsReproductionsPath = serverStaticResorceFolderPath + "paintings_reproductions/"
    
    
    
    
    static var pathToDocuments: String? {
        let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last
        return url?.absoluteString
    }
}
