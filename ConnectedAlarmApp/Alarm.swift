//
//  Alarm.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/6/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class Alarm: BaseEntity {
    @NSManaged var adminUser: PFUser!
    @NSManaged var alarmTime: AlarmTime!
    @NSManaged var status: String?
    @NSManaged var startDate: Date!
    @NSManaged var endDate: Date?
    @NSManaged var duration: String?
    @NSManaged var participants: [Participant]!
}
extension Alarm: PFSubclassing {
    static func parseClassName() -> String {
        return "Alarm"
    }
}
