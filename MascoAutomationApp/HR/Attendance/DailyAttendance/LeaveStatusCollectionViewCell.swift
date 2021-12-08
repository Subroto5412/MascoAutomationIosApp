//
//  LeaveStatusCollectionViewCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 8/12/21.
//

import UIKit

class LeaveStatusCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var statusNameLbl: UILabel!
    @IBOutlet weak var starusValueLbl: UILabel!
    @IBOutlet weak var statusBgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.statusBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.statusBgView.layer.borderWidth = 0.5
        self.statusBgView.layer.cornerRadius = 15
    }
}
