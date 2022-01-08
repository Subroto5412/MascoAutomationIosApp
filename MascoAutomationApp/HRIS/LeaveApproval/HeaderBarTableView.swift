//
//  HeaderBarTableView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 5/1/22.
//

import UIKit

class HeaderBarTableView: XibView {

    @IBOutlet weak var allCheckingBtn: UIButton!
    
    var allCheckingBtnHandler : ((Bool?) -> Void)?
    
    @IBAction func AllCheckingBtn(_ sender: Any) {
        self.allCheckingBtnHandler?(true)
    }
    
}
