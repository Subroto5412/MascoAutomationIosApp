//
//  DailyAttendance.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/11/21.
//

import UIKit

class DailyAttendanceView: XibView {

    @IBOutlet weak var dailyAttendanceUnderBgView: UIView!
    @IBOutlet weak var dailyAttendanceBgView: UIView!
    var dailyAttendanceHandler : ((Bool?) -> Void)?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func dailyAttendanceBtn(_ sender: UIButton) {
//        self.dailyAttendanceBtn?(true)
        self.dailyAttendanceHandler?(true)
    }
    
}
