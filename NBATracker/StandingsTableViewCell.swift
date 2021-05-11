//
//  StandingsTableViewCell.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-09.
//

import UIKit

class StandingsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "StandingsCellIdentifier"
    
    var posString = String()
    
    let rootStackView = UIStackView()
    let statsStackView = UIStackView()
    let posLabel = UILabel()
    let teamLabel = UILabel()
    let winsLabel = UILabel()
    let lossesLabel = UILabel()
    let winPercentageLabel = UILabel()
    let gamesBehindLabel = UILabel()
    let lastTenLabel = UILabel()
    let streakLabel = UILabel()
    
    var standing: Standing? {
        didSet {
            updateUI()
        }
    }
    
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

extension StandingsTableViewCell {
    
    private func updateUI() {
        teamLabel.text = standing?.teamFullName
        winsLabel.text = String(standing!.wins)
        lossesLabel.text = String(standing!.losses)
        winPercentageLabel.text = CustomNumberFormatters.convertDoubleToDecimalString(for: standing!.winPercentage)
        gamesBehindLabel.text = String(standing!.gamesBehind)
        lastTenLabel.text = standing?.lastTen
        streakLabel.text = standing?.streak
        if standing!.clinchedPlayoffs {
            posLabel.attributedText = NSAttributedString(string: posString, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
        } else {
            posLabel.attributedText = NSAttributedString(string: posString, attributes:
                [.underlineStyle: 0])
        }
    }
    
    private func styleCell() {
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .horizontal
        
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        
        posLabel.translatesAutoresizingMaskIntoConstraints = false
        posLabel.font = UIFont.preferredFont(forTextStyle: .body)
        posLabel.textAlignment = .center
        
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        teamLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        winsLabel.translatesAutoresizingMaskIntoConstraints = false
        winsLabel.font = UIFont.preferredFont(forTextStyle: .body)
        winsLabel.textAlignment = .center
        
        lossesLabel.translatesAutoresizingMaskIntoConstraints = false
        lossesLabel.font = UIFont.preferredFont(forTextStyle: .body)
        lossesLabel.textAlignment = .center
        
        winPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        winPercentageLabel.font = UIFont.preferredFont(forTextStyle: .body)
        winPercentageLabel.textAlignment = .center
        
        gamesBehindLabel.translatesAutoresizingMaskIntoConstraints = false
        gamesBehindLabel.font = UIFont.preferredFont(forTextStyle: .body)
        gamesBehindLabel.textAlignment = .center
        
        lastTenLabel.translatesAutoresizingMaskIntoConstraints = false
        lastTenLabel.font = UIFont.preferredFont(forTextStyle: .body)
        lastTenLabel.textAlignment = .center
        
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
        streakLabel.font = UIFont.preferredFont(forTextStyle: .body)
        streakLabel.textAlignment = .center
        
    }
    
    private func layout() {
        
        statsStackView.addArrangedSubview(winsLabel)
        statsStackView.addArrangedSubview(lossesLabel)
        statsStackView.addArrangedSubview(winPercentageLabel)
        statsStackView.addArrangedSubview(gamesBehindLabel)
        statsStackView.addArrangedSubview(lastTenLabel)
        statsStackView.addArrangedSubview(streakLabel)
        
        rootStackView.addArrangedSubview(posLabel)
        rootStackView.addArrangedSubview(teamLabel)
        rootStackView.addArrangedSubview(statsStackView)
        
        contentView.addSubview(rootStackView)
        
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            posLabel.widthAnchor.constraint(equalTo: rootStackView.widthAnchor, multiplier: Constants.WidthMultipliersStandings.posMultiplier.rawValue),
            teamLabel.widthAnchor.constraint(equalTo: rootStackView.widthAnchor, multiplier: Constants.WidthMultipliersStandings.teamNameMultiplier.rawValue),
            statsStackView.widthAnchor.constraint(equalTo: rootStackView.widthAnchor, multiplier: Constants.WidthMultipliersStandings.statsMultiplier.rawValue),
        ])
    }
}
