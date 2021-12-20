//
//  LeaveApprovalBodyView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/12/21.
//

import UIKit

class LeaveApprovalBodyView: XibView {

    @IBOutlet weak var leaveApprovalUnderBgView: UIView!
    @IBOutlet weak var leaveApprovalBgView: UIView!

    var leaveApprovalHandler : ((Bool?) -> Void)?
    
    @IBAction func leaveApprovalBtn(_ sender: Any) {
        self.leaveApprovalHandler?(true)
    }
    
}
