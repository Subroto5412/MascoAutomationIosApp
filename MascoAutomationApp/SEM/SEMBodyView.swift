//
//  SEMBodyView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 19/12/21.
//

import UIKit

class SEMBodyView: XibView {

    @IBOutlet weak var communicationPortalUnderBgView: UIView!
    @IBOutlet weak var communicationPortalBgView: UIView!
    
    var CPHandler : ((Bool?) -> Void)?

    @IBAction func CPBtn(_ sender: Any) {
        self.CPHandler?(true)
    }
}
