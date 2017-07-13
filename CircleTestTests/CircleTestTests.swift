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
    
    var routerStatusTest:RouterStatus?
    
    override func setUp() {
        
        super.setUp()
        if let path = Bundle.main.path(forResource: "RouterData", ofType: "json") {
            do {
                let routerData = try Data(contentsOf: URL(fileURLWithPath:path))
                do {
                    if let routerDict = try JSONSerialization.jsonObject(with: routerData) as? [String:Any] {
                        self.routerStatusTest = RouterStatus(dict:routerDict)
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
        self.routerStatusTest = nil
        super.tearDown()
    }
    
    func testRouterStatus() {

        XCTAssertNotNil(self.routerStatusTest)
        //Bail if we don't have an object to test.
        if self.routerStatusTest == nil {
            return
        }
        
        XCTAssertEqual(self.routerStatusTest!.result, "success")
        XCTAssertEqual(self.routerStatusTest!.manufacturer, "SuperRouter")
        XCTAssertEqual(self.routerStatusTest!.model, "Fast Plus A4000-N")
        
        XCTAssertTrue(self.routerStatusTest!.reachability)
        XCTAssertTrue(self.routerStatusTest!.firmwareUpdateAvailable)
        
        //We could test every device and visited object, but we get the idea. Just making sure the count it correct.
        XCTAssertEqual(self.routerStatusTest!.devices.count, 3)
        XCTAssertEqual(self.routerStatusTest!.visited.count, 3)

    }
    
    // test first device in routerStatusTest
    func testDevice() {
        
        if let routerStatus = self.routerStatusTest {
            if routerStatus.devices.count > 0 {
                
                let device = routerStatus.devices[0]
                XCTAssertEqual(device.name, "Billy's phone")
                XCTAssertEqual(device.manufacturer, "Apple")
                XCTAssertEqual(device.model, "iPhone 7")
                XCTAssertEqual(device.type, "Phone")
                XCTAssertEqual(device.mac, "80:00:00:00:00:AC")
                XCTAssertEqual(device.serial, "7200000NA1")
                XCTAssertNotNil(device.connectedStatus)
                
                if let connectedStatus = device.connectedStatus{
                    XCTAssertFalse(connectedStatus)
                }
            }
        }
    }
    
    // test first visited in routerStatusTest
    func testVisited() {
        
        if let routerStatus = self.routerStatusTest {
            if routerStatus.visited.count > 0 {
                let visited = routerStatus.visited[0]
                XCTAssertNotNil(visited.date)
                
                if let date = visited.date {
                    let testDate = RouterVisited.dateFormatter.date(from: "2017-03-14")
                    XCTAssertEqual(date,testDate)
                }
                
                XCTAssertEqual(visited.mac, "80:00:00:00:00:BD")
                XCTAssertEqual(visited.sites.count,2)
                
                if visited.sites.count == 2 {
                    XCTAssertEqual(visited.sites[0]["domain"], "yahoo.com")
                    XCTAssertEqual(visited.sites[1]["domain"], "facebook.com")
                }
            }
        }
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
