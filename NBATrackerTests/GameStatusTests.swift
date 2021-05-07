//
//  GameStatusTests.swift
//  NBATrackerTests
//
//  Created by Camille Bourbonnais on 2021-05-06.
//

import XCTest
@testable import NBATracker

class GameStatusTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSetGameStatusIsUnitiated() throws {
        let statusGame = 1
        let isHalftime = false
        let isEndOfPeriod = false
        XCTAssertEqual(GameStatus.isUnitiated, GameStatus.setGameStatus(statusNum: statusGame, isHalftime: isHalftime, isEndOfPeriod: isEndOfPeriod))
    }
    
    func testSetGameStatusIsPlaying() throws {
        let statusGame = 2
        let isHalftime = false
        let isEndOfPeriod = false
        XCTAssertEqual(GameStatus.isPlaying, GameStatus.setGameStatus(statusNum: statusGame, isHalftime: isHalftime, isEndOfPeriod: isEndOfPeriod))
    }
    
    func testSetGameStatusIsHalftime() throws {
        let statusGame = 2
        let isHalftime = true
        let isEndOfPeriod = false
        XCTAssertEqual(GameStatus.isHalftime, GameStatus.setGameStatus(statusNum: statusGame, isHalftime: isHalftime, isEndOfPeriod: isEndOfPeriod))
    }
    
    func testSetGameStatusIsEndPeriod() throws {
        let statusGame = 2
        let isHalftime = false
        let isEndOfPeriod = true
        XCTAssertEqual(GameStatus.isEndOfPeriod, GameStatus.setGameStatus(statusNum: statusGame, isHalftime: isHalftime, isEndOfPeriod: isEndOfPeriod))
    }
    
    func testSetGameStatusIsFinished() throws {
        let statusGame = 3
        let isHalftime = false
        let isEndOfPeriod = false
        XCTAssertEqual(GameStatus.isFinished, GameStatus.setGameStatus(statusNum: statusGame, isHalftime: isHalftime, isEndOfPeriod: isEndOfPeriod))
    }
    
    func testSetGameStatusUndefined() throws {
        let statusGame = 4
        let isHalftime = false
        let isEndOfPeriod = false
        XCTAssertEqual(GameStatus.undefined, GameStatus.setGameStatus(statusNum: statusGame, isHalftime: isHalftime, isEndOfPeriod: isEndOfPeriod))
    }
}
