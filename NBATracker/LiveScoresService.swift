//
//  LiveScoresService.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import Foundation

struct LiveScoresService {
    
    func fetch(for date: String, completion: @escaping (Result<[LiveScoreBoard], Error>) -> Void) {
        
        // Create a URL object (which points to the endpoint of the NBA API)
        let url = Endpoint.scoreboard(for: date).nbaUrl
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
                decoder.dateDecodingStrategy = .formatted(CustomDateFormatters.iso8601FullFormatter)
                let response = try decoder.decode(LiveScoreBoardsRawResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.scoreboards))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
