//
//  RouterStatus.swift
//  CircleTest
//
//  Created by Wayne Ohmer on 7/12/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

class RouterStatus: NSObject {
    
     fileprivate struct JSONKeys {
        static let result = "result"
        static let manufacturer = "manufacturer"
        static let model = "model"
        static let reachability = "reachability"
        static let firmwareUpdateAvailable = "firmwareUpdateAvailable"
        static let devices = "devices"
        static let visited = "visited"
    }
    
    var result = ""
    var model = ""
    var manufacturer = ""
    // isReachable and isFirmwareUpdateAvailable would be more Swifty names, 
    // I think being consistant with the JSON keys causes less confusion.
    var reachability = false
    var firmwareUpdateAvailable = false
    var devices = [RouterDevice]()
    var visited = [RouterVisited]()

    convenience init(dict:[String:Any]) {
        
        self.init()
        self.result = dict[JSONKeys.result] as? String ?? ""
        self.manufacturer = dict[JSONKeys.manufacturer] as? String ?? ""
        self.model = dict[JSONKeys.model] as? String ?? ""
        
        if let reachable = dict[JSONKeys.reachability] as? Int {
            //assuming anything other than 1 is false. Could error out here if reachable != 0 or 1
            self.reachability = reachable == 1
        }
        
        if let firmwareUpdate = dict[JSONKeys.firmwareUpdateAvailable] as? Int {
            //assuming anything other than 1 is false. Could error out here if firmwareUpdate != 0 or 1
            self.firmwareUpdateAvailable = firmwareUpdate == 1
        }
        
        if let deviceArray = dict[JSONKeys.devices] as? [[String:Any]] {
            for deviceDict in deviceArray {
                self.devices.append(RouterDevice(dict:deviceDict))
            }
        }
        
        if let visitedArray = dict[JSONKeys.visited] as? [[String:Any]] {
            for visitedDict in visitedArray {
                self.visited.append(RouterVisited(dict:visitedDict))
            }
        }
    }
}
