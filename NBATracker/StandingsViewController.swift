//
//  StandingsViewController.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-07.
//

import Foundation
import UIKit

class StandingsViewController: BaseViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    enum Section: CaseIterable {
        case east, west
    }

    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Standing>! = nil
    let standingsService = StandingsService()
    var conferenceStandings = ConferenceStandings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "list.number", title: "Standings")
        setNavBarTitle(title: "Conference Standings")
    }
}

extension StandingsViewController {
    
    func style() {
        
    }
    
    func layout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(44)),
            elementKind: StandingsViewController.sectionHeaderElementKind,
            alignment: .top)
        
        sectionHeader.pinToVisibleBounds = true
        sectionHeader.zIndex = 2
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout())
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(StandingsCollectionViewCell.self, forCellWithReuseIdentifier: StandingsCollectionViewCell.reuseIdentifier)
        collectionView.register(StandingsSectionHeader.self,
                                forSupplementaryViewOfKind: StandingsViewController.sectionHeaderElementKind,
                   withReuseIdentifier: StandingsSectionHeader.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        
        // Create Diffable Data Source and connect to Collection View
        dataSource = UICollectionViewDiffableDataSource<Section, Standing>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Standing) -> UICollectionViewCell? in
            
            // A constructor that passes the collection view as input, and returns a cell as output
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: StandingsCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? StandingsCollectionViewCell else { fatalError("Cannot create new cell") }
            
            cell.teamLabel.text = identifier.name
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            // Get a supplementary view of the desired kind.
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: StandingsSectionHeader.reuseIdentifier,
                    for: indexPath) as? StandingsSectionHeader else { fatalError("Cannot create new supplementary") }
            
            if indexPath.section == 0 {
                supplementaryView.confLabel.text = "WEST"
            }
            else {
                supplementaryView.confLabel.text = "EAST"
            }
            
            supplementaryView.backgroundColor = .lightGray
            
            // Return the view.
            return supplementaryView
        }
        
        // Populate conference standings
        fetch()
        update(with: self.conferenceStandings)
    }
    
    private func fetch() {
        self.conferenceStandings = standingsService.fetchConferenceStandings()
    }
    
    func update(with list: ConferenceStandings, animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Standing>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list.east, toSection: .east)
        snapshot.appendItems(list.west, toSection: .west)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
