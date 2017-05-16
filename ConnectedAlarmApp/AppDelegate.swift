//
//  AppDelegate.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 4/25/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import CoreData
import Parse
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationDelegate = UYLNotificationDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK: - Parse server configuration
        // START - Parse Server Setup with APP_ID, MASTER_KEY and SERVER RUL
        
        let parseConfiguration = ParseClientConfiguration(block: { (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = AppConstants.PARSE_APP_ID
            ParseMutableClientConfiguration.clientKey = AppConstants.PARSE_MASTER_KEY
            ParseMutableClientConfiguration.server = AppConstants.PARSE_SERVER_URL
        })
        
        Parse.initialize(with: parseConfiguration)
        // END - Parse Server Setup with APP_ID, MASTER_KEY and SERVER RUL
        
        
        // MARK: - Handle user session 
        // START - Check Parse current user
        
        PFUser.logInWithUsername(inBackground: "7259516892", password: "7259516892", block: { (user: PFUser?, error: Error?) in
            let currentUser = PFUser.current()
            if currentUser != nil {
                print("user logged in")
                print(currentUser?.username!)
            } else {
                let user = PFUser()
                user.username = "7259516892"
                user.password = "7259516892"
                user.signUpInBackground(block: { (success: Bool, error: Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("User Registered successfully")
                        // manually segue to logged in view
                    }
                })
            }
        })
        
        
        // MARK: - Handle UINavigation background Color
        // STRAT - UINavigation Color
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 252/255.0, green: 72/255.0, blue: 49/255.0, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barStyle = .black

        // Register for notifications
        let center = UNUserNotificationCenter.current()
        center.delegate = notificationDelegate
        
        let options: UNAuthorizationOptions = [.alert, .sound];
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        
        //application.registerUserNotificationSettings(UIUserNotificationSettings(types: .sound, categories: nil))
        
        // END - UINavigation Color
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ConnectedAlarmApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

