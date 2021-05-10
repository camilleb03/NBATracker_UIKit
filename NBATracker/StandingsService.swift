//
//  StandingsService.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-09.
//

import Foundation


class StandingsService {
    
    func fetchConferenceStandings() -> ConferenceStandings {
        
        var conferenceStandings = ConferenceStandings()
        let components = [
            Standing(id: "0", name: "Atlanta Hawks"),
            Standing(id: "1", name: "Toronto Raptors"),
            Standing(id: "2", name: "Golden State Warriors"),
            Standing(id: "3", name: "Orlando Magic"),
            Standing(id: "4", name: "Boston Celtics"),
            Standing(id: "5", name: "LA Lakers"),
        ]
        
        for i in 0...2 {
            conferenceStandings.east.append(components[i])
        }
        
        for i in 3...5 {
            conferenceStandings.west.append(components[i])
        }
        
        return conferenceStandings
    }
}
