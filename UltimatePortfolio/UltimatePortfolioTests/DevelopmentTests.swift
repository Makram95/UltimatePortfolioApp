//
//  DevelopmentTests.swift
//  UltimatePortfolioTests
//
//  Created by Marc on 27.01.21.
//

import XCTest
import CoreData
@testable import UltimatePortfolio

class DevelopmentTests: BaseTestCase {

    func testSampleDataCreationWorks() throws{
        try dataController.createSampleDate()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 50)

    }

    func testDeleteAllClearsEverything() throws {
        try dataController.createSampleDate()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0)

    }

    func testExampleProjectIsClosed(){
        let project = Project.example
        XCTAssertTrue(project.closed, "Project should be closed")
    }

    func testExampleItemIsHighPriority(){
        let item = Item.example
        XCTAssertEqual(item.priority, 3, "Item should be high-priority")
    }

}
