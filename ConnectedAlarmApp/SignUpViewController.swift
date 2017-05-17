//
//  SignUpViewController.swift
//  ConnectedAlarmApp
//
//  Created by Weijie Chen on 5/16/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelSignUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func signUpUser(_ sender: UIButton) {
        //Initialize a user object
        let newUser = PFUser()
        
        //set your properties
        newUser.username = phoneNumber.text
        newUser.email = email.text
        newUser.password = password.text
        
        //call sign up function on the bucket
        newUser.signUpInBackground { (success, error) in
            if let error = error as NSError?{
                print(error.localizedDescription)
            }else{
                print("Self user registered succesfully!")
                self.dismiss(animated: true, completion: nil)
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
