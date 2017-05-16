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
    
    // Creating singleton instance
    private static let _instance = Mapper ()
    static var Instance = {
        return _instance
    }()


    func mapObject(source: BaseEntity, destination: PFObject) -> PFObject{

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
    

    func convertFromParticipantPFObject(participants dataSet: [PFObject]) -> [Participant] {
        log.debug("Mapping data for \(dataSet.count) participants")
        var participants: [Participant] = []

        for data in dataSet {
            if let data = data as? Participant {
                participants.append(data)
            }
        }
        return participants
    }

    func convertFromAlarmPFObject(alarms dataSet: [PFObject]) -> [Alarm] {
        log.debug("Mapping data for \(dataSet.count) alarm")
        var alarmData: [Alarm] = []

        for data in dataSet {
            if let data = data as? Alarm {
                alarmData.append(data)
            }
        }

        return alarmData
    }

    func convertFromParticipantAlarmsPFObject(participantAlarm dataSet: [PFObject]) -> [ParticipantAlarm] {
        log.debug("Mapping data for \(dataSet.count) participant alarms")
        var participantAlarms: [ParticipantAlarm] = []

        for data in dataSet {
            if let data = data as? ParticipantAlarm {
                participantAlarms.append(data)
            }
        }
        return participantAlarms
    }
}
