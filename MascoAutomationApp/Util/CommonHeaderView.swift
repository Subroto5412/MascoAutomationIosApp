//
//  CommonHeader.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/11/21.
//

import UIKit

class CommonHeaderView: XibView {

    @IBOutlet weak var titleNameLbl: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var backBtnHandler : ((Bool?) -> Void)?
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.backBtnHandler?(true)
    }
}
