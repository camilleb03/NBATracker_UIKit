//
//  TeamsTableViewController.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import UIKit

class TeamsTableViewController: UITableViewController {
    
    var teamsService = TeamsService()
    
    var teams = [Team]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // TabBarItem config
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "magnifyingglass.circle.fill", withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: "Search", image: image, tag: 0)
        
        // Register cells to use in TableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        // Conform itself as the data source and the delegate
        tableView.dataSource = self
        
        // Delegate is for user interaction
        tableView.delegate = self
        
        // Set itself as the delegate
        teamsService.delegate = self
        
        teamsService.fetchTeams()
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.teams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell with the data
        let team = self.teams[indexPath.row]
        cell.textLabel?.text = team.fullName
        
        // Return cell
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - ModelDelegate methods

extension TeamsTableViewController: TeamsServiceDelegate {
    func teamsFetched(_ teams: [Team]) {
        // Set the returned videos to the videos property
        self.teams = teams
        print("teamsFetched", teams[0])
        // Refresh the table view -> Fires TableView methods
        tableView.reloadData()
    }
    
}
