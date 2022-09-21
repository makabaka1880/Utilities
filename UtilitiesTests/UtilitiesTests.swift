//
//  UtilitiesTests.swift
//  UtilitiesTests
//
//  Created by SeanLi on 2022/9/24.
//

import XCTest
@testable import Utilities

final class UtilitiesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let first = Utility()
        let second = Utility()
        let last = Utility()
        var i = [first, last]
        print("__")
        print(first.rawValue)
        print(first.rawValue)
        print("___")
        replace(&i, item: first, with: second)
        XCTAssertEqual(i, [second, last])
    }
    
    func test() throws {
        let test = """
        {
            "id" : "F10BAD1C-B36D-4400-9F93-A321F471A5C8",
            "symbol" : "car.fill",
            "asyncFetch" : true,
            "name" : "New Utility",
            "command" : "echo \"Command New Utility Executed\""
        }
        """
        let _t = """
        {
            "id" : "F10BAD1C-B36D-4400-9F93-A321F471A5C8",
            "symbol" : "car.fill",
            "asyncFetch" : true,
            "name" : "New Utility",
            "command" : "echo \"Command New Utility Executed\""
        }
        """
        XCTAssert(test == _t)
    }
    func testTest() throws {
        XCTAssert("E61B3A35-9530-435E-BC17-0BCB9116D27A" == "E61B3A35-9530-435E-BC17-0BCB9116D27A")
    }
}
