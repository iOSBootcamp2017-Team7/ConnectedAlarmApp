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
    
    // Creating singleton instance
    private static let _instance = DBManager ()
    static var Instance = {
        return _instance
    }()
    
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
       var entityObject = PFObject(className: entity.parseClassName)
        entityObject =  Mapper.Instance.mapObject(source: entity, destination: entityObject)
        entityObject.saveInBackground { (saved:Bool, error:Error?) in
            if error != nil {
                failure(error!)
            } else {
                sucess(saved)
            }
        }
    }
    
    func getCollectionFromParse(offset:Int = 0, limit: Int = 20, includeKeys:[String] = [], whereKeys: [String : Any] = [:], collectionName: String, sucess: @escaping ([PFObject]) -> (), failure: @escaping (Error) -> ()) {
        
        let query = PFQuery(className: collectionName)
        
        // Setting offset and limit
        query.limit = limit
        query.skip = offset

        log.debug("Querying parse for offset = \(offset), limit = \(limit)")
        
//        query.cachePolicy = PFCachePolicy.cacheElseNetwork
        query.addAscendingOrder("objectId")
        
        if whereKeys.isEmpty == false {
            for keyPair in whereKeys {
                query.whereKey(keyPair.key, equalTo: keyPair.value)
            }
        }

        log.debug(String(describing: query))
        
        if includeKeys.count > 0 {
            query.includeKeys(includeKeys)
        }
        
        query.findObjectsInBackground { (data: [PFObject]?, error: Error?) in
            
            if error != nil {
                failure(error!)
                return
            }
            
            log.info("\(collectionName) retrieved from Parse")
            log.debug("data : \(data!)")
            
            sucess(data!)
        }
    }
    
    func getCollectionById(primaryId: String, collectionName: String, sucess: @escaping (PFObject) -> (), failure: @escaping (Error) -> ()) {
        
        log.debug("Getting collection by Id for " + collectionName)
        
        let query = PFQuery(className: collectionName)
        query.getObjectInBackground(withId: primaryId) { (data: PFObject?, error: Error?) in
            
            if error != nil {
                failure(error!)
                return
            }
        
            log.info("\(collectionName) retrieved from Parse")
            sucess(data!)
        }
    }
}

