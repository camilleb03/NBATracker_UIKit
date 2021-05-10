//
//  StandingsSectionHeader.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-09.
//

import Foundation
import UIKit

class StandingsSectionHeader: UICollectionReusableView {
    
    static let reuseIdentifier = "title-supplementary-reuse-identifier"
    
    var confLabel: UILabel = {
        let confLabel: UILabel = UILabel()
        confLabel.translatesAutoresizingMaskIntoConstraints = false
        confLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        confLabel.sizeToFit()
        confLabel.textAlignment = .center
        return confLabel
    }()
    
    var rootHeaderStackView: UIStackView = {
        let rootHeaderStackView = UIStackView()
        rootHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        rootHeaderStackView.axis = .vertical
        return rootHeaderStackView
    }()
    
    var statsStackView: UIStackView = {
        let statsStackView = UIStackView()
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillProportionally
        return statsStackView
    }()
    
    var teamLabel: UILabel = {
        let teamLabel: UILabel = UILabel()
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        teamLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        teamLabel.sizeToFit()
        teamLabel.text = "Team"
        return teamLabel
    }()
    
    var winLabel: UILabel = {
        let winLabel: UILabel = UILabel()
        winLabel.translatesAutoresizingMaskIntoConstraints = false
        winLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        winLabel.sizeToFit()
        winLabel.text = "W"
        return winLabel
    }()
    
    var lossLabel: UILabel = {
        let lossLabel: UILabel = UILabel()
        lossLabel.translatesAutoresizingMaskIntoConstraints = false
        lossLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lossLabel.sizeToFit()
        lossLabel.text = "L"
        return lossLabel
    }()
    
    var winPercentageLabel: UILabel = {
        let winPercentageLabel: UILabel = UILabel()
        winPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        winPercentageLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        winPercentageLabel.sizeToFit()
        winPercentageLabel.text = "Pct"
        return winPercentageLabel
    }()
    
    var gamesBehindLabel: UILabel = {
        let gamesBehindLabel: UILabel = UILabel()
        gamesBehindLabel.translatesAutoresizingMaskIntoConstraints = false
        gamesBehindLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        gamesBehindLabel.sizeToFit()
        gamesBehindLabel.text = "GB"
        return gamesBehindLabel
    }()
    
    var streakLabel: UILabel = {
        let streakLabel: UILabel = UILabel()
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
        streakLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        streakLabel.sizeToFit()
        streakLabel.text = "Strk"
        return streakLabel
    }()
    
    var lastTenLabel: UILabel = {
        let lastTenLabel: UILabel = UILabel()
        lastTenLabel.translatesAutoresizingMaskIntoConstraints = false
        lastTenLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lastTenLabel.sizeToFit()
        lastTenLabel.text = "L10"
        return lastTenLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StandingsSectionHeader {
    
    private func configure() {
        
        statsStackView.addArrangedSubview(teamLabel)
        statsStackView.addArrangedSubview(winLabel)
        statsStackView.addArrangedSubview(lossLabel)
        statsStackView.addArrangedSubview(winPercentageLabel)
        statsStackView.addArrangedSubview(gamesBehindLabel)
        statsStackView.addArrangedSubview(lastTenLabel)
        statsStackView.addArrangedSubview(streakLabel)
        
        rootHeaderStackView.addArrangedSubview(confLabel)
        
        let separator = UIView()
        separator.backgroundColor = .black
        rootHeaderStackView.addArrangedSubview(separator)
        
        rootHeaderStackView.addArrangedSubview(statsStackView)
        addSubview(rootHeaderStackView)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            rootHeaderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            rootHeaderStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            rootHeaderStackView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            rootHeaderStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            separator.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
