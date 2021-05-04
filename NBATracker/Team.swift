//
//  Team.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-03.
//  http://data.nba.net/10s/prod/v2/2020/teams.json

import Foundation

struct TeamsRawResponse {
    
    let teams: [Team]
}

extension TeamsRawResponse: Decodable {
    
    private enum RootKeys: String, CodingKey {
        
        case league = "league"
        
        enum LeagueKeys: String, CodingKey {
            
            case standard = "standard"
            
            enum StandardKeys: String, CodingKey {
                
                case teamId = "teamId"
                case teamName = "nickname"
                case cityName = "city"
                case tricode = "tricode"
                case urlName = "urlName"
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        
        // Root level
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        // League level
        let leagueContainer = try container.nestedContainer(keyedBy: RootKeys.LeagueKeys.self, forKey: .league)
        
        // Standard level
        let standard = try leagueContainer.decode([Team].self, forKey: .standard)
        self.teams = standard
    }
}

struct Team {
    
    let id: String
    let name: String
    let city: String
    let tricode: String
    let urlName: String
    
    var fullName: String {
        return "\(city) \(name)"
    }
}

extension Team: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "teamId"
        case name = "nickname"
        case city = "city"
        case tricode = "tricode"
        case urlName = "urlName"
    }
}
