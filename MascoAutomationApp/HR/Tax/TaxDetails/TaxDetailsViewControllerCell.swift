//
//  TaxDetailsViewControllerCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 12/12/21.
//

import UIKit

class TaxDetailsViewControllerCell: UITableViewCell {
    
    @IBOutlet weak var slLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var deductionAmountLbl: UILabel!
    
    @IBOutlet weak var deductionAmoutBgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
