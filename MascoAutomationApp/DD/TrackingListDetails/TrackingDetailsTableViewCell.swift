//
//  TrackingDetailsTableViewCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 29/1/22.
//

import UIKit

class TrackingDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var slLbl: UILabel!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var  buyerLbl: UILabel!
    @IBOutlet weak var  uomLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
