//
//  PaintingsCollectionViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 21.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//


//    Painting(title: "Art", author: "George Corominas", year: 1998),
//    Painting(title: "A Commander in Chief's Tribute to America's Warriors", author: "George W. Bush", year: 2010),
//    Painting(title: "The World is Flat", author: "George Nick", year: 1975),
//    Painting(title: "Not Titled", author: "Gheorghe Virtosu", year: 2019),
//    Painting(title: "Natura morta con Caraffe e tubo", author: "Georges Braque", year: 1934)

import UIKit
import CoreData

class PaintingsCollectionViewController: UITableViewController {
    
    var paintings: [Painting] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: UI
        tableView.separatorStyle = .none
        
        // MARK: DB Test
//        let rp = RecognizedPainting(context: DataBaseManager.sharedInstance.persistentContainer.viewContext)
//        rp.paintingId = 20000
//
//        do {
//            try DataBaseManager.sharedInstance.saveContext()
//            print("yaaa")
//        } catch {
//            print("naa")
//        }
//
//        //
//        let request = NSFetchRequest<NSFetchRequestResult> (entityName: RecognizedPaintingsKeys.entityName)
//        do {
//            let fetched = try DataBaseManager.sharedInstance.persistentContainer.viewContext.fetch(request) as? [RecognizedPainting]
//            print("+")
//            print(fetched)
//
//        } catch {
//            print("-")
//        }
        
        
        // MARK: - Data Fecth
        populateTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        populateTableView()
        tableView.reloadData()
    }
    
    func populateTableView() {
        guard let ids = DataBaseManager.sharedInstance.getRecongnizedPaintingsIDs() else {
            print("Couldn't fetch IDs")
            return
        }
        
        self.paintings =  DataBaseManager.sharedInstance.getPaintingsArrayWithIdsArray(ids: ids)
        print(paintings.count)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paintings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaintingCell", for: indexPath) as! PaintingTableViewCell

        let painting = paintings[indexPath.row]
        cell.updateUI(painting: painting)

        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PresentPaintingDetails", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? PaintingDetailsViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            
            let painting = paintings[indexPath.row]
            destination.painting = painting
        }
    }
    

}
