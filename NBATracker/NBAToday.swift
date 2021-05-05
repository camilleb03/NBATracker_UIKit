//
//  NBAToday.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-05.
//  http://data.nba.net/10s/prod/v2/today.json

import Foundation

struct NBAToday {
    
    let currentDateString: String
    let seasonScheduleYear: Int
    
    var currentDateDisplay: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: dateFormatter.date(from: currentDateString)!)
    }
}

extension NBAToday: Decodable {

    private enum RootKeys: String, CodingKey {

        case seasonScheduleYear = "seasonScheduleYear"
        case links = "links"
        
        enum LinksKeys: String, CodingKey {
            
            case currentDateString = "currentDate"
        }
    }

    init(from decoder: Decoder) throws {

        // Root level
        let container = try decoder.container(keyedBy: RootKeys.self)
        self.seasonScheduleYear = try container.decode(Int.self, forKey: .seasonScheduleYear)

        // Links level
        let leagueContainer = try container.nestedContainer(keyedBy: RootKeys.LinksKeys.self, forKey: .links)
        self.currentDateString = try leagueContainer.decode(String.self, forKey: .currentDateString)
    }
}
