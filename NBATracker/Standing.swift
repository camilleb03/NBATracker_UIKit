//
//  Standing.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-09.
//

import Foundation

struct Standing {

    let id: String
    let name: String
    
}

extension Standing: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Standing, rhs: Standing) -> Bool {
            lhs.id == rhs.id
        }
}

struct ConferenceStandings {
    var west: [Standing] = []
    var east: [Standing] = []
}
