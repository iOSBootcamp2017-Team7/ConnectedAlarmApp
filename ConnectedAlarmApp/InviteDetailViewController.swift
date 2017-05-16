//
//  InviteDetailViewController.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/7/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit

class InviteDetailViewController: UIViewController {

    var alarm: Alarm!
    
    @IBOutlet weak var invitedBy: UILabel!
    @IBOutlet weak var alarmtime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alarmtime.text = alarm.alarmTime.alarmHourMinuteStr
        self.invitedBy.text = alarm.adminUser.username
        
    }
   
    @IBAction func acceptAlaramChallenge(_ sender: UIButton) {
        AlarmService.Instance.updateParticipantAlarmStatus(alarm: alarm, status: AlarmStatusType.ACCEPETED, sucess: { (success: Bool) in
            log.info("Updationg alaram status for alarm id = \(String(describing: self.alarm.objectId))" )
            self.loadinviteView(message: "You have accepted this alarm challenge")
        }) { (error: Error) in
            log.error("Error while updating alarm status = \(AlarmStatusType.ACCEPETED.rawValue)")
        }
        
    }
    
    @IBAction func rejectAlaramChallenge(_ sender: UIButton) {
        AlarmService.Instance.updateParticipantAlarmStatus(alarm: alarm, status: AlarmStatusType.REJECTED, sucess: { (success: Bool) in
            log.info("Updationg alaram status for alarm id = \(String(describing: self.alarm.objectId))" )
            self.loadinviteView(message: "You have rejected this alarm challenge")
        }) { (error: Error) in
            log.error("Error while updating alarm status = \(AlarmStatusType.ACCEPETED.rawValue)")
        }
    }
    
    @IBAction func viewParticipants(_ sender: UIButton) {
        
    }
    
    func loadinviteView(message: String) {
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "InviteViewController") as! InviteViewController
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
        AlertService.Instance.alertWithAction(fromController: self, title: "Alert", alertText: message, action: okAction)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewParticipantsSegue" {
            let destination = segue.destination as! UINavigationController
            let participantsVC = destination.visibleViewController as! ParticipantsTableViewController
            participantsVC.participants = self.alarm.participants
        }
    }
}
