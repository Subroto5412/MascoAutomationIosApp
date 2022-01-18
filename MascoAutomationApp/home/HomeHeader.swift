//
//  HomeHeader.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 24/11/21.
//

import UIKit

class HomeHeader: XibView {

    @IBOutlet weak var sideMenuView: UIButton!
    @IBOutlet weak var homeHeaderBg: UIView!
    @IBOutlet weak var commonSearchTxtField: UITextField!
    
    var menuHandler : ((Bool?) -> Void)?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func menuBtn(_ sender: Any) {
        
        self.menuHandler?(true)
        
    }
}
