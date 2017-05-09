//
//  ChallengeViewController.swift
//  ConnectedAlarmApp
//
//  Created by Bhagat, Puneet on 4/30/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, SetupViewControllerDelegate {

    @IBOutlet weak var setupChallengeLabel: UILabel!
    @IBOutlet weak var addChallenge: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSetupClick(_ sender: UIButton) {
        
    }
    
    func alarmSetupComplete(controller: SetupViewController) {
        dismiss(animated: true) {
            
            self.setupChallengeLabel.text = "Alarm created!"
            self.addChallenge.isHidden = true
            
            //self.navigationController?.popToViewController(self, animated: true)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SetupAlarm" {
            let destinationViewController = segue.destination as! SetupViewController
            destinationViewController.delegate = self
        }
        else if segue.identifier == "ViewInvites" {
            
        }
    }

}
