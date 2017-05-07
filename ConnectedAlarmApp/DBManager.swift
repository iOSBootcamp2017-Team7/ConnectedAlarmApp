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
}

