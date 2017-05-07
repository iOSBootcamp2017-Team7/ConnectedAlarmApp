//
//  Alarm.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/6/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class Alarm: NSObject {

    var adminUser: PFUser!
    var alarmTime: AlarmTime!
    var status: Status?
    var startDate: Date!
    var endDate: Date?
    var duration: String?
    var participants: Array<Participant>!
    
}
