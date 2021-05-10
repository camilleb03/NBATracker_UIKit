//
//  StandingsCollectionViewCell.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-09.
//

import UIKit

class StandingsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "StandingsCellIdentifier"
    
    let teamLabel = UILabel()
    let winsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StandingsCollectionViewCell {
    func configure() {
        
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        teamLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(teamLabel)
        teamLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        winsLabel.translatesAutoresizingMaskIntoConstraints = false
        winsLabel.adjustsFontForContentSizeCategory = true
        winsLabel.text = "43"
        contentView.addSubview(winsLabel)
        winsLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            teamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            teamLabel.trailingAnchor.constraint(equalTo: winsLabel.trailingAnchor),
            teamLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            teamLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            winsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            winsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            winsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)

        ])
    }
}
