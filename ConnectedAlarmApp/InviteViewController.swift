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
    
    var alarms: [Alarm]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inviteTableView.delegate =  self
        inviteTableView.dataSource = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InviteDetailViewControllerSegue" {
            let cell = sender! as! UITableViewCell
            let indexPath = inviteTableView.indexPath(for: cell)
            
            if alarms != nil {
                let alarm = self.alarms![(indexPath?.row)!]
                let inviteViewController = segue.destination as! InviteDetailViewController
                inviteViewController.alarm = alarm
            } else {
                print("No alarm")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InviteTableViewCell", for: indexPath) as! InviteTableViewCell
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // Disable grey selection effect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
