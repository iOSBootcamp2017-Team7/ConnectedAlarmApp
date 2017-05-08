//
//  SetupViewController.swift
//  ConnectedAlarmApp
//
//  Created by Bhagat, Puneet on 4/30/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

protocol SetupViewControllerDelegate : class {
    func alarmSetupComplete(controller: SetupViewController)
}

class SetupViewController: UIViewController, InviteFriendsViewControllerDelegate {

    var delegate: SetupViewControllerDelegate!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var switchSunday: UISwitch!
    @IBOutlet weak var switchMonday: UISwitch!
    @IBOutlet weak var switchTuesday: UISwitch!
    @IBOutlet weak var switchWednesday: UISwitch!
    @IBOutlet weak var switchThursday: UISwitch!
    @IBOutlet weak var switchFriday: UISwitch!
    @IBOutlet weak var switchSaturday: UISwitch!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var duration: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        startDate.text = formatter.string(from: date)
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
    }
    
    func friendsInviteComplete(controller: InviteFriendsViewController) {
        dismiss(animated: true) { 
            if self.delegate != nil {
                self.delegate.alarmSetupComplete(controller: self)
            }
        }
    }
    
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
        alarm.startDate = formatter.date(from: startDate.text!)
        alarm.endDate = alarm.startDate
        alarm.duration = duration.text
        
        destinationViewController.alarm = alarm
    }
 

}
