//
//  DateFormater.swift
//  CircleTest
//
//  Created by Wayne Ohmer on 7/12/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

extension DateFormatter {
    
    convenience init(dateFormat:String)
    {
        self.init()
        self.dateFormat = dateFormat
    }
}
