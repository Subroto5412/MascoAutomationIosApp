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
    
    @IBOutlet weak var totalApplyDayLbl: UILabel!
    @IBOutlet weak var fullLeaveTypeBgView: UIView!
    @IBOutlet weak var applyFromDate: UILabel!
    @IBOutlet weak var ApplyToDate: UILabel!
    
    @IBOutlet weak var profilePhotoImg: UIImageView!
    @IBOutlet weak var leaveTypeValueLbl: UILabel!
    @IBOutlet weak var leaveTypeBtn: UIButton!
    var applyFromHandler : ((Bool?) -> Void)?
    var applyToHandler : ((Bool?) -> Void)?
    var leaveTypeHandler : ((Bool?) -> Void)?
    var saveHandler : ((Bool?) -> Void)?
    
    @IBAction func applyFromBtn(_ sender: Any) {
        self.applyFromHandler?(true)
    }
    
    @IBAction func applyToBtn(_ sender: Any) {
        self.applyToHandler?(true)
    }
    
    @IBAction func leaveTypeSelectBtn(_ sender: Any) {
        self.leaveTypeHandler?(true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        self.saveHandler?(true)
    }
}
