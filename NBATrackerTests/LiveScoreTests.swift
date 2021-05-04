//
//  LiveScoreTests.swift
//  NBATrackerTests
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import XCTest
@testable import NBATracker

class LiveScoreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanParseLiveScoresViaJSONFile() throws {
        
        // Guard the path string where the file is on disk
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "livescores", ofType: "json") else {
            fatalError("json not found")
        }
        
        // Guard content file to JSON
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
                    fatalError("Unable to convert json to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let liveScoresData = try! JSONDecoder().decode(LiveScoreBoardsRawResponse.self, from: jsonData)
        
        XCTAssertEqual(7, liveScoresData.scoreboards.count, "Number of games is not equal to 7.")
        
    }
}
