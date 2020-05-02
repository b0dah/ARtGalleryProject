//
//  Constants.swift
//  ARtGallery
//
//  Created by Иван Романов on 30.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

enum Constants {
    static let serverURL = "http://IvansMacBookPro.local:8000/"
    
    //API Endpoints URLs
    static let museumsListAPIEndpoint = serverURL + "api/museums"
    static let paintingListForPArticularMuseumEndpoint = serverURL + "api/paintings"
    
    // API Resourcs Pathes
    static let serverStaticResorceFolderPath = serverURL + "static/"
    static let museumsLogosPath = serverStaticResorceFolderPath + "museums_logos/"
    static let museumsAppearencesPath = serverStaticResorceFolderPath + "museums_appearences/"
    static let artistsPortraitsPath = serverStaticResorceFolderPath + "artists_portraits/"
    static let paintingsReproductionsPath = serverStaticResorceFolderPath + "paintings_reproductions/"
}
