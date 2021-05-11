//
//  StandingsViewController.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-07.
//

import Foundation
import UIKit

class StandingsViewController: BaseViewController {


    var tableView = UITableView()
    let standingsService = StandingsService()
    
    var conferenceStandings: ConferenceStandings? {
        didSet {
            conferenceStandings?.sortStandingsByWinPercentage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        setupTableView()
        style()
        layout()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "list.number", title: "Standings")
        setNavBarTitle(title: "Conference Standings")
    }
}

extension StandingsViewController {
    
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
    
    private func setupTableView() {
        // Conform itself as the data source and the delegate
        tableView.dataSource = self
        
        // Delegate is for user interaction
        tableView.delegate = self
        
        // Register header to use in TableView
        tableView.register(StandingsHeaderView.self, forHeaderFooterViewReuseIdentifier: StandingsHeaderView.reuseIdentifier)
        
        // Register cells to use in TableView
        tableView.register(StandingsTableViewCell.self, forCellReuseIdentifier: StandingsTableViewCell.reuseIdentifier)
    }
    
    
    private func fetch() {
        standingsService.fetchConferenceStandings(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let confStandings):
                self.conferenceStandings = confStandings
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
            
        })
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Table view data source
extension StandingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let conferenceStandings = self.conferenceStandings {
            switch section {
            // Eastern
            case 0:
                return conferenceStandings.eastStandings.count
            // Western
            case 1:
                return conferenceStandings.westStandings.count
            default:
                fatalError()
            }
        }
        return 15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let conferenceStandings = self.conferenceStandings {
            let cell = tableView.dequeueReusableCell(withIdentifier: StandingsTableViewCell.reuseIdentifier, for: indexPath)  as! StandingsTableViewCell
            
            let standing: Standing
            switch indexPath.section {
            // Eastern
            case 0:
                standing = conferenceStandings.eastStandings[indexPath.row]
            // Western
            case 1:
                standing = conferenceStandings.westStandings[indexPath.row]
            default:
                fatalError()
            }
            // Configure the cell with the data
            cell.posString = String(indexPath.row + 1)
            cell.standing = standing
            return cell
        }
        
        // Return cell
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: StandingsHeaderView.reuseIdentifier ) as! StandingsHeaderView
        
        switch section {
        // Eastern
        case 0:
            headerView.confLabel.text = "EASTERN CONFERENCE"
        // Western
        case 1:
            headerView.confLabel.text = "WESTERN CONFERENCE"
        default:
            fatalError()
        }
        
        return headerView
    }
}

extension StandingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

