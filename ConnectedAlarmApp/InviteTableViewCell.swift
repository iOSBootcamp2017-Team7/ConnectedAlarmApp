//
//  InviteTableViewCell.swift
//  ConnectedAlarmApp
//
//  Created by Singh, Uttam on 5/7/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit

class InviteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var inviteHeaderLabel: UILabel!
    @IBOutlet weak var invitedByUser: UILabel!
    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var alarmFrequency: UILabel!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
