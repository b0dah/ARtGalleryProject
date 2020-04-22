//
//  PaintingsCollectionViewController.swift
//  ARtGallery
//
//  Created by Иван Романов on 21.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class PaintingsCollectionViewController: UITableViewController {
    
    let paintings = [
    Painting(title: "Art", author: "George Corominas", year: 1998),
    Painting(title: "A Commander in Chief's Tribute to America's Warriors", author: "George W. Bush", year: 2010),
    Painting(title: "The World is Flat Painters' Table", author: "George Nick", year: 1975),
    Painting(title: "Not Titled", author: "Gheorghe Virtosu", year: 2019),
    Painting(title: "Natura morta con Caraffe e tubo", author: "Georges Braque", year: 1934)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
