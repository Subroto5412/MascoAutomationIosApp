//
//  LeaveDetailsTableViewCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/12/21.
//

import UIKit

class LeaveDetailsTableViewCell: UITableViewCell {


    @IBOutlet weak var slLbl: UILabel!
    @IBOutlet weak var leaveTypeLbl: UILabel!
    @IBOutlet weak var avilDayLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var applicationDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

