//
//  InviteViewController.swift
//  ConnectedAlarmApp
//
//  Created by Bhagat, Puneet on 4/30/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class InviteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var inviteTableView: UITableView!
    @IBOutlet weak var inviteSegmentControl: UISegmentedControl!

    var alarmData: [Alarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inviteTableView.delegate =  self
        inviteTableView.dataSource = self

        
        // Load the table view with invited alarms
        AlarmService.Instance.fetchParticipantAlarms(alarmType: AlarmStatusType.INVITED, sucess: { (alarms: [Alarm]) in
            self.reloadTableView(alarms: alarms)
        }, failure: { (error: Error) in
            AlertService.Instance.alertWithNoAction(fromController: self, title: "Alarm Details", alertText: "Could not load data")
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InviteTableViewCell", for: indexPath) as! InviteTableViewCell
        cell.alarmTime.text = String(describing: self.alarmData[indexPath.row].alarmTime.alarmHourMinuteStr!)
        cell.invitedByUser.text = String(describing: self.alarmData[indexPath.row].adminUser!.username!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func alarmCategoryChangedAction(_ sender: UISegmentedControl) {
        reloadTableByCategory(index: sender.selectedSegmentIndex)
    }
    
    func reloadTableByCategory(index: Int) {
        switch index {
        case 0:
            AlarmService.Instance.fetchParticipantAlarms(alarmType: AlarmStatusType.INVITED, sucess: { (alarms: [Alarm]) in
                self.reloadTableView(alarms: alarms)
            }, failure: { (error: Error) in
                AlertService.Instance.alertWithNoAction(fromController: self, title: "Alarm Details", alertText: "Could not load data")
            })
        case 1:
            AlarmService.Instance.fetchParticipantAlarms(alarmType: AlarmStatusType.ACCEPETED, sucess: { (alarms: [Alarm]) in
                self.reloadTableView(alarms: alarms)
            }, failure: { (error: Error) in
                AlertService.Instance.alertWithNoAction(fromController: self, title: "Alarm Details", alertText: "Could not load data")
            })
        case 2:
            AlarmService.Instance.fetchParticipantAlarms(alarmType: AlarmStatusType.REJECTED, sucess: { (alarms: [Alarm]) in
                self.reloadTableView(alarms: alarms)
            }, failure: { (error: Error) in
                AlertService.Instance.alertWithNoAction(fromController: self, title: "Alarm Details", alertText: "Could not load data")
            })
        default:
            AlertService.Instance.alertWithNoAction(fromController: self, title: "Alarm Details", alertText: "Could not load data")
        }
        
    }
    
    func reloadTableView(alarms: [Alarm]) {
        self.alarmData.removeAll()
        self.alarmData = alarms
        self.inviteTableView.reloadData()
    }
    
    
    func alertWithNoAction(title: String, alertText: String) {
        let alert = UIAlertController(title: title, message: alertText, preferredStyle: UIAlertControllerStyle.actionSheet)
        let dismiss = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(dismiss)
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadTableByCategory(index: inviteSegmentControl.selectedSegmentIndex)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InviteDetailViewControllerSegue" {
            let cell = sender! as! UITableViewCell
            let indexPath = inviteTableView.indexPath(for: cell)

            if let alarm:Alarm = self.alarmData[(indexPath?.row)!] {
                let inviteViewController = segue.destination as! InviteDetailViewController
                inviteViewController.alarm = alarm

            }
        }
    }

}
