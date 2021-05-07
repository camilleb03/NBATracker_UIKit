//
//  StandingsViewController.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-07.
//

import Foundation


import UIKit

class StandingsViewController: BaseViewController {
    
    let standingsStatusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        standingsStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        standingsStatusLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        standingsStatusLabel.textAlignment = .center
        standingsStatusLabel.text = "Coming soon..."
    }
    
    func layout() {
        view.addSubview(standingsStatusLabel)
        // Automatically activate constraints routine
        NSLayoutConstraint.activate([
            standingsStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            standingsStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            standingsStatusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            standingsStatusLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
        ])
    }
}
