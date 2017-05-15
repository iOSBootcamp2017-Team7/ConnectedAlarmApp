//
//  DBManager.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/7/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class DBManager {
    
    static let sharedInstance = DBManager()
    
    func fetchCurrentUserByUsername(username: String, sucess: @escaping (PFObject) -> (), failure: @escaping (Error) -> ()) {
        let query: PFQuery = PFUser.query()!
        query.whereKey("username", equalTo: username)
        query.findObjectsInBackground { (users: [PFObject]?, error:Error?) in
            if users != nil {
                for user in users! {
                    sucess(user)
                }
            }
            
            if error != nil {
                failure(error!)
            }
        }
    }

    
    
    func fetchAllUsers(sucess: @escaping ([PFObject]) -> (), failure: @escaping (Error) -> ()) {
        let query: PFQuery = PFUser.query()!
        query.findObjectsInBackground { (users: [PFObject]?, error:Error?) in
            if users != nil {
                
                sucess(users!)
            }
            if error != nil {
                failure(error!)
            }
        }
    }
    

    func fetchAllAlarm(sucess: @escaping ([PFObject]) -> (), failure: @escaping (Error) -> ()) {
        let query: PFQuery = PFQuery(className: "Alarm")
        query.whereKey("status", equalTo: Status.ACTIVE)
        query.findObjectsInBackground { (alarms: [PFObject]?, error:Error?) in
            if alarms != nil {
                sucess(alarms!)
            }
            if error != nil {
                failure(error!)
            }
        }
    }

    
    func fetchParticipantAlarm(user: PFUser?, sucess: @escaping ([PFObject]) -> (), failure: @escaping (Error) -> ()) {
        let query: PFQuery = PFQuery(className: "ParticipantAlarm")
        query.whereKey("status", equalTo: Status.ACTIVE)
        
        if user != nil {
            query.whereKey("userId", equalTo: user?.username as Any)
        }
        
        query.findObjectsInBackground { (participantAlarm: [PFObject]?, error:Error?) in
            if participantAlarm != nil {
                sucess(participantAlarm!)
            }
            if error != nil {
                failure(error!)
            }
        }
    }
    
    func saveEntity(entity: BaseEntity, sucess: @escaping (Bool) -> (), failure: @escaping (Error) -> ()) {
       var entityObject = PFObject(className: (entity.parseClassName))
        entityObject =  Mapper.mapObject(source: entity, destination: entityObject)
        entityObject.saveInBackground { (saved:Bool, error:Error?) in
            if error != nil {
                failure(error!)
            } else {
                sucess(saved)
            }
        }
    }
    
}

