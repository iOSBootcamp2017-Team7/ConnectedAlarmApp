//
//  Participant.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/6/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class Participant: BaseEntity {
    @NSManaged var user: PFUser?
    @NSManaged var score: String?
    @NSManaged var status: String!
}

extension Participant: PFSubclassing {
    static func parseClassName() -> String {
        return "Participant"
    }
}
