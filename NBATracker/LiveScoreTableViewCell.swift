//
//  LiveScoreTableViewCell.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import UIKit

class LiveScoreTableViewCell: UITableViewCell {
    
    var liveScoreBoard : LiveScoreBoard? {
        didSet {
            if let ls = liveScoreBoard {
                homeTeamNameLabel.text = ls.homeTeam.triCode
                visitorTeamNameLabel.text = ls.visitorTeam.triCode
                
                homeTeamRecordLabel.text = ls.homeTeam.win + " - " + ls.homeTeam.loss
                visitorTeamRecordLabel.text = ls.visitorTeam.win + " - " + ls.visitorTeam.loss
                
                homeTeamScoreLabel.text = ls.homeTeam.score
                visitorTeamScoreLabel.text = ls.visitorTeam.score
                
                currentPeriodLabel.text = String(ls.currentPeriod)
            }
        }
    }
    
    // View elements
    let rootStackView = UIStackView()
    let homeTeamStackView = UIStackView()
    let homeTeamNameLabel = UILabel()
    let homeTeamRecordLabel = UILabel()
    let homeTeamScoreLabel = UILabel()
    let visitorTeamStackView = UIStackView()
    let visitorTeamNameLabel = UILabel()
    let visitorTeamRecordLabel = UILabel()
    let visitorTeamScoreLabel = UILabel()
    let currentPeriodLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleCell()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LiveScoreTableViewCell {
    
    private func styleCell() {
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.spacing = 10
        rootStackView.axis = .horizontal
        rootStackView.alignment = .center
        rootStackView.distribution = .equalSpacing
        
        // Home Team
        homeTeamStackView.translatesAutoresizingMaskIntoConstraints = false
        homeTeamStackView.spacing = 8
        homeTeamStackView.axis = .vertical
        
        
        
        homeTeamScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        homeTeamScoreLabel.text = ""
        homeTeamScoreLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        // Visitor Team
        visitorTeamStackView.translatesAutoresizingMaskIntoConstraints = false
        visitorTeamStackView.spacing = 8
        visitorTeamStackView.axis = .vertical
        
        visitorTeamScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        visitorTeamScoreLabel.text = "55"
        visitorTeamScoreLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        // Game Time
        currentPeriodLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPeriodLabel.text = "2"
        currentPeriodLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
    }
    
    private func layout() {
        
        homeTeamStackView.addArrangedSubview(homeTeamNameLabel)
        homeTeamStackView.addArrangedSubview(homeTeamRecordLabel)
        
        visitorTeamStackView.addArrangedSubview(visitorTeamNameLabel)
        visitorTeamStackView.addArrangedSubview(visitorTeamRecordLabel)
        
        rootStackView.addArrangedSubview(homeTeamStackView)
        rootStackView.addArrangedSubview(homeTeamScoreLabel)
        rootStackView.addArrangedSubview(currentPeriodLabel)
        rootStackView.addArrangedSubview(visitorTeamScoreLabel)
        rootStackView.addArrangedSubview(visitorTeamStackView)
        
        contentView.addSubview(rootStackView)
        
        // Automatically activate constraints routine
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
