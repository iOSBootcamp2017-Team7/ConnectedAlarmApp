//
//  ViewController.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 4/25/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        perform(#selector(SplashViewController.loadMainView), with: nil, afterDelay: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadMainView() {
        performSegue(withIdentifier: "MainView", sender: self)
    }
}

