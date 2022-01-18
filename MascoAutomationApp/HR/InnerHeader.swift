//
//  InnerHeader.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 25/11/21.
//

import UIKit

class InnerHeader: XibView {
    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var commonSearchTxtField: UITextField!
    
    var backBtnHandler : ((Bool?) -> Void)?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func backBtn(_ sender: Any) {
        self.backBtnHandler?(true)
    }
}
