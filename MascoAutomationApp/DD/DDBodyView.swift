//
//  DDBodyView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 29/1/22.
//

import UIKit

class DDBodyView: XibView {

    @IBOutlet weak var trackingBgViewUnder: UIView!
    @IBOutlet weak var trackingBgView: UIView!
    
    var trackingListHandler : ((Bool?) -> Void)?
    
    @IBAction func trackingListBtn(_ sender: Any) {
        self.trackingListHandler?(true)
    }
}
