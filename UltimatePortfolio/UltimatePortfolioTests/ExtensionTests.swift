//
//  ExtensionTests.swift
//  UltimatePortfolioTests
//
//  Created by Marc on 05.02.21.
//

import XCTest
import SwiftUI

@testable import UltimatePortfolio
class ExtensionTests: XCTestCase {

    func testSequenceKeyPathSortingSelf() {
        let items = [1,4,3,2,5]
        let sortedItems = items.sorted(by: \.self)
        XCTAssertEqual(sortedItems, [1,2,3,4,5], "Sorted numbers must be ascending.")
    }
    
    func testSequenceKeyPathSortingCustom(){
        struct Example: Equatable{
            let value: String
        }
        let example1 = Example(value: "a")
        let example2 = Example(value: "b")
        let example3 = Example(value: "c")
        
        let array = [example1, example2, example3]
        
        let sortedItems = array.sorted(by: \.value) {
            $0 > $1
        }
        XCTAssertEqual(sortedItems, [example3, example2, example1], "Should yield c,b,a.")
    }

    func testBundleDecodingAwards(){
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty, "awards array shouldd not be empty")
    }
    
    func testDecodingString(){
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")
        XCTAssertEqual(data, "The rain in Spain falls mainly on the Spaniards", "Strings must match!")
    }
    
    func testDecodingDictionary(){
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode([String: Int].self, from: "DecodableDictionairy.json")
        XCTAssertEqual(data.count, 3, "there should be 3 items decoded")
        XCTAssertEqual(data["One"], 1, "String to int mappings should work")
    }
    
    func testBindingOnChange(){
        var onChangeFunctionRun = false
        
        func exampleFunctionToCall(){
            onChangeFunctionRun = true
        }
        
        var storedValue = ""
        
        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0}
        )
        let changedBinding = binding.onChange(exampleFunctionToCall)
        
        changedBinding.wrappedValue = "test"
        
        XCTAssertTrue(onChangeFunctionRun, "the onChange() function must be run")
        
    }
}
