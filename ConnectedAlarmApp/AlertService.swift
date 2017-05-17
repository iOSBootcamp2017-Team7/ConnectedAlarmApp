//
//  AlertService.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/13/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit

class AlertService: UIViewController {
    
    // Creating singleton instance
    private static let _instance = AlertService()
    static let Instance = {
       return _instance
    }()
    
    func alertWithNoAction(fromController controller: UIViewController, title: String, alertText: String) {
        let alert = UIAlertController(title: title, message: alertText, preferredStyle: UIAlertControllerStyle.alert)
        let dismiss = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(dismiss)
        controller.present(alert, animated: true, completion: nil)

    }
    
    func alertWithAction(fromController controller: UIViewController, title: String, alertText: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: alertText, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
        
    }
}
