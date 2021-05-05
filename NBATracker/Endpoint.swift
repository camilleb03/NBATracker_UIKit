//
//  Endpoint.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-05.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
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
}
