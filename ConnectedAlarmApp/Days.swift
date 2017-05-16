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

    @NSManaged var day: String!
    
    struct WeekDay {
        static let Sunday: String = "Sunday"
        static let Monday: String = "Monday"
        static let Tuesday: String = "Tuesday"
        static let Wednesday: String = "Wednesday"
        static let Thursday: String = "Thursday"
        static let Friday: String = "Friday"
        static let Saturday: String = "Saturday"
    }
}

extension Days: PFSubclassing {
    static func parseClassName() -> String {
        return "Days"
    }
}
