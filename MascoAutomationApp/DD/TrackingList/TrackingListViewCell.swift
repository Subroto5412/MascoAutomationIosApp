//
//  TrackingListViewCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 29/1/22.
//

import UIKit

class TrackingListViewCell: UITableViewCell {

    @IBOutlet weak var trackingViewCell: UIView!
    @IBOutlet weak var trackingNoLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.trackingViewCell.layer.borderColor = UIColor(red: 172/255, green: 227/255, blue: 255/255, alpha: 1.0).cgColor
        self.trackingViewCell.layer.borderWidth = 0.5
        self.trackingViewCell.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
