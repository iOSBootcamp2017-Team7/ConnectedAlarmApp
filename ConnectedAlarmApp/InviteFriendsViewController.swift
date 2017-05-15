//
//  InviteFriendsViewController.swift
//  ConnectedAlarmApp
//
//  Created by Weijie Chen on 5/2/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import SwiftAddressBook
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
    
    var dummyusers  = ["5555648583","8885555512","5555228243"]
    
    var alarm: Alarm!
    
    var users : [PFObject] = []
    var usersPhoneNumbers : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        DBManager.sharedInstance.fetchAllUsers(sucess: { (_users : [PFObject]) in
            self.users = _users
            
            for user in _users{
                self.usersPhoneNumbers.append(user["username"] as! String)
            }
            self.setContactSection()
            self.tableView.reloadData()
            
        }) { (error :Error) in
            print(error.localizedDescription)
        }
        
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
                        
                        self.addState[phonenumber] = false
                        self.contacts.append(contact)
                    }
                    self.setContactSection()
                    print("\(self.usersPhoneNumbers.map({$0.digits}))")
                    self.tableView.reloadData()
                    
                }
            }else {
                print("\(self.usersPhoneNumbers.map({$0.digits}))")
                //no success. Optionally evaluate error
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setContactSection(){
        for contact in self.contacts{
            if self.usersPhoneNumbers.contains(contact.PhoneNumber!){
                self.appUsers.append(contact)
            }else {
                self.nonappUsers.append(contact)
            }

        }
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
        for contact in self.appUsers{
            if self.appUsersState.keys.contains(contact.PhoneNumber!) && self.appUsersState[contact.PhoneNumber ?? ""] == true{
                let participant = Participant()
                participant.user?.username = contact.PhoneNumber
                
                self.alarm.participants.append(participant)
            }
        }
        
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
