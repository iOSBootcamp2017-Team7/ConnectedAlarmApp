//
//  Mapper.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/7/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class Mapper {
    
    static func mapObject(source: BaseEntity, destination: PFObject) -> PFObject{

        switch source.parseClassName {
            case Participant.parseClassName():
                let participant: Participant = source as! Participant
                destination ["user"] = participant.user
                destination ["score"] = participant.score
                destination ["status"] = participant.status
            case Alarm.parseClassName():
                let alarm: Alarm = source as! Alarm
                destination ["adminUser"] = alarm.adminUser
                destination ["alarmTime"] = alarm.alarmTime
                destination ["status"] = alarm.status
                destination ["startDate"] = alarm.startDate
                destination ["endDate"] = alarm.endDate
                destination ["duration"] = alarm.duration
                destination ["participants"] = alarm.participants
            case ParticipantAlarm.parseClassName():
                let participantAlarm: ParticipantAlarm = source as! ParticipantAlarm
                destination ["user"] = participantAlarm.user
                destination ["alarm"] = participantAlarm.alarm
                destination ["status"] = participantAlarm.status
            default:
                print("class name not found")
        }
        return destination
    }
    
}
