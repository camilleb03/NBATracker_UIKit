//
//  LiveScoreTableViewCell.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import UIKit

class LiveScoreTableViewCell: UITableViewCell {
    
    var representedIdentifier: String = ""
    
    var liveScoreBoard : LiveScoreBoard? {
        didSet {
            if let ls = liveScoreBoard {
                homeTeamNameLabel.text = ls.homeTeam.triCode
                visitorTeamNameLabel.text = ls.visitorTeam.triCode
                
                homeTeamRecordLabel.text = ls.homeTeam.win + " - " + ls.homeTeam.loss
                visitorTeamRecordLabel.text = ls.visitorTeam.win + " - " + ls.visitorTeam.loss
                
                homeTeamScoreLabel.text = ls.homeTeam.score
                visitorTeamScoreLabel.text = ls.visitorTeam.score
                gameStatusLabel.text = ls.getGameInfoString()
            }
        }
    }
    
    var homeLogoImage: UIImage? {
        didSet {
            homeTeamLogoImageView.image = homeLogoImage
            if homeTeamLogoImageView.frame.width > homeTeamLogoImageView.frame.height {
                homeTeamLogoImageView.contentMode = .scaleAspectFit
                //since the width > height we may fit it and we'll have bands on top/bottom
            } else {
                homeTeamLogoImageView.contentMode = .scaleAspectFill
                //width < height we fill it until width is taken up and clipped on top/bottom
            }
        }
    }
    
    var visitorLogoImage: UIImage? {
        didSet {
            visitorTeamLogoImageView.image = visitorLogoImage
            if visitorTeamLogoImageView.frame.width > visitorTeamLogoImageView.frame.height {
                visitorTeamLogoImageView.contentMode = .scaleAspectFit
                //since the width > height we may fit it and we'll have bands on top/bottom
            } else {
                visitorTeamLogoImageView.contentMode = .scaleAspectFill
                //width < height we fill it until width is taken up and clipped on top/bottom
            }
        }
    }
    
    // View elements
    let rootStackView = UIStackView()
    
    let homeTeamStackView = UIStackView()
    let homeTeamNameLabel = UILabel()
    let homeTeamRecordLabel = UILabel()
    let homeTeamScoreLabel = UILabel()
    let homeTeamLogoImageView = UIImageView()
    
    let visitorTeamStackView = UIStackView()
    let visitorTeamNameLabel = UILabel()
    let visitorTeamRecordLabel = UILabel()
    let visitorTeamScoreLabel = UILabel()
    let visitorTeamLogoImageView = UIImageView()
    
    let gameStatusLabel = UILabel()
    
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
        rootStackView.axis = .horizontal
        rootStackView.alignment = .fill
        rootStackView.distribution = .fillEqually
        
        // Home Team
        homeTeamStackView.translatesAutoresizingMaskIntoConstraints = false
        homeTeamStackView.spacing = 8
        homeTeamStackView.axis = .vertical
        
        homeTeamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        homeTeamScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        homeTeamScoreLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        homeTeamScoreLabel.textAlignment = .center
        
        homeTeamRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        homeTeamRecordLabel.font = UIFont.preferredFont(forTextStyle: .body)
        homeTeamRecordLabel.textAlignment = .center
        
        // Visitor Team
        visitorTeamStackView.translatesAutoresizingMaskIntoConstraints = false
        visitorTeamStackView.spacing = 8
        visitorTeamStackView.axis = .vertical
        
        visitorTeamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        visitorTeamScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        visitorTeamScoreLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        visitorTeamScoreLabel.textAlignment = .center
        
        visitorTeamRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        visitorTeamRecordLabel.font = UIFont.preferredFont(forTextStyle: .body)
        visitorTeamRecordLabel.textAlignment = .center
        
        // Game Infos
        gameStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        gameStatusLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        gameStatusLabel.textAlignment = .center
        gameStatusLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    private func layout() {
        
        homeTeamStackView.addArrangedSubview(homeTeamLogoImageView)
        homeTeamStackView.addArrangedSubview(homeTeamRecordLabel)
        
        visitorTeamStackView.addArrangedSubview(visitorTeamLogoImageView)
        visitorTeamStackView.addArrangedSubview(visitorTeamRecordLabel)
        
        rootStackView.addArrangedSubview(homeTeamStackView)
        rootStackView.addArrangedSubview(homeTeamScoreLabel)
        rootStackView.addArrangedSubview(gameStatusLabel)
        rootStackView.addArrangedSubview(visitorTeamScoreLabel)
        rootStackView.addArrangedSubview(visitorTeamStackView)
        
        contentView.addSubview(rootStackView)
        
        // Automatically activate constraints routine
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
