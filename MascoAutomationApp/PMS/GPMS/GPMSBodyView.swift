//
//  GPMSBodyView.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit

class GPMSBodyView: XibView {

    @IBOutlet weak var lwpUnderBgView: UIView!
    @IBOutlet weak var lwpBgView: UIView!
    
    @IBOutlet weak var hpdUnderBgView: UIView!
    @IBOutlet weak var hpdBgView: UIView!
    
    @IBOutlet weak var bwpdUnderBgView: UIView!
    @IBOutlet weak var bwpdBgView: UIView!
    
    @IBOutlet weak var hpdsUnderBgView: UIView!
    @IBOutlet weak var hpdsBgView: UIView!
    
    
    var LWPHandler : ((Bool?) -> Void)?
    var HPDHandler : ((Bool?) -> Void)?
    var BWPDHandler : ((Bool?) -> Void)?
    var HPDsHandler : ((Bool?) -> Void)?
    
    @IBAction func lwpBtn(_ sender: UIButton) {
        self.LWPHandler?(true)
    }
    
    @IBAction func hpdBtn(_ sender: Any) {
        
        self.HPDHandler?(true)
    }
    
    @IBAction func bwpdBtn(_ sender: Any) {
        
        self.BWPDHandler?(true)
    }
    
    @IBAction func hpdsBtn(_ sender: Any) {
        
        self.HPDsHandler?(true)
    }
    
    
}
