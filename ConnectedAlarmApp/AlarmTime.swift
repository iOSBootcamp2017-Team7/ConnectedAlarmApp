//
//  AlarmTime.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/6/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class AlarmTime: BaseEntity {
    
    var alarmTime: Date!
    var daysOfWeek: Array<Days>?
}

extension AlarmTime: PFSubclassing {
    static func parseClassName() -> String {
        return "AlarmTime"
    }
}
