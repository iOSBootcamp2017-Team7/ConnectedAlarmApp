//
//  SetupViewController.swift
//  ConnectedAlarmApp
//
//  Created by Bhagat, Puneet on 4/30/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse
import UserNotifications

protocol SetupViewControllerDelegate : class {
    func alarmSetupComplete(controller: SetupViewController)
}

class SetupViewController: UIViewController, InviteFriendsViewControllerDelegate {

    var invokingController: String!
    
    var delegate: SetupViewControllerDelegate!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var switchSunday: UISwitch!
    @IBOutlet weak var switchMonday: UISwitch!
    @IBOutlet weak var switchTuesday: UISwitch!
    @IBOutlet weak var switchWednesday: UISwitch!
    @IBOutlet weak var switchThursday: UISwitch!
    @IBOutlet weak var switchFriday: UISwitch!
    @IBOutlet weak var switchSaturday: UISwitch!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var duration: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //let date = Date()
        //let formatter = DateFormatter()
        //formatter.dateFormat = "MMM dd, yyyy"
        //startDate.text = formatter.string(from: date)
        
        // Update Save button text
        if invokingController == "ActivityViewController" {
            saveButton.title = "Save"
        } else if invokingController == "ChallengeViewController" {
            saveButton.title = "Next"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onSaveClick(_ sender: UIBarButtonItem) {
        //dismiss(animated: true, completion: nil)
        if invokingController == "ActivityViewController" {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func friendsInviteComplete(controller: InviteFriendsViewController) {
        dismiss(animated: true) {
            if self.delegate != nil {
                self.delegate.alarmSetupComplete(controller: self)
            }
        }
    }
    
//    // Should Perform Segue
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if invokingController == "ActivityViewController" {
//            return false
//        }
//        return true
//    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destination as! InviteFriendsViewController
        destinationViewController.delegate = self
        
        let days = Days()
        //var alarmTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let alarm = Alarm()
        alarm.adminUser = PFUser.current()
        alarm.status = "NEW"
        alarm.alarmTime = AlarmTime()
        alarm.alarmTime.daysOfWeek = Array<Days>()
        if switchSunday.isOn == true {
            days.day = Days.WeekDay.Sunday
            alarm.alarmTime.daysOfWeek?.append(days)
        }
        if switchMonday.isOn == true {
            days.day = Days.WeekDay.Monday
            alarm.alarmTime.daysOfWeek?.append(days)
        }
        if switchTuesday.isOn == true {
            days.day = Days.WeekDay.Tuesday
            alarm.alarmTime.daysOfWeek?.append(days)
        }
        if switchWednesday.isOn == true {
            days.day = Days.WeekDay.Wednesday
            alarm.alarmTime.daysOfWeek?.append(days)
        }
        if switchThursday.isOn == true {
            days.day = Days.WeekDay.Thursday
            alarm.alarmTime.daysOfWeek?.append(days)
        }
        if switchFriday.isOn == true {
            days.day = Days.WeekDay.Friday
            alarm.alarmTime.daysOfWeek?.append(days)
        }
        if switchSaturday.isOn == true {
            days.day = Days.WeekDay.Saturday
            alarm.alarmTime.daysOfWeek?.append(days)
        }
        alarm.alarmTime.alarmTime = timePicker.date
        formatter.dateFormat = "MMM dd, yyyy"
        alarm.startDate = startDatePicker.date
        alarm.endDate = alarm.startDate.addingTimeInterval(604800)
        alarm.duration = duration.text
        
        destinationViewController.alarm = alarm
        
//        // create a corresponding local notification
//        let content = UNMutableNotificationContent()
//        content.title = "Hello..."
//        content.body = "Time to wake up"
//        content.sound = UNNotificationSound.init(named: "alarm.mp3") //UNNotificationSound.default()
//        //content.categoryIdentifier = "UYLReminderCategory"
//        
//        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second], from: timePicker.date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
//        
//        let reqIdentifier = "UYLLocalNotification"
//        let center = UNUserNotificationCenter.current()
//        let request = UNNotificationRequest(identifier: reqIdentifier, content: content, trigger: trigger)
//        
//        center.add(request, withCompletionHandler: { (error) in
//            if let error = error {
//                print(error)
//            }
//        })
        
//        let snoozeIdentifier = "Snooze"
//        let snoozeAction = UNNotificationAction(identifier: snoozeIdentifier,
//                                                title: "Snooze", options: [])
//        
//        let deleteIdentifier = "UYLDeleteAction"
//        let deleteAction = UNNotificationAction(identifier: deleteIdentifier,
//                                                title: "Delete", options: [.destructive])
//        
//        let ctgIdentifier = "UYLReminderCategory"
//        let category = UNNotificationCategory(identifier: ctgIdentifier,
//                                              actions: [snoozeAction,deleteAction],
//                                              intentIdentifiers: [], options: [])
//        center.setNotificationCategories([category])
        
    }
}
