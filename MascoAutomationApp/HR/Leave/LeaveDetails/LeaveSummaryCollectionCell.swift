//
//  LeaveSummaryCollectionCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 11/12/21.
//

import UIKit

class LeaveSummaryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var clLbl: UILabel!
    @IBOutlet weak var slLbl: UILabel!
    @IBOutlet weak var elLbl: UILabel!
    @IBOutlet weak var leaveSummaryBgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.leaveSummaryBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.leaveSummaryBgView.layer.borderWidth = 0.5
        self.leaveSummaryBgView.layer.cornerRadius = 15
    }

}
