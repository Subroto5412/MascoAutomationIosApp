//
//  HRViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 25/11/21.
//

import UIKit

class HRViewController: UIViewController {

    @IBOutlet weak var hrBodyView: HrBodyView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.hrBodyView.attendanceUnderBgView.layer.
        
        self.hrBodyView.attendanceUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.attendanceUnderBgView.layer.borderWidth = 0.5
        self.hrBodyView.attendanceUnderBgView.layer.cornerRadius = 20
        
        self.hrBodyView.attendanceBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.attendanceBgView.layer.borderWidth = 0.5
        self.hrBodyView.attendanceBgView.layer.cornerRadius = 20
        
        
        self.hrBodyView.leaveUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.leaveUnderBgView.layer.borderWidth = 0.5
        self.hrBodyView.leaveUnderBgView.layer.cornerRadius = 20
        
        self.hrBodyView.leaveBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.leaveBgView.layer.borderWidth = 0.5
        self.hrBodyView.leaveBgView.layer.cornerRadius = 20
        
        
        self.hrBodyView.taxUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.taxUnderBgView.layer.borderWidth = 0.5
        self.hrBodyView.taxUnderBgView.layer.cornerRadius = 20
        
        self.hrBodyView.taxBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.taxBgView.layer.borderWidth = 0.5
        self.hrBodyView.taxBgView.layer.cornerRadius = 20
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
