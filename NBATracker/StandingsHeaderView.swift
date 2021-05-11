//
//  StandingsHeaderView.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-09.
//

import Foundation
import UIKit

class StandingsHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "StandingsHeaderIdentifier"
    
    var confLabel: UILabel = {
        let confLabel: UILabel = UILabel()
        confLabel.translatesAutoresizingMaskIntoConstraints = false
        confLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        confLabel.textAlignment = .center
        return confLabel
    }()
    
    var rootHeaderStackView: UIStackView = {
        let rootHeaderStackView = UIStackView()
        rootHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        rootHeaderStackView.axis = .vertical
        return rootHeaderStackView
    }()
    
    var columnsStackView: UIStackView = {
        let columnsStackView = UIStackView()
        columnsStackView.translatesAutoresizingMaskIntoConstraints = false
        columnsStackView.axis = .horizontal
        return columnsStackView
    }()
    
    var statsStackView: UIStackView = {
        let statsStackView = UIStackView()
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        return statsStackView
    }()
    
    var teamLabel: UILabel = {
        let teamLabel: UILabel = UILabel()
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        teamLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        teamLabel.text = "Team"
        return teamLabel
    }()
    
    var posLabel: UILabel = {
        let posLabel: UILabel = UILabel()
        posLabel.translatesAutoresizingMaskIntoConstraints = false
        posLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        posLabel.text = "#"
        posLabel.textAlignment = .center
        return posLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StandingsHeaderView {
    
    private func generateStatsSubViews() {
        let columnsHeader = ["W", "L", "Pct", "GB", "L10", "Strk"]
        
        for column in columnsHeader {
            let label: UILabel = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.text = column
            label.textAlignment = .center
            statsStackView.addArrangedSubview(label)
        }
    }

    private func configure() {
        
        generateStatsSubViews()
        columnsStackView.addArrangedSubview(posLabel)
        columnsStackView.addArrangedSubview(teamLabel)
        columnsStackView.addArrangedSubview(statsStackView)
        
        rootHeaderStackView.addArrangedSubview(confLabel)
        
        let separator = UIView()
        separator.backgroundColor = .black
        rootHeaderStackView.addArrangedSubview(separator)
        
        rootHeaderStackView.addArrangedSubview(columnsStackView)
        // FIXME: - In landscape mode, header is not full width so color is not displayed properly
        // contentView.backgroundColor = UIColor(red: 0.94, green: 0.35, blue: 0.10, alpha: 1.00)
        contentView.addSubview(rootHeaderStackView)
        
        NSLayoutConstraint.activate([
            rootHeaderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootHeaderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rootHeaderStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            rootHeaderStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            separator.heightAnchor.constraint(equalToConstant: 1),
            posLabel.widthAnchor.constraint(equalTo: columnsStackView.widthAnchor, multiplier: Constants.WidthMultipliersStandings.posMultiplier.rawValue),
            teamLabel.widthAnchor.constraint(equalTo: columnsStackView.widthAnchor, multiplier: Constants.WidthMultipliersStandings.teamNameMultiplier.rawValue),
            statsStackView.widthAnchor.constraint(equalTo: columnsStackView.widthAnchor, multiplier: Constants.WidthMultipliersStandings.statsMultiplier.rawValue),
        ])
    }
}
