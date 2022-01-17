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
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dateBgView.layer.borderColor =  UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.dateBgView.layer.borderWidth = 0.05
        self.dateBgView.layer.cornerRadius = 30
        
        self.cellBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.cellBgView.layer.borderWidth = 0.5
        self.cellBgView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
