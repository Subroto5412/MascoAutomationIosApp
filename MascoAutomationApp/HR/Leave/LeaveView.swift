//
//  LeaveView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/11/21.
//

import UIKit

class LeaveView: XibView {

    @IBOutlet weak var leaveDetailsUnderBgView: UIView!
    @IBOutlet weak var leaveDetailsBgView: UIView!
    
    @IBOutlet weak var leaveApplyUnderBgView: UIView!
    @IBOutlet weak var leaveApplyBgView: UIView!
    
    var leaveDetailsHandler : ((Bool?) -> Void)?
    var leaveApplyHandler : ((Bool?) -> Void)?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func LeaveDetailsBtn(_ sender: UIButton) {
        self.leaveDetailsHandler?(true)
    }
    
    @IBAction func LeaveApplyBtn(_ sender: UIButton) {
        self.leaveApplyHandler?(true)
    }
}
