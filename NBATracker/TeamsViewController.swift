//
//  TeamsTableViewController.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import UIKit

class TeamsViewController: BaseViewController {
    
    var tableView = UITableView()
    
    var teamsService = TeamsService()
    var teams = [Team]()
    
    var cellIdentifier = "TeamCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTeamsService()
        style()
        layout()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "magnifyingglass.circle.fill", title: "Search")
        setNavBarTitle(title: "Teams")
    }
}

extension TeamsViewController {
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
    

// MARK: - Table view data source
extension TeamsViewController: UITableViewDataSource {
    
    func setupTableView() {
        // Conform itself as the data source and the delegate
        tableView.dataSource = self
        
        // Delegate is for user interaction
        tableView.delegate = self
        
        // Register cells to use in TableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

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

extension TeamsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - TeamsServiceDelegate methods

extension TeamsViewController: TeamsServiceDelegate {
    
    func setupTeamsService() {
        // Set itself as the delegate
        teamsService.delegate = self
        
        teamsService.fetchTeams()
    }
    
    func teamsFetched(_ teams: [Team]) {
        // Set the returned videos to the videos property
        self.teams = teams
        // Refresh the table view -> Fires TableView methods
        tableView.reloadData()
    }
    
}
