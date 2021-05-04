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
    let currentPeriod: Int
    let visitorTeam: SBTeam
    let homeTeam: SBTeam
    
}

extension LiveScoreBoard: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "gameId"
        case gameUrlCode = "gameUrlCode"
        case period = "period"
        case visitorTeam = "vTeam"
        case homeTeam = "hTeam"
        
        enum PeriodKeys: String, CodingKey {
            
            case currentPeriod = "current"
        }
    }
    
    init(from decoder: Decoder) throws {
        
        // Root level
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.gameUrlCode = try container.decode(String.self, forKey: .gameUrlCode)
        self.visitorTeam = try container.decode(SBTeam.self, forKey: .visitorTeam)
        self.homeTeam = try container.decode(SBTeam.self, forKey: .homeTeam)
        
        // Period level
        let periodContainer = try container.nestedContainer(keyedBy: CodingKeys.PeriodKeys.self, forKey: .period)
        self.currentPeriod = try periodContainer.decode(Int.self, forKey: .currentPeriod)
    }
}

struct SBTeam: Decodable {
    
    let teamId: String
    let triCode: String
    let win: String
    let loss: String
    let score: String
}
