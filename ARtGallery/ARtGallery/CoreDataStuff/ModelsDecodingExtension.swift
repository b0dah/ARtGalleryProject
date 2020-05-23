//
//  ModelsDecodingExtension.swift
//  ARtGallery
//
//  Created by Иван Романов on 14.05.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import CoreData

extension MuseumDetailsViewController {
    
    private func createArtistEntity(context: NSManagedObjectContext, dictionary: [String: AnyObject]) -> Artist? {
        
        guard let artist = NSEntityDescription.insertNewObject(forEntityName: "Artist", into: context) as? Artist
        else {
            print("No such \"Artist\" entity")
            return nil
        }
        
        guard
            let id = dictionary[ArtistKeys.id] as? Int32,
            let name = dictionary[ArtistKeys.name] as? String,
            let country = dictionary[ArtistKeys.country] as? String,
            let portraitImageTtitle = dictionary[ArtistKeys.portraitImageTitle] as? String,
            let yearsOfLife = dictionary[ArtistKeys.yearsOfLife] as? String,
            let link = dictionary[ArtistKeys.link] as? String,
            let biography = dictionary[ArtistKeys.biography] as? String
        else {
            print("No such properties in Artist Dict")
            return nil
        }
        
        artist.id = id
        artist.name = name
        artist.yearsOfLife = yearsOfLife
        artist.country = country
        artist.portraitImageTitle = portraitImageTtitle
        artist.link = link
        artist.biography = biography
        
        return artist
    }
    
    func createPaintingEntity(context: NSManagedObjectContext, dictionary: [String: AnyObject]) -> Painting? {
        
        guard let painting = NSEntityDescription.insertNewObject(forEntityName: "Painting", into: context) as? Painting
        else {
            print("No such \"Painting\" entity")
            return nil
        }
        
        print("\n\n")
        print(dictionary)
        print("\n\n")

        
        guard
            let id = dictionary[PaintingKeys.id] as? Int32,
            let title = dictionary[PaintingKeys.title] as? String,
            let genre = dictionary[PaintingKeys.genre] as? String,
////            let image = nil,
            let imageName = dictionary[PaintingKeys.imageName] as? String,
            let details = dictionary[PaintingKeys.details] as? String,
            let museumId = dictionary[PaintingKeys.museumId] as? Int32,
            let year = dictionary[PaintingKeys.year] as? Int16,
            let physicalWidth = dictionary[PaintingKeys.physicalWidth] as? Double,
            let physicalHeight = dictionary[PaintingKeys.physicalHeight] as? Double,
            let link = dictionary[PaintingKeys.link] as? String,
            let authorDictionary = dictionary[PaintingKeys.author] as? [String: AnyObject]
        else {
            print("No such properties in Painting Dict")
            return nil
        }
        
        painting.id = id
        painting.title = title
        painting.details = details
        painting.genre = genre
        painting.image = nil // !
        painting.imageName = imageName
        painting.museumId = museumId
        painting.year = year
        painting.physicalWidth = physicalWidth
        painting.physicalHeight = physicalHeight
        painting.link = link
        
        if let author = createArtistEntity(context: context, dictionary: authorDictionary) {
            painting.author = author
        } else {
            fatalError("No author!")
        }
        
        return painting
    }



}
