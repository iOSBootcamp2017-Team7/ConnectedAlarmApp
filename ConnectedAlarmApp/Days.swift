//
//  Days.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/6/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class Days: BaseEntity {

    var day: String!
    
    struct WeekDay {
        static let Monday = "Monday"
        static let Tuesday = "Tuesday"
        static let Wednesday = "Wednesday"
        static let Thursday = "Thursday"
        static let Friday = "Friday"
        static let Saterday = "Saterday"
        static let Sunday = "Sunday"
    }
}

extension Days: PFSubclassing {
    static func parseClassName() -> String {
        return "Days"
    }
}
