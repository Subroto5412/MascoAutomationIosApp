//
//  HPDsViewControllerCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 19/12/21.
//

import UIKit

class HPDsViewControllerCell: UITableViewCell {

    @IBOutlet weak var slLbl: UILabel!
    @IBOutlet weak var hourLbl: UILabel!
    @IBOutlet weak var cuttingLbl: UILabel!
    @IBOutlet weak var lineInputLbl: UILabel!
    @IBOutlet weak var sewingOutputLbl: UILabel!
    @IBOutlet weak var ironLbl: UILabel!
    @IBOutlet weak var foldingLbl: UILabel!
    @IBOutlet weak var polyLbl: UILabel!
    @IBOutlet weak var cartonLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
