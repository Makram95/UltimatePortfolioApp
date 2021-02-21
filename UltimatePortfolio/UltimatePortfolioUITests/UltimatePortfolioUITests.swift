//
//  UltimatePortfolioUITests.swift
//  UltimatePortfolioUITests
//
//  Created by Marc on 21.02.21.
//

import XCTest

class UltimatePortfolioUITests: XCTestCase {

    var app: XCUIApplication!
    
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }


    func testExample() throws {
        XCTAssertEqual(app.tabBars.buttons.count, 4, "There should be 4 tabs")
    }

    func testOpenTabAddsProjects(){

        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially")
        
        for tapCount in 1...5 {
            app.buttons["add"].tap()
            XCTAssertEqual(app.tables.cells.count, tapCount, "There should be \(tapCount) list rows")
        }
    }
    
    func testAddingItemInsertsRows(){
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially")

        app.buttons["add"].tap()
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 list rows ")
        
        app.buttons["Add New Item"].tap()
        XCTAssertEqual(app.tables.cells.count, 2, "There should be 2list rows")
    }
    
    func testEditingProjectUpdatesCorrectly() {
        
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially")

        app.buttons["add"].tap()
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 list rows ")
        
        app.buttons["NEW PROJECT"].tap()
        app.textFields["Project name"].tap()
        app.keys["Leerzeichen"].tap()
        app.keys["more"].tap()
        app.keys["2"].tap()
        app.buttons["Return"].tap()
        
        app.buttons["Open Projects"].tap()
        XCTAssertTrue(app.buttons["NEW PROJECT 2"].exists, "Project should be renamed")


    }
    
    func testEditingItemUpdatesCorrectly() {
        // Add one project and one item
        testAddingItemInsertsRows()
        
        app.buttons["New Item"].tap()
        app.textFields["Item name"].tap()
        app.keys["Leerzeichen"].tap()
        app.keys["more"].tap()
        app.keys["2"].tap()
        app.buttons["Return"].tap()
        
        app.buttons["Open Projects"].tap()
        XCTAssertTrue(app.buttons["New Item 2"].exists, "Item should be added to the list")
    }
    
    
    func testAllAwardsShowLockedAlert(){

        app.buttons["Awards"].tap()
        
        for award in app.scrollViews.buttons.allElementsBoundByIndex{
            award.tap()
            XCTAssertTrue(app.alerts["Locked"].exists, "The wards should be locked")
            app.buttons["OK"].tap()
        }
        
    }
}
