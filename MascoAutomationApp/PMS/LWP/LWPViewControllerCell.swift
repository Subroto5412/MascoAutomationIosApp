//
//  LWPViewControllerCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 18/12/21.
//

import UIKit

class LWPViewControllerCell: UITableViewCell {

    @IBOutlet weak var slLbl: UILabel!
    @IBOutlet weak var lineNoLbl: UILabel!
    @IBOutlet weak var outputLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
