//
//  ConferenceStandingsTests.swift
//  NBATrackerTests
//
//  Created by Camille Bourbonnais on 2021-05-11.
//

import XCTest
@testable import NBATracker

class ConferenceStandingsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConferenceTotalTeamsCount() throws {

        // Guard the path string where the file is on disk
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "confstandings", ofType: "json") else {
            fatalError("json not found")
        }
        
        // Guard content file to JSON
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
                    fatalError("Unable to convert json to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try decoder.decode(StandingsRawResponse.self, from: jsonData)
        
        XCTAssertEqual(15, response.conferenceStandings.eastStandings.count)
        XCTAssertEqual(15, response.conferenceStandings.westStandings.count)
    }
    
    func testCanParseStanding() throws {
        
        let json = """
        {
            "_internal": {
                "pubDateTime": "2021-05-10 14:39:10.123 EDT",
                "igorPath": "S3,1620671945303,1620671949313|router,1620671949313,1620671949317|domUpdater,1620671949430,1620671949814|feedProducer,1620671949937,1620671951117",
                "xslt": "NBA/xsl/league/standings/marty_conference_standings.xsl",
                "xsltForceRecompile": "true",
                "xsltInCache": "false",
                "xsltCompileTimeMillis": "124",
                "xsltTransformTimeMillis": "301",
                "endToEndTimeMillis": "5814"
            },
            "league": {
                "standard": {
                    "seasonYear": 2020,
                    "seasonStageId": 2,
                    "conference": {
                        "east": [
                            {
                                "teamId": "1610612755",
                                "win": "47",
                                "loss": "21",
                                "winPct": ".691",
                                "winPctV2": "69.1",
                                "lossPct": ".309",
                                "lossPctV2": "30.9",
                                "gamesBehind": "0.0",
                                "divGamesBehind": "0.0",
                                "clinchedPlayoffsCode": "P",
                                "clinchedPlayoffsCodeV2": "x",
                                "confRank": "",
                                "confWin": "29",
                                "confLoss": "9",
                                "divWin": "10",
                                "divLoss": "2",
                                "homeWin": "27",
                                "homeLoss": "7",
                                "awayWin": "20",
                                "awayLoss": "14",
                                "lastTenWin": "8",
                                "lastTenLoss": "2",
                                "streak": "8",
                                "divRank": "",
                                "isWinStreak": true,
                                "teamSitesOnly": {
                                    "teamKey": "Philadelphia",
                                    "teamName": "Philadelphia",
                                    "teamCode": "sixers",
                                    "teamNickname": "76ers",
                                    "teamTricode": "PHI",
                                    "clinchedConference": "0",
                                    "clinchedDivision": "0",
                                    "clinchedPlayoffs": "1",
                                    "streakText": "W 8"
                                },
                                "tieBreakerPts": "",
                                "sortKey": {
                                    "defaultOrder": 1,
                                    "nickname": 1,
                                    "win": 3,
                                    "loss": 28,
                                    "winPct": 3,
                                    "gamesBehind": 29,
                                    "confWinLoss": 1,
                                    "divWinLoss": 2,
                                    "homeWinLoss": 2,
                                    "awayWinLoss": 4,
                                    "lastTenWinLoss": 1,
                                    "streak": 1
                                }
                            }
                        ],
                        "west": [
                            {
                                "teamId": "1610612760",
                                "win": "21",
                                "loss": "48",
                                "winPct": ".304",
                                "winPctV2": "30.4",
                                "lossPct": ".696",
                                "lossPctV2": "69.6",
                                "gamesBehind": "29.5",
                                "divGamesBehind": "29.5",
                                "clinchedPlayoffsCode": "E",
                                "clinchedPlayoffsCodeV2": "o",
                                "confRank": "",
                                "confWin": "11",
                                "confLoss": "28",
                                "divWin": "3",
                                "divLoss": "8",
                                "homeWin": "9",
                                "homeLoss": "25",
                                "awayWin": "12",
                                "awayLoss": "23",
                                "lastTenWin": "1",
                                "lastTenLoss": "9",
                                "streak": "7",
                                "divRank": "",
                                "isWinStreak": false,
                                "teamSitesOnly": {
                                    "teamKey": "Oklahoma City",
                                    "teamName": "Oklahoma City",
                                    "teamCode": "thunder",
                                    "teamNickname": "Thunder",
                                    "teamTricode": "OKC",
                                    "clinchedConference": "0",
                                    "clinchedDivision": "0",
                                    "clinchedPlayoffs": "0",
                                    "streakText": "L 7"
                                },
                                "tieBreakerPts": "",
                                "sortKey": {
                                    "defaultOrder": 28,
                                    "nickname": 26,
                                    "win": 27,
                                    "loss": 3,
                                    "winPct": 28,
                                    "gamesBehind": 2,
                                    "confWinLoss": 29,
                                    "divWinLoss": 28,
                                    "homeWinLoss": 29,
                                    "awayWinLoss": 24,
                                    "lastTenWinLoss": 29,
                                    "streak": 29
                                }
                            }
                        ]
                    }
                }
            }
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try decoder.decode(StandingsRawResponse.self, from: jsonData)
        
        XCTAssertEqual("Philadelphia 76ers", response.conferenceStandings.eastStandings[0].teamFullName)
        XCTAssertEqual(47, response.conferenceStandings.eastStandings[0].wins)
        XCTAssertEqual(21, response.conferenceStandings.eastStandings[0].losses)
        XCTAssertEqual(0.691, response.conferenceStandings.eastStandings[0].winPercentage)
        XCTAssertEqual(0.0, response.conferenceStandings.eastStandings[0].gamesBehind)
        XCTAssertEqual("8-2", response.conferenceStandings.eastStandings[0].lastTen)
        XCTAssertEqual("W8", response.conferenceStandings.eastStandings[0].streak)
        XCTAssertEqual(true, response.conferenceStandings.eastStandings[0].clinchedPlayoffs)
        
        XCTAssertEqual("Oklahoma City Thunder", response.conferenceStandings.westStandings[0].teamFullName)
        XCTAssertEqual(21, response.conferenceStandings.westStandings[0].wins)
        XCTAssertEqual(48, response.conferenceStandings.westStandings[0].losses)
        XCTAssertEqual(0.304, response.conferenceStandings.westStandings[0].winPercentage)
        XCTAssertEqual(29.5, response.conferenceStandings.westStandings[0].gamesBehind)
        XCTAssertEqual("1-9", response.conferenceStandings.westStandings[0].lastTen)
        XCTAssertEqual("L7", response.conferenceStandings.westStandings[0].streak)
        XCTAssertEqual(false, response.conferenceStandings.westStandings[0].clinchedPlayoffs)
    }
}
