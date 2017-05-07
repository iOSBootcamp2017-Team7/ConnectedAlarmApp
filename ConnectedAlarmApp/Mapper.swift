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
        default:
            print("class name not found")
        }
        return destination
    }
    
}
