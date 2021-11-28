//
//  HrBodyView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 25/11/21.
//

import UIKit

class HrBodyView: XibView {

    @IBOutlet weak var attendanceUnderBgView: UIView!
    @IBOutlet weak var attendanceBgView: UIView!
    
    @IBOutlet weak var leaveUnderBgView: UIView!
    @IBOutlet weak var leaveBgView: UIView!
    
    @IBOutlet weak var taxUnderBgView: UIView!
    @IBOutlet weak var taxBgView: UIView!
    
    var attendanceHandler : ((Bool?) -> Void)?
    var leaveHandler : ((Bool?) -> Void)?
    var incomeTaxHandler : ((Bool?) -> Void)?
  
    @IBAction func attendanceBtn(_ sender: UIButton) {
        self.attendanceHandler?(true)
    }
    
    @IBAction func leaveBtn(_ sender: UIButton) {
        self.leaveHandler?(true)
    }
    
    @IBAction func incomeTaxBtn(_ sender: UIButton) {
        self.incomeTaxHandler?(true)
    }
}
