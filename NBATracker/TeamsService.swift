//
//  TeamsService.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-03.
//

import Foundation

protocol TeamsServiceDelegate {
    
    func teamsFetched(_ teams: [Team])
    
}

class TeamsService {
    
    var delegate: TeamsServiceDelegate?
    
    func fetchTeams() {
        // Create a URL object (which points to the endpoint of the NBA API)
        let year = NBATodayService.nbaToday?.seasonScheduleYear ?? Int(getCurrentDateString(with: "yyyy"))!
        let url = Endpoint.teams(for: String(year)).url
        
        // Get a URLSession object -> does the networking stuff :')
        let session = URLSession.shared
        
        // Get a data task (represents a single call to the API) from the URLSession
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            // Check if there was any error
            if error != nil || data == nil {
                 return
            }
            
            do {
                
                // Parsing the data into Team object
                let decoder = JSONDecoder()

                // Parse data as a TeamsWrapper object
                let response = try decoder.decode(TeamsRawResponse.self, from: data!)
                
                if response.teams != nil  {
                    
                    // UI related executed on main thread
                    DispatchQueue.main.async {
                        // Call the "teamsFetched" of the delegate which will call the method in subscribed class
                        self.delegate?.teamsFetched(response.teams)
                    }

                }
            } catch {
                
            }
            
        }
        
        // Kick off the task
        dataTask.resume()
    }
}
