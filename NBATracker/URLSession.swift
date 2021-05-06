//
//  URLSession.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-06.
//

import Foundation

extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    @discardableResult
    func request(
        _ endpoint: Endpoint,
        then handler: @escaping Handler
    ) -> URLSessionDataTask {
        let task = dataTask(
            with: endpoint.nbaUrl,
            completionHandler: handler
        )

        task.resume()
        return task
    }
}
