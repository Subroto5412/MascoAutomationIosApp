//
//  DailyAttendanceTableViewCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 7/12/21.
//

import UIKit

class DailyAttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var punchInLbl: UILabel!
    @IBOutlet weak var punchOutLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var otLbl: UILabel!
    @IBOutlet weak var dateBgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
