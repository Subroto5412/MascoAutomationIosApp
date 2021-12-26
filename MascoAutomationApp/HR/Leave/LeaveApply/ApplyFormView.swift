//
//  ApplyFormView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 13/12/21.
//

import UIKit

class ApplyFormView: XibView {
    @IBOutlet weak var IdBgView: UITextField!
    @IBOutlet weak var nameBgView: UITextField!
    @IBOutlet weak var designationBgView: UITextField!
    @IBOutlet weak var leaveTypeBgView: UIView!
    @IBOutlet weak var leaveNoBgView: UIView!
    @IBOutlet weak var leaveRequiredBgView: UIView!
    @IBOutlet weak var leaveRequiredToBgView: UIView!
    @IBOutlet weak var totalDaysBgView: UIView!
    @IBOutlet weak var reasonBgView: UITextField!
    @IBOutlet weak var saveBgView: UIView!
    
    @IBOutlet weak var applyFromDate: UILabel!
    @IBOutlet weak var ApplyToDate: UILabel!
    
    var applyFromHandler : ((Bool?) -> Void)?
    var applyToHandler : ((Bool?) -> Void)?
    
    @IBAction func applyFromBtn(_ sender: Any) {
        self.applyFromHandler?(true)
    }
    
    @IBAction func applyToBtn(_ sender: Any) {
        self.applyToHandler?(true)
    }
    
}
