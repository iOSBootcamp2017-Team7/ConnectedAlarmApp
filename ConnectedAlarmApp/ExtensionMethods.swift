//
//  ExtensionMethods.swift
//  ConnectedAlarmApp
//
//  Created by Weijie Chen on 5/4/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import Foundation
import UIKit

extension String{
    var digits: String{
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
