//
//  HRISBodyView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/12/21.
//

import UIKit

class HRISBodyView: XibView {

    @IBOutlet weak var HRISUnderBgView: UIView!
    @IBOutlet weak var HRISBgView: UIView!
    
    var HRISHandler : ((Bool?) -> Void)?
    
    @IBAction func HRISBtn(_ sender: Any) {
        self.HRISHandler?(true)
    }
}
