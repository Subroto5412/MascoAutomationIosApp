//
//  BWPDTitleViewControllerCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 18/12/21.
//

import UIKit

class BWPDTitleViewControllerCell: UITableViewCell {

    @IBOutlet weak var slLbl: UILabel!
    @IBOutlet weak var buyerLbl: UILabel!
    @IBOutlet weak var styleLbl: UILabel!
    @IBOutlet weak var orderLbl: UILabel!
    @IBOutlet weak var orderQtsLbl: UILabel!
    @IBOutlet weak var sewQtsLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
