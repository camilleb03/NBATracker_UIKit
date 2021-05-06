//
//  LiveScoresViewController.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import UIKit
import SVGKit

class LiveScoresViewController: BaseViewController {
    
    var tableView = UITableView()
    
    var dateString: String?
    
    let liveScoresService = LiveScoresService()
    
    let teamLogoCacheManager = TeamLogoCacheManager.shared

    var liveScoreBoards = [LiveScoreBoard]()
    
    var cellIdentifier = "LiveScoreCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        title = "Live Scores"
        
        setupTableView()
        fetchLiveScoreBoards()
        style()
        layout()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "sportscourt.fill", title: "Live Scores")
    }
    
    private func fetchLiveScoreBoards() {
        liveScoresService.fetch(for: (dateString ?? NBATodayService.nbaToday?.currentDateUrlCode) ?? getCurrentDateString(with: "yyyyMMdd")) { [weak self] result in
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
        
        func image(data: Data?) -> SVGKImage? {
            if let data = data {
                let image = SVGKImage(data: data)
                return image
            }
            return nil
        }
        
        teamLogoCacheManager.fetch(for: liveScoreBoard.homeTeam.triCode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teamLogo):
                let img = image(data: teamLogo)
                DispatchQueue.main.async {
                    if (cell.representedIdentifier == representedIdentifier) {
                        cell.homeLogoImage = img
                        cell.setNeedsLayout()
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
