//
//  EventTests.swift
//  finalProjectMA
//
//  Created by Laszlo Bogacsi on 07/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import Foundation
import XCTest
@testable import finalProjectMA

class EventsTests {
    func testEventInitialization(){
        let potentialEvent = Event(name: "New Event", time: "Today", location: "50 Commercial Street")
        XCTAssertNotNil(potentialItem)
    }
}


