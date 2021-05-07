//
//  LiveScoresViewController.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import UIKit

class LiveScoresViewController: BaseViewController {
    
    var tableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    var dateCode: String?
    
    let teamLogoCacheManager = TeamLogoCacheManager.shared
    
    let liveScoresService = LiveScoresService()
    var liveScoreBoards = [LiveScoreBoard]()
    
    var cellIdentifier = "LiveScoreCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
                
        setDateCode()
        setupTableView()
        fetchLiveScoreBoards()
        style()
        layout()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "sportscourt.fill", title: "Live Scores")
        setDateCode()
        let date = CustomDateFormatters.yyyyMMddFormatter.date(from: dateCode!)
        setNavBarTitle(title: "Games: " + CustomDateFormatters.convertDateTolocalDateMediumString(for: date!))
    }
    
    private func fetchLiveScoreBoards() {
        liveScoresService.fetch(for: dateCode!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let liveScoreBoards):
                self.liveScoreBoards = liveScoreBoards
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension LiveScoresViewController {
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
    
    private func setDateCode() {
        dateCode = NBATodayService.nbaToday?.currentDateUrlCode ?? CustomDateFormatters.convertDateToyyyyMMddString(for: Date())
    }

}

// MARK: - Table view data source
extension LiveScoresViewController: UITableViewDataSource {
    
    func setupTableView() {
        // Conform itself as the data source and the delegate
        tableView.dataSource = self
        
        // Delegate is for user interaction
        tableView.delegate = self
        
        // Register cells to use in TableView
        tableView.register(LiveScoreTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        // Refresh table view
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh scores")
        refreshControl.addTarget(self, action: #selector(refreshTableViewData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    @objc private func refreshTableViewData(_ sender: Any) {
        // FIXME: Weird flashing data while refreshing/reloading data
        self.refreshControl.endRefreshing()
        fetchLiveScoreBoards()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.liveScoreBoards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)  as! LiveScoreTableViewCell

        // Configure the cell with the data
        let liveScoreBoard = self.liveScoreBoards[indexPath.row]
        cell.liveScoreBoard = liveScoreBoard
        
        cell.homeLogoImage = nil
        cell.visitorLogoImage = nil

        let representedIdentifier = liveScoreBoard.id
        cell.representedIdentifier = representedIdentifier

        func image(data: Data?) -> UIImage? {
            if let data = data {
                let image = UIImage(data: data)
                return image
            }
            return UIImage(systemName: "sportscourt")
        }

        teamLogoCacheManager.fetch(for: liveScoreBoard.homeTeam.triCode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teamLogo):
                let img = image(data: teamLogo)
                DispatchQueue.main.async {
                    if (cell.representedIdentifier == representedIdentifier) {
                        cell.homeLogoImage = img
                    }
                }
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        }

        teamLogoCacheManager.fetch(for: liveScoreBoard.visitorTeam.triCode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teamLogo):
                let img = image(data: teamLogo)
                DispatchQueue.main.async {
                    if (cell.representedIdentifier == representedIdentifier) {
                        cell.visitorLogoImage = img
                    }
                }
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        }
        
        // Return cell
        return cell
    }
}

extension LiveScoresViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
