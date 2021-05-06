//
//  Endpoint.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-05.
//

import Foundation

// TODO: Refactor to have seperate URL access for nba and logo
struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    
    var nbaUrl: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "data.nba.net"
        components.path = "/10s/prod/v2/" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
    var logoUrl: URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cdn.nba.net"
        components.path = "/assets/logos/teams/primary/web/" + path

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
    
    // https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/1610612745/2019/260x190/201935.png
}

extension Endpoint {
    static var today: Self {
        Endpoint(path: "today.json")
    }

    static func scoreboard(for date: String) -> Self {
        Endpoint(path: "\(date)/scoreboard.json")
    }

    static func teams(for seasonYear: String) -> Self {
        Endpoint(path: "\(seasonYear)/teams.json")
    }
    
    static func logo(for teamTriCode: String) -> Self {
        Endpoint(path: "\(teamTriCode).png")
    }
}
