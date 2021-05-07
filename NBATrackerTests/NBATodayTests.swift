//
//  NBATodayTests.swift
//  NBATrackerTests
//
//  Created by Camille Bourbonnais on 2021-05-05.
//

import XCTest
@testable import NBATracker

class NBATodayTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanParseTodayViaJSONFile() throws {
        
        // Guard the path string where the file is on disk
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "today", ofType: "json") else {
            fatalError("json not found")
        }
        
        // Guard content file to JSON
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
                    fatalError("Unable to convert json to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let todayData = try! JSONDecoder().decode(NBAToday.self, from: jsonData)
        XCTAssertEqual("20210505", todayData.currentDateUrlCode, "DateUrlCode is not in the right format")
        XCTAssertEqual(2020, todayData.seasonScheduleYear, "The season schedule year is not 2020.")
        
    }

}
