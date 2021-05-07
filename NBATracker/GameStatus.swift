//
//  GameStatus.swift
//  NBATracker
//
//  Created by Camille Bourbonnais on 2021-05-06.
//

import Foundation

enum GameStatus {
    case isUnitiated
    case isPlaying
    case isHalftime
    case isEndOfPeriod
    case isFinished
    case undefined
    
    static func setGameStatus(statusNum: Int, isHalftime: Bool, isEndOfPeriod: Bool) -> Self {
        
        if statusNum == 1 {
            // Game not started
            return .isUnitiated
        } else if statusNum == 2 {
            if isHalftime {
                // Game is in halftime
                return .isHalftime
            }
            if isEndOfPeriod {
                // Game is in the end of a period
                return .isEndOfPeriod
            }
            // Game is ongoing
            return .isPlaying
        } else if statusNum == 3 {
            // Game is over
            return .isFinished
        }
        // Not supposed to happen
        return .undefined
    }
}
