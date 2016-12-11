//
//  InviteeMapViewTableViewCell.swift
//  finalProjectMA
//
//  Created by Laszlo Bogacsi on 11/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit

class InviteeMapViewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var etaMins: UILabel!
    
    @IBOutlet weak var confirmedLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
