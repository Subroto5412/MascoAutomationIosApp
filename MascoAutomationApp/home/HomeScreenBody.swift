//
//  HomeScreenBody.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 23/11/21.
//

import UIKit

class HomeScreenBody: XibView {

    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var itemNameView: UIView!
    
    @IBOutlet weak var scmItemNameView: UIView!
    @IBOutlet weak var scmIconView: UIView!
    
    @IBOutlet weak var pmsItemNameView: UIView!
    @IBOutlet weak var pmsIconView: UIView!
    
    @IBOutlet weak var mmItemNameView: UIView!
    @IBOutlet weak var mmIconView: UIView!
    
    @IBOutlet weak var atmItemNameView: UIView!
    @IBOutlet weak var atmIconView: UIView!
    
    @IBOutlet weak var amsItemNameView: UIView!
    @IBOutlet weak var amsIconView: UIView!
    
    @IBOutlet weak var semItemNameView: UIView!
    @IBOutlet weak var semIconView: UIView!
    
    @IBOutlet weak var dsmItemNameView: UIView!
    @IBOutlet weak var dsmIconView: UIView!
    
    @IBOutlet weak var ilmItemNameView: UIView!
    @IBOutlet weak var ilmIconView: UIView!
    
    @IBOutlet weak var dmsItemNameview: UIView!
    @IBOutlet weak var dmsIconView: UIView!
    
    @IBOutlet weak var amIconView: UIView!
    @IBOutlet weak var amItemNameView: UIView!
    
    @IBOutlet weak var ddItemNameView: UIView!
    @IBOutlet weak var ddIconView: UIView!
    
    
    var HRISHandler : ((Bool?) -> Void)?
    var PMSHandler : ((Bool?) -> Void)?
    var SEMHandler : ((Bool?) -> Void)?
    var ATMHandler : ((Bool?) -> Void)?
    var ILMHandler : ((Bool?) -> Void)?
    var DSMHandler : ((Bool?) -> Void)?
    var DMSHandler : ((Bool?) -> Void)?
    var AMSHandler : ((Bool?) -> Void)?
    var AMHandler : ((Bool?) -> Void)?
    var MMHandler : ((Bool?) -> Void)?
    var SCMHandler : ((Bool?) -> Void)?
    var DDHandler : ((Bool?) -> Void)?
    
    @IBAction func HRISBtn(_ sender: UIButton) {
        self.HRISHandler?(true)
    }
    
    @IBAction func PMSBtn(_ sender: Any) {
        self.PMSHandler?(true)
    }
    
    @IBAction func SEMBtn(_ sender: Any) {
        self.SEMHandler?(true)
    }
    
    @IBAction func ATMBtn(_ sender: Any) {
        self.ATMHandler?(true)
    }
    
    @IBAction func ILMBtn(_ sender: Any) {
        self.ILMHandler?(true)
    }
    
    @IBAction func AMBtn(_ sender: Any) {
        self.AMHandler?(true)
    }
    
    @IBAction func DMSBtn(_ sender: Any) {
        self.DMSHandler?(true)
    }
    
    @IBAction func DSMBtn(_ sender: Any) {
        self.DSMHandler?(true)
    }
    
    @IBAction func AMSBtn(_ sender: Any) {
        self.AMSHandler?(true)
    }
    
    @IBAction func MMBtn(_ sender: Any) {
        self.MMHandler?(true)
    }
    
    @IBAction func SCMBtn(_ sender: Any) {
        self.SCMHandler?(true)
    }
    
    @IBAction func DDBtn(_ sender: Any) {
        self.DDHandler?(true)
    }
    
}
