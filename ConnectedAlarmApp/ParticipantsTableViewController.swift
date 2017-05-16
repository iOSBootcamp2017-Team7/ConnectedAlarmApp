//
//  ParticipantsTableViewController.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/7/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class ParticipantsTableViewController: UITableViewController {

    @IBOutlet var participantsTableView: UITableView!
    
    var participants: [Participant]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Participants", for: indexPath)

        // Remove logged in user from participants list
        if participants[indexPath.row].user?.username == PFUser.current()?.username {
            cell.textLabel?.text = "You"
        } else {
            cell.textLabel?.text = participants[indexPath.row].user?.username
        }
        cell.detailTextLabel?.text = participants[indexPath.row].user?["name"] as? String

        return cell
    }
    
    @IBAction func doenActionTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
