//
//  LogUtil.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/13/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//


import SwiftyBeaver

class LogUtil {
    
    // Creating singleton instance
    private static let _instance = LogUtil ()
    static var Instance = {
        return _instance
    }()
    
    func setupLog() {
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console
//        let file = FileDestination() // log to default swiftybeaver.log file
        
        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss$d $L $M"
        // or use this for JSON output: console.format = "$J"
        
        // add the destinations to SwiftyBeaver
        log.addDestination(console)
//        log.addDestination(file)
    }
}
