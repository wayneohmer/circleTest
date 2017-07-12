//
//  CircleTestTests.swift
//  CircleTestTests
//
//  Created by Wayne Ohmer on 7/12/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import XCTest
@testable import CircleTest

class CircleTestTests: XCTestCase {
    
    var rounterStatusTest:RouterStatus?
    
    override func setUp() {
        super.setUp()
        if let path = Bundle.main.path(forResource: "RouterData", ofType: "json") {
            do {
                let routerData = try Data(contentsOf: URL(fileURLWithPath:path))
                do {
                    if let routerDict = try JSONSerialization.jsonObject(with: routerData) as? [String:Any] {
                        self.rounterStatusTest = RouterStatus(dict:routerDict)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    override func tearDown() {
        self.rounterStatusTest = nil
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertNotNil(self.rounterStatusTest,"routerStatus object is nil")
        //Bail if we don't have an object to test.
        if self.rounterStatusTest == nil { return }
        
        XCTAssertEqual(self.rounterStatusTest!.result, "success", "result is Wrong")
        XCTAssertEqual(self.rounterStatusTest!.manufacturer, "SuperRouter", "manufacturer is Wrong")
        XCTAssertEqual(self.rounterStatusTest!.model, "Fast Plus A4000-N", "model is Wrong")
        
        XCTAssertTrue(self.rounterStatusTest!.reachability,"reachability is Wrong")
        XCTAssertTrue(self.rounterStatusTest!.firmwareUpdateAvailable,"firmwareUpdateAvailable is Wrong")
        //We could test every object, but we get the idea.
        XCTAssertEqual(self.rounterStatusTest!.devices.count, 3, "device count is wrong")
        
        XCTAssertEqual(self.rounterStatusTest!.visited.count, 3, "visited count is wrong")

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
