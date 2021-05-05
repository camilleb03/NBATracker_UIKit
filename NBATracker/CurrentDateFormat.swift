//
//  CurrentDateFormat.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-05.
//

import Foundation

func getCurrentDateString(with format: String) -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}
