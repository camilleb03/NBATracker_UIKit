//
//  TeamLogoCacheManager.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-06.
//

import Foundation

class TeamLogoCacheManager {

    static var shared = TeamLogoCacheManager()

    private var logoImages = NSCache<NSString, NSData>()

    func fetch(for teamTriCode: String, completion: @escaping (Result<Data, Error>) -> Void) {
        // Create a URL object (which points to the endpoint of the NBA API)
        let url = Endpoint.logo(for: teamTriCode).logoUrl

        if let imageData = logoImages.object(forKey: url.absoluteString as NSString) {
            completion(.success(imageData as Data))
          return
        }


        URLSession.shared.downloadTask(with: url) { localUrl, response, error in

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

            guard let localUrl = localUrl else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.emptyData))
                }
                return
            }

            do {
                let data = try Data(contentsOf: localUrl)
                self.logoImages.setObject(data as NSData, forKey: url.absoluteString as NSString)


                completion(.success(data))
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }

        }.resume()
    }
}
