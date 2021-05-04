//
//  TeamTests.swift
//  NBATrackerTests
//
//  Created by Camille Bourbonnais on 2021-05-04.
//

import XCTest
@testable import NBATracker

class TeamTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCanParseTeam() throws {
        let json = """
        {
            "_internal": {
                "pubDateTime": "2020-11-17 10:30:16.813 EST",
                "igorPath": "cron,1605627010823,1605627010823|router,1605627010823,1605627010828|domUpdater,1605627011040,1605627016242|feedProducer,1605627016447,1605627017092",
                "xslt": "NBA/xsl/league/roster/marty_teams_list.xsl",
                "xsltForceRecompile": "true",
                "xsltInCache": "true",
                "xsltCompileTimeMillis": "335",
                "xsltTransformTimeMillis": "238",
                "consolidatedDomKey": "prod__transform__marty_teams_list__1929228391129",
                "endToEndTimeMillis": "6269"
            },
            "league": {
                "standard": [
                    {
                        "isNBAFranchise": true,
                        "isAllStar": false,
                        "city": "Atlanta",
                        "altCityName": "Atlanta",
                        "fullName": "Atlanta Hawks",
                        "tricode": "ATL",
                        "teamId": "1610612737",
                        "nickname": "Hawks",
                        "urlName": "hawks",
                        "teamShortName": "Atlanta",
                        "confName": "East",
                        "divName": "Southeast"
                    }
                ],
                "africa": [],
                "sacramento": [],
                "vegas": [],
                "utah": []
            }
        }
        """
        let jsonData = json.data(using: .utf8)!
        let teamsData = try! JSONDecoder().decode(TeamsWrapper.self, from: jsonData)
        
        XCTAssertEqual("1610612737", teamsData.teams[0].id)
        XCTAssertEqual("Hawks", teamsData.teams[0].name)
        XCTAssertEqual("Atlanta", teamsData.teams[0].city)
        XCTAssertEqual("ATL", teamsData.teams[0].tricode)
        XCTAssertEqual("hawks", teamsData.teams[0].urlName)
    }
    
    func testIsFullNameCorrect() throws {
        let json = """
        {
            "_internal": {
                "pubDateTime": "2020-11-17 10:30:16.813 EST",
                "igorPath": "cron,1605627010823,1605627010823|router,1605627010823,1605627010828|domUpdater,1605627011040,1605627016242|feedProducer,1605627016447,1605627017092",
                "xslt": "NBA/xsl/league/roster/marty_teams_list.xsl",
                "xsltForceRecompile": "true",
                "xsltInCache": "true",
                "xsltCompileTimeMillis": "335",
                "xsltTransformTimeMillis": "238",
                "consolidatedDomKey": "prod__transform__marty_teams_list__1929228391129",
                "endToEndTimeMillis": "6269"
            },
            "league": {
                "standard": [
                    {
                        "isNBAFranchise": true,
                        "isAllStar": false,
                        "city": "Atlanta",
                        "altCityName": "Atlanta",
                        "fullName": "Atlanta Hawks",
                        "tricode": "ATL",
                        "teamId": "1610612737",
                        "nickname": "Hawks",
                        "urlName": "hawks",
                        "teamShortName": "Atlanta",
                        "confName": "East",
                        "divName": "Southeast"
                    }
                ],
                "africa": [],
                "sacramento": [],
                "vegas": [],
                "utah": []
            }
        }
        """
        let jsonData = json.data(using: .utf8)!
        let teamsData = try! JSONDecoder().decode(TeamsWrapper.self, from: jsonData)
        
        XCTAssertEqual("Atlanta Hawks", teamsData.teams[0].fullName)
    }
    
    func testCanParseTeamsViaJSONFile() throws {
        
        // Guard the path string where the file is on disk
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "teams", ofType: "json") else {
            fatalError("json not found")
        }
        
        // Guard content file to JSON
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
                    fatalError("Unable to convert json to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let teamsData = try! JSONDecoder().decode(TeamsWrapper.self, from: jsonData)
        
        XCTAssertEqual(30, teamsData.teams.count, "Number of NBA teams is not equal to 30.")
        
    }

}
