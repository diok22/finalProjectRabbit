//
//  TableViewCell.swift
//  finalProjectMA
//
//  Created by Edward Powderham on 14/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit

class UpcomingEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitleInCell: UILabel!
    @IBOutlet weak var eventTimeInCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
