//
//  AlarmManager.swift
//  ConnectedAlarmApp
//
//  Created by Bhagat, Puneet on 5/7/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import AVFoundation

class AlarmManager: NSObject {
    
    static func PlayAlarm(view: UIViewController) {
        
        // create a sound ID, in this case its the tweet sound.
        let systemSoundID: SystemSoundID = 1016
        
        // to play sound
        let alarmTimer = Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true, block: { (timer) in
            AudioServicesPlaySystemSound (systemSoundID)
        })
        
        let alert = UIAlertController(title: "Alarm", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { (action) in
            alarmTimer.invalidate()
        }))
        view.present(alert, animated: true, completion: nil)
    }
}
