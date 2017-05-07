//
//  ParticipantAlarm.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/7/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class ParticipantAlarm: BaseEntity {
    var userId: String!
    var alarmId: String!
    var status: Status?
}

extension ParticipantAlarm: PFSubclassing {
    static func parseClassName() -> String {
        return "ParticipantAlarm"
    }
}
