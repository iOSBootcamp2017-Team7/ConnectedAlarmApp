//
//  AlarmService.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/13/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

struct AlarmService {

    // Creating singleton instance
    private static let _instance = AlarmService ()
    static var Instance = {
       return _instance
    }()
    
    func fetchParticipantAlarms(offset:Int = 0, limit: Int = 20, alarmType: AlarmStatusType, sucess: @escaping ([Alarm]) -> (), failure: @escaping (Error) -> ()) {
        log.debug("fetching alarms from Parse for alarmType \(alarmType.rawValue)")
        
        let includeKeys: [String] = ["alarm", "alarm.alarmTime", "alarm.adminUser", "alarm.participants.user", "user"]
        var whereKeys: [String : Any] = [:]
        whereKeys.updateValue(alarmType.rawValue, forKey: "status")
        whereKeys.updateValue(PFUser.current()!, forKey: "user")
        log.debug("Current user = \(String(describing: PFUser.current()!.username))")
        
        log.debug("Include keys are \(includeKeys)")
        
        DBManager.Instance.getCollectionFromParse(offset: offset, limit: limit, includeKeys: includeKeys, whereKeys: whereKeys, collectionName: ParticipantAlarm.parseClassName(), sucess: { (data: [PFObject]) in
            
            var alarmData: [Alarm] = []
            
            let participantAlarms: [ParticipantAlarm] = Mapper.Instance.convertFromParticipantAlarmsPFObject(participantAlarm: data)
            
            if participantAlarms.isEmpty == false {
                
                for participantAlarm in participantAlarms {
                    alarmData.append(participantAlarm.alarm)
                }                   
            }
            
            sucess(alarmData)
            
        }) { (error: Error) in
            failure(error)
        }
    }
    
    func updateParticipantAlarmStatus(alarm: Alarm, status: AlarmStatusType, sucess: @escaping (Bool) -> (), failure: @escaping (Error) -> ()) {
        log.debug("Updating alarm status as \(status.rawValue) for alarmid \(String(describing: alarm.objectId))" )

        var whereKeys: [String : Any] = [:]
        whereKeys.updateValue(alarm, forKey: "alarm")
        whereKeys.updateValue(PFUser.current()!, forKey: "user")
        
       DBManager.Instance.getCollectionFromParse(whereKeys: whereKeys, collectionName: ParticipantAlarm.parseClassName(), sucess: { (data: [PFObject]) in
        
        let participantAlarms: [ParticipantAlarm] = Mapper.Instance.convertFromParticipantAlarmsPFObject(participantAlarm: data)
        
        for participantAlarm in participantAlarms {
            participantAlarm.status = status.rawValue
            participantAlarm.saveInBackground()
        }
        
        sucess(true)
       }) { (error: Error) in
        failure(error)
        }
    }
}
