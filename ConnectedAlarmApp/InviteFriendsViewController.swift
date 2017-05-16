//
//  InviteFriendsViewController.swift
//  ConnectedAlarmApp
//
//  Created by Weijie Chen on 5/2/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import SwiftAddressBook
import UserNotifications
import Parse

protocol InviteFriendsViewControllerDelegate : class {
    func friendsInviteComplete(controller: InviteFriendsViewController)
}

class InviteFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, InviteButtonDelegate {

    var delegate: InviteFriendsViewControllerDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    
    var contacts : [Contact] = []
    var appUsers : [Contact] = []           //Contacts who are App users
    var nonappUsers : [Contact] = []        //Contacts who are not App users
    var appUsersState : [String : Bool] = [:]       //Phonenumber collection of appusers who are invited     to challenge
    var nonAppUsersState : [String : Bool] = [:]    //Phonenumber collection of nonappusers who are invited to join Download app
    var addState : [String : Bool] = [:]
    
    //var dummyusers  = ["5555648583","8885555512","5555228243"]
    
    var dummyusers = [String]()
    
    var alarm: Alarm!
    var inviteList = [Participant]()
    let dbMngr = DBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        SwiftAddressBook.requestAccessWithCompletion { (success, error) -> Void in
            if success{
                //do something with swiftaddressbook
                if let people = swiftAddressBook?.allPeople{
                    for person in people{
                        //print("\(person.phoneNumbers?.map({$0.value}) ?? [""])")
                        
                        let contact = Contact()
                        let phonenumber = (person.phoneNumbers?.map({$0.value})[0] ?? "").digits
                        contact.Name = "\(person.firstName ?? "") \(person.lastName ?? "")"
                        contact.PhoneNumber = phonenumber
                        
                        if self.dummyusers.contains(phonenumber){
                            self.appUsers.append(contact)
                        }else {
                            self.nonappUsers.append(contact)
                        }
                        self.addState[phonenumber] = false
                        self.contacts.append(contact)
                    }
                    print("\(self.dummyusers.map({$0.digits}))")
                    self.tableView.reloadData()
                    
                }
            }else {
                print("\(self.dummyusers.map({$0.digits}))")
                //no success. Optionally evaluate error
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        //dismiss(animated: true, completion: nil)
        
        alarm.participants = inviteList
        
        // Save Alarm setting
        dbMngr.saveEntity(entity: alarm, sucess: { (result) in
            print("ALARM SAVED")
            print(result)
            
            if result == true
            {
                var participant: Participant!
                for invitee in self.inviteList {
                    
                    participant = invitee
                    if participant != nil {
                        let participantAlarm = ParticipantAlarm()
                        participantAlarm.alarm = self.alarm
                        participantAlarm.user = participant.user
                        participantAlarm.status = "Pending"
                        
                        self.dbMngr.saveEntity(entity: participantAlarm, sucess: { (result) in
                            print("Participant Alarm SAVED")
                            print(result)
                        }, failure: { (error) in
                            print("Participant Alarm SAVE FAILED")
                        })
                    }
                }
            }
        }) { (error) in
            print("Participant Alarm SAVE FAILED")
        }
        
        // create a corresponding local notification
        let content = UNMutableNotificationContent()
        content.title = "Hello..."
        content.body = "Time to wake up"
        content.sound = UNNotificationSound.init(named: "alarm.mp3") //UNNotificationSound.default()
        //content.categoryIdentifier = "UYLReminderCategory"
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second], from: alarm.alarmTime.alarmTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let reqIdentifier = "UYLLocalNotification"
        let center = UNUserNotificationCenter.current()
        let request = UNNotificationRequest(identifier: reqIdentifier, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
        })
        
        if delegate != nil {
            delegate.friendsInviteComplete(controller: self)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ContactsTable.contactsSections().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.appUsers.count
        default:
            return self.nonappUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContactsTable.contactsSections()[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 10.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableCell", for: indexPath) as! ContactsTableCell
        
        var contact = Contact()
        switch indexPath.section {
        case 0:
            contact = appUsers[indexPath.row]
        default:
            contact = nonappUsers[indexPath.row]
        }
        //let contact = contacts[indexPath.row]
        cell.name.text = contact.Name
        cell.phoneNumber = contact.PhoneNumber
        cell.username.text = contact.PhoneNumber
        
        if cell.delegate == nil {
            cell.delegate = self
        }
        
        return cell
    }
    
    
    func onClickInviteButton(contactCell: ContactsTableCell) {
        let indexPath = tableView.indexPath(for: contactCell)
        if indexPath?.section == 0 {
            if appUsersState[contactCell.phoneNumber] == nil || !appUsersState[contactCell.phoneNumber]! {
                contactCell.addButton.setImage(#imageLiteral(resourceName: "Ok-48"), for: .normal)
                appUsersState[contactCell.phoneNumber] = true
            }else{
                contactCell.addButton.setImage(#imageLiteral(resourceName: "Plus-50"), for: .normal)
                appUsersState[contactCell.phoneNumber] = false
            }
        }else {
            if nonAppUsersState[contactCell.phoneNumber] == nil || !nonAppUsersState[contactCell.phoneNumber]! {
                contactCell.addButton.setImage(#imageLiteral(resourceName: "Ok-48"), for: .normal)
                nonAppUsersState[contactCell.phoneNumber] = true
            }else{
                contactCell.addButton.setImage(#imageLiteral(resourceName: "Plus-50"), for: .normal)
                nonAppUsersState[contactCell.phoneNumber] = false
            }
        }
        
        let cell = contactCell
        if cell.checked == true {
            //let invitee = PFUser()
            //invitee.username = cell.phoneNumber
            //invitee.password = cell.phoneNumber
            
            let query = PFUser.query()
            query?.whereKey("username", equalTo: cell.phoneNumber)
            query?.getFirstObjectInBackground(block: { (user: PFObject?, error: Error?) in
                
                if user != nil {
                    let partipantUser = Participant()
                    partipantUser.score = "0"
                    partipantUser.status = "Pending"
                    partipantUser.user = user as! PFUser
                    
                    self.inviteList.append(partipantUser)
                }
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
