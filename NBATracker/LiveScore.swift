//
//  LiveScore.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//  http://data.nba.net/10s/prod/v2/20210504/scoreboard.json

import Foundation

struct LiveScoreBoardsRawResponse {
    
    let scoreboards: [LiveScoreBoard]
}

extension LiveScoreBoardsRawResponse: Decodable {
    
    private enum RootKeys: String, CodingKey {
        
        case games = "games"
        
    }
    
    init(from decoder: Decoder) throws {
        
        // Root level
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        // Games level
        let games = try container.decode([LiveScoreBoard].self, forKey: .games)
        self.scoreboards = games
    }
}

struct LiveScoreBoard {
    
    let id: String
    let gameUrlCode: String
    let isGameActivated: Bool
    let isHalftime: Bool
    let isEndOfPeriod: Bool
    let startTimeUTC: Date
    let currentPeriod: Int
    let clock: String
    let visitorTeam: SBTeam
    let homeTeam: SBTeam
    //TODO: formatter as an attribute ?
    var localStartTimeString: String {
        let formatter = DateFormatter()
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
        print(localTimeZoneAbbreviation)
        formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
        formatter.timeStyle = .short
        return formatter.string(from: self.startTimeUTC)
    }
    
    var localStartDateString: String {
        let formatter = DateFormatter()
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
        formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
        formatter.dateStyle = .medium
        return formatter.string(from: self.startTimeUTC)
    }
}

extension LiveScoreBoard: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "gameId"
        case gameUrlCode = "gameUrlCode"
        case isGameActivated = "isGameActivated"
        case startTimeUTC = "startTimeUTC"
        case period = "period"
        case clock = "clock"
        case visitorTeam = "vTeam"
        case homeTeam = "hTeam"
        
        enum PeriodKeys: String, CodingKey {
            
            case currentPeriod = "current"
            case isHalftime = "isHalftime"
            case isEndOfPeriod = "isEndOfPeriod"
        }
    }
    
    init(from decoder: Decoder) throws {
        
        // Root level
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.gameUrlCode = try container.decode(String.self, forKey: .gameUrlCode)
        self.isGameActivated = try container.decode(Bool.self, forKey: .isGameActivated)
        
        self.startTimeUTC = try container.decode(Date.self, forKey: .startTimeUTC)
        self.clock = try container.decode(String.self, forKey: .clock)
        
        self.visitorTeam = try container.decode(SBTeam.self, forKey: .visitorTeam)
        self.homeTeam = try container.decode(SBTeam.self, forKey: .homeTeam)
        
        // Period level
        let periodContainer = try container.nestedContainer(keyedBy: CodingKeys.PeriodKeys.self, forKey: .period)
        self.currentPeriod = try periodContainer.decode(Int.self, forKey: .currentPeriod)
        self.isHalftime = try periodContainer.decode(Bool.self, forKey: .isHalftime)
        self.isEndOfPeriod = try periodContainer.decode(Bool.self, forKey: .isEndOfPeriod)
    }
}

struct SBTeam: Decodable {
    
    let teamId: String
    let triCode: String
    let win: String
    let loss: String
    let score: String
}
