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
    
    
    var HRISHandler : ((Bool?) -> Void)?
    var PMSHandler : ((Bool?) -> Void)?
    var SEMHandler : ((Bool?) -> Void)?
    var ATMHandler : ((Bool?) -> Void)?
    
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
}
