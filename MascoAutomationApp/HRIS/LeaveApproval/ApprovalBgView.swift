//
//  ApprovalBgView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 5/1/22.
//

import UIKit

class ApprovalBgView: XibView {
    @IBOutlet weak var approvedBtnView: UIButton!
    @IBOutlet weak var rejectBtnView: UIButton!
    
    var approvedBtnHandler : ((Bool?) -> Void)?
    var rejectedBtnHandler : ((Bool?) -> Void)?
    
    @IBAction func approvedBtn(_ sender: Any) {
        self.approvedBtnHandler?(true)
    }
    
    @IBAction func rejectBtn(_ sender: Any) {
        self.rejectedBtnHandler?(true)
    }
    
}
