//
//  Constants.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import Foundation
import UIKit

// Static keyword, so we don't need to declare Constants
struct Constants {
    
    // API
    static var API_URL = "http://data.nba.net/10s/prod/v2"
    
    // Project
    
    enum WidthMultipliersStandings: CGFloat {
        case posMultiplier = 0.075
        case teamNameMultiplier = 0.25
        case statsMultiplier = 0.675
    }
    
}
