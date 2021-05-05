//
//  APIError.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import Foundation

enum APIError: LocalizedError {
    case statusCode(Int)
    case emptyData
    
    var errorDescription: String? {
        switch self {
        case .statusCode(let code):
            return "Error with status code: \(code)"
        case .emptyData:
            return "No data found"
        }
    }
}
