//
//  StandingsService.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-09.
//

import Foundation


class StandingsService {
    
    func fetchConferenceStandings(completion: @escaping (Result<ConferenceStandings, Error>) -> Void) {
        
        // Create a URL object (which points to the endpoint of the NBA API)
        let url = Endpoint.confStandings.nbaUrl
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            // Guard if there is a response
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            
            // Guard response status codes between 200 and 299 are OK
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.statusCode(httpResponse.statusCode)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.emptyData))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(StandingsRawResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.conferenceStandings))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
