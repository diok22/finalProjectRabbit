//
//  InviteeTableViewCell.swift
//  finalProjectMA
//
//  Created by Laszlo Bogacsi on 10/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit

class InviteeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var inviteeName: UILabel!
    @IBOutlet weak var inviteeEmail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
