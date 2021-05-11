//
//  Standing.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-09.
//

import Foundation

struct StandingsRawResponse {
    
    let conferenceStandings: ConferenceStandings
    
}

extension StandingsRawResponse: Decodable {
    
    private enum RootKeys: String, CodingKey {
        
        case league = "league"
        
        enum LeagueKeys: String, CodingKey {
            
            case standard = "standard"
            
            enum StandardKeys: String, CodingKey {
                
                case conference = "conference"
                
                enum ConferenceKeys: String, CodingKey {
                    
                    case east
                    case west
                
                }
                
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        
        // Root level
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        // League level
        let leagueContainer = try container.nestedContainer(keyedBy: RootKeys.LeagueKeys.self, forKey: .league)
        
        // Standard level
        let standardContainer = try leagueContainer.nestedContainer(keyedBy: RootKeys.LeagueKeys.StandardKeys.self, forKey: .standard)
        
        // Conference level
        let conferenceContainer = try standardContainer.nestedContainer(keyedBy: RootKeys.LeagueKeys.StandardKeys.ConferenceKeys.self, forKey: .conference)
        let eastStandings = try conferenceContainer.decode([Standing].self, forKey: .east)
        let westStandings = try conferenceContainer.decode([Standing].self, forKey: .west)
        
        self.conferenceStandings = ConferenceStandings(eastStandings: eastStandings, westStandings: westStandings)
        
    }
}

enum Conference {
    case east
    case west
}

struct ConferenceStandings {
    
    internal init(eastStandings: [Standing], westStandings: [Standing]) {
        self.eastStandings = eastStandings
        self.westStandings = westStandings
    }
    
    var eastStandings: [Standing]
    var westStandings: [Standing]
    
    mutating func sortStandingsByWinPercentage() {
        
        self.eastStandings = eastStandings.sorted(by: {
            $0.winPercentage > $1.winPercentage
        })
        
        self.westStandings = westStandings.sorted(by: {
            $0.winPercentage > $1.winPercentage
        })
    }

}

struct Standing {
    
    let teamId: Int
    let teamFullName: String
    let wins: Int
    let losses: Int
    let winPercentage: Double
    let gamesBehind: Double
    let lastTen: String
    let streak: String
    let clinchedPlayoffs: Bool
    
}

extension Standing: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case teamId = "teamId"
        case wins = "win"
        case losses = "loss"
        case winPercentage = "winPct"
        case gamesBehind = "gamesBehind"
        case lastTenWin = "lastTenWin"
        case lastTenLoss = "lastTenLoss"
        case streak = "streak"
        case isWinStreak = "isWinStreak"
        
        case teamSitesOnly = "teamSitesOnly"
        
        enum TeamSitesOnlyKeys: String, CodingKey {
            
            case teamName = "teamName"
            case teamNickname = "teamNickname"
            case clinchedPlayoffs = "clinchedPlayoffs"
            
        }
        
    }
    
    init(from decoder: Decoder) throws {
        
        // Root level
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Team id
        guard let teamIdInt = Int(try container.decode(String.self, forKey: .teamId)) else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: container.codingPath + [CodingKeys.teamId], debugDescription: "value for \"teamId\" needs to be a valid Int"))
        }
        self.teamId = teamIdInt
        
        // Win number
        guard let winsInt = Int(try container.decode(String.self, forKey: .wins)) else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: container.codingPath + [CodingKeys.wins], debugDescription: "value for \"win\" needs to be a valid Int"))
        }
        self.wins = winsInt
        
        // Loss number
        guard let lossesInt = Int(try container.decode(String.self, forKey: .losses)) else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: container.codingPath + [CodingKeys.losses], debugDescription: "value for \"loss\" needs to be a valid Int"))
        }
        self.losses = lossesInt
        
        // Win Percentage
        guard let winPercentageDouble = Double(try container.decode(String.self, forKey: .winPercentage)) else {
            throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: container.codingPath + [CodingKeys.winPercentage], debugDescription: "value for \"winPct\" needs to be a valid Double"))
        }
        self.winPercentage = winPercentageDouble
        
        // Games behind
        guard let gamesBehindDouble = Double(try container.decode(String.self, forKey: .gamesBehind)) else {
            throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: container.codingPath + [CodingKeys.gamesBehind], debugDescription: "value for \"gamesBehind\" needs to be a valid Double"))
        }
        self.gamesBehind = gamesBehindDouble
        
        // Last ten games
        let lastTenWin = try container.decode(String.self, forKey: .lastTenWin)
        let lastTenLoss = try container.decode(String.self, forKey: .lastTenLoss)
        self.lastTen = "\(lastTenWin)-\(lastTenLoss)"
        
        // Streak
        let streakString = try container.decode(String.self, forKey: .streak)
        let isWinStreak = try container.decode(Bool.self, forKey: .isWinStreak)
        self.streak = isWinStreak ? "W\(streakString)" : "L\(streakString)"
        
        // TeamSitesOnly level
        let teamSitesOnlyContainer = try container.nestedContainer(keyedBy: CodingKeys.TeamSitesOnlyKeys.self, forKey: .teamSitesOnly)
        
        let teamNickname = try teamSitesOnlyContainer.decode(String.self, forKey: .teamNickname)
        let teamName = try teamSitesOnlyContainer.decode(String.self, forKey: .teamName)
        self.teamFullName = "\(teamNickname)"
        
        let clinchedPlayoffsString = try teamSitesOnlyContainer.decode(String.self, forKey: .clinchedPlayoffs)
        self.clinchedPlayoffs = clinchedPlayoffsString == "1" ? true : false
        
    }
}
