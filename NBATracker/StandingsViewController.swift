//
//  StandingsViewController.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-07.
//

import Foundation
import UIKit

class StandingsViewController: BaseViewController {
    
    let cellIdentifier = "StandingsCellIdentifier"
    let headerIdentifier = "StandingsHeaderIdentifier"

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
    }
    
    func layout() {
        view.addSubview(collectionView)
        // Automatically activate constraints routine
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                layout.itemSize = CGSize(width: 60, height: 60)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        // Conform itself as the data source and the delegate
        collectionView.dataSource = self
        
        // Delegate is for user interaction
        collectionView.delegate = self
        
        // Register cells to use in TableView
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(StandingsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
}

// MARK: - Collection View Delegate
extension StandingsViewController: UICollectionViewDelegate {
}

// MARK: - Data Source Delegate
extension StandingsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath as IndexPath) as! StandingsSectionHeader
            
            if indexPath.section == 0 {
                headerView.label.text = "WEST"
                
            }
            else {
                headerView.label.text = "EAST"
            }
            
            headerView.backgroundColor = UIColor.yellow;
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension StandingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}
