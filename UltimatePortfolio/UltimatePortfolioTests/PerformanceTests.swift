//
//  PerformanceTests.swift
//  UltimatePortfolioTests
//
//  Created by Marc on 15.02.21.
//

import XCTest
@testable import UltimatePortfolio

class PerformanceTests: BaseTestCase {

    func testAwardCalculationPerformance() throws{
        // create a significant amount of test data
        for _ in 1...100{
            try dataController.createSampleDate()
        }
    
        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the number of awards is constant")
        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
