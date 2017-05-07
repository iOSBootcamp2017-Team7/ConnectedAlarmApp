//
//  ContactsTableCell.swift
//  ConnectedAlarmApp
//
//  Created by Weijie Chen on 5/3/17.
//  Copyright © 2017 connected alarm app. All rights reserved.
//

import UIKit

@objc protocol InviteButtonDelegate{
    @objc optional func onClickInviteButton(contactCell: ContactsTableCell)
}


class ContactsTableCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var phoneNumber : String!

    weak var delegate : InviteButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onClickInviteButton(_ sender: UIButton) {
        if let delegate = self.delegate{
            delegate.onClickInviteButton?(contactCell: self)
        }else{
        }
    }

}
