//
//  EmojiTableViewController.swift
//  TableViewExample
//
//  Created by Иван Романов on 19.04.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

//var museums = [
//    Museum(name: "Museum of Contemporary Art Tokyo", city: "Tokyo, Japan"),
//    Museum(name: "Ullens Center for Contemporary Art", city: "Beijing China"),
//    Museum(name: "Museum of Contemporary Art Shanghai", city: "Shanghai Shi, China"),
//    Museum(name: "Afriart Gallery", city: "Kampala, Uganda")
//]

import UIKit

class MuseumSelectionTableViewController: UITableViewController {
    
    // UI Properties
    
    var museums: [Museum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        // fetch data from API
        fetchMuseumList(url: Constants.museumsListAPIEndpoint) {
        }
    }
    
    @IBAction func refreshControl(_ sender: UIRefreshControl) {
        fetchMuseumList(url: Constants.museumsListAPIEndpoint) {
            DispatchQueue.main.async {
                sender.endRefreshing()
            }
        }
    }
    
    
    // setting table view controller
    // MARK: Table View Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return museums.count
        }
        else { // not necess, but it's a template
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuseumCell", for: indexPath) as! MuseumTableViewCell
        let museum = museums[indexPath.row]
        cell.updateUI(with: museum)
        
        return cell
    }
    
    // MARK: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PresentMuseumDetails", sender: self)
    }
//
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { // REORDERING
//        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
//        emojis.insert(movedEmoji, at: destinationIndexPath.row)
//        tableView.reloadData()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "PresentMuseumDetails" else {
            print("NOT A PASS DATA SEGUE")
            return
        }
        
        print("A PASS DATA SEGUE")
        let indexPath = tableView.indexPathForSelectedRow!
        let museum = museums[indexPath.row]
        
        if let destination = segue.destination as? MuseumDetailsViewController {
            destination.museum = museum
        }
    }
    
    
}

extension MuseumSelectionTableViewController {
    
    func setupNavigationBar() {
        // UI
        self.tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationController?.navigationBar.backgroundColor = UIColor.init(red: 0/255, green: 144/255, blue: 106/255, alpha: 1.0)
        navigationItem.title = "Museums"
    }
}
