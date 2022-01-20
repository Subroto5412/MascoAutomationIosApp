//
//  ATMBodyView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 19/12/21.
//

import UIKit

class ATMBodyView: XibView {

    @IBOutlet weak var assetBasicUnderBgView: UIView!
    @IBOutlet weak var assetBasicBgView: UIView!
    
    var ATMHandler : ((Bool?) -> Void)?

    @IBAction func ATMBtn(_ sender: Any) {
        self.ATMHandler?(true)
    }
}
