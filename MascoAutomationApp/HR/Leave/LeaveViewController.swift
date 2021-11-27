//
//  LeaveViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/11/21.
//

import UIKit

class LeaveViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var leaveBodyView: LeaveView!
    
    @IBOutlet weak var footerView: CommonFooter!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.leaveBodyView.leaveDetailsUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.leaveBodyView.leaveDetailsUnderBgView.layer.borderWidth = 0.5
        self.leaveBodyView.leaveDetailsUnderBgView.layer.cornerRadius = 20
        
        self.leaveBodyView.leaveDetailsBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.leaveBodyView.leaveDetailsBgView.layer.borderWidth = 0.5
        self.leaveBodyView.leaveDetailsBgView.layer.cornerRadius = 20
        
        
        self.leaveBodyView.leaveApplyUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.leaveBodyView.leaveApplyUnderBgView.layer.borderWidth = 0.5
        self.leaveBodyView.leaveApplyUnderBgView.layer.cornerRadius = 20
        
        self.leaveBodyView.leaveApplyBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.leaveBodyView.leaveApplyBgView.layer.borderWidth = 0.5
        self.leaveBodyView.leaveApplyBgView.layer.cornerRadius = 20
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
