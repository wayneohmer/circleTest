//
//  RouterVisited.swift
//  CircleTest
//
//  Created by Wayne Ohmer on 7/12/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

class RouterVisited: NSObject {
    
    fileprivate struct JSONKeys {
        static let date = "date"
        static let mac = "mac"
        static let sites = "sites"
    }
    
    //static so we only create this once.  
    static let dateFormatter = DateFormatter(dateFormat: "YYYY-MM-dd")
    
    var date:Date?
    var mac = ""
    var sites = [[String:String]]()
 
    convenience init(dict:[String:Any]) {
        
        self.init()
        
        if let dateString = dict[JSONKeys.date] as? String {
            self.date = RouterVisited.dateFormatter.date(from: dateString)
        }
        
        self.mac = dict[JSONKeys.mac] as? String ?? ""
        self.sites = dict[JSONKeys.sites] as? [[String:String]] ?? [[String:String]]()
    }
}
