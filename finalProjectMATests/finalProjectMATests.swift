//
//  finalProjectMATests.swift
//  finalProjectMATests
//
//  Created by Dionysis Kastellanis on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import XCTest
@testable import finalProjectMA

class finalProjectMATests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
        func testEventInitialization(){
            let potentialEvent = Event(name: "New Event", time: "Today", location: "50 Commercial Street")
            XCTAssertNotNil(potentialEvent)
        }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
