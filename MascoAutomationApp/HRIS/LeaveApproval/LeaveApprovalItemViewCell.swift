//
//  LeaveApprovalItemViewCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 5/1/22.
//

import UIKit

class LeaveApprovalItemViewCell: UITableViewCell {

    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    
    @IBOutlet weak var leaveLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var totalDaysLbl: UILabel!
    
    @IBOutlet weak var checkingBtn: UIButton!
    var checkBtnPressed : (() -> ()) = {}
    var dateUpdateBtnPressed : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var leaveApprovalHandler : ((Bool?) -> Void)?
    
    @IBAction func checkBtn(_ sender: Any) {
        checkBtnPressed()
    }
    @IBAction func dateUpdateBtn(_ sender: Any) {
        dateUpdateBtnPressed()
    }
    
}
