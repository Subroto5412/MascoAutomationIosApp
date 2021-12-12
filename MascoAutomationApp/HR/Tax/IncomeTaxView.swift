//
//  IncomeTaxView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/11/21.
//

import UIKit

class IncomeTaxView: XibView {

    @IBOutlet weak var taxUnderBgView: UIView!
    @IBOutlet weak var taxBgView: UIView!
    
    
    var taxDetailsHandler : ((Bool?) -> Void)?
    
    @IBAction func taxDetailsBtn(_ sender: Any) {
        self.taxDetailsHandler?(true)
    }

}
