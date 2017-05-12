//
//  Pedometerutils.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/12/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import CoreMotion

struct PedometerUtil {
    
    static let sharedInstance = PedometerUtil()
    static let pedometer = CMPedometer()
    
    func didFinishSteps(sucess: @escaping (Bool) -> (), failure: @escaping (Error) -> ()) {
        PedometerUtil.pedometer.startUpdates(from: Date(), withHandler: { (data: CMPedometerData?, error: Error?) in
            if error != nil {
                print("\(String(describing: error?.localizedDescription))")
                failure(error!)
            } else {
                if let stepCount = data?.numberOfSteps {
                    if Int(stepCount) > 10 {
                        PedometerUtil.pedometer.stopUpdates()
                        sucess(true)
                    }
                }
            }
        })
    }
}
