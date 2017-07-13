//
//  RouterDevice.swift
//  CircleTest
//
//  Created by Wayne Ohmer on 7/12/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

class RouterDevice: NSObject {
    
    fileprivate struct JSONKeys {
        static let name = "name"
        static let manufacturer = "manufacturer"
        static let model = "model"
        static let type = "type"
        static let mac = "mac"
        static let serial = "serial"
        static let connectedStatus = "connectedStatus"
    }
    
    var name = ""
    var manufacturer = ""
    var model = ""
    var type = ""
    var mac = ""
    var serial = "serial"

    // optional to accomdate -1 for "unknown"
    var connectedStatus:Bool? = nil
    
    convenience init(dict:[String:Any]) {
        
        self.init()
        self.name = dict[JSONKeys.name] as? String ?? ""
        self.manufacturer = dict[JSONKeys.manufacturer] as? String ?? ""
        self.model = dict[JSONKeys.model] as? String ?? ""
        self.type = dict[JSONKeys.type] as? String ?? ""
        self.mac = dict[JSONKeys.mac] as? String ?? ""
        self.serial = dict[JSONKeys.serial] as? String ?? ""
        if let connectedInt = dict[JSONKeys.connectedStatus] as? Int {
            // leave connectedSatus nil if "unknown"  
            // intergers that are not -1 or 1 will result in connectedStatus false. 
            // could make nil for bad data? depends on error handling.  
            if connectedInt != -1 {
                self.connectedStatus = connectedInt == 1
            }
        }
    }
}
