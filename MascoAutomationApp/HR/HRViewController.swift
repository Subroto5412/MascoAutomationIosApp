//
//  HRViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 25/11/21.
//

import UIKit

class HRViewController: UIViewController {

    @IBOutlet weak var innerHeaderView: InnerHeader!
    @IBOutlet weak var hrBodyView: HrBodyView!
    
    class func initWithStoryboard() -> HRViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HRViewController.className) as! HRViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.hrBodyView.attendanceUnderBgView.layer.
        
        self.hrBodyView.attendanceUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.attendanceUnderBgView.layer.borderWidth = 0.05
        self.hrBodyView.attendanceUnderBgView.layer.cornerRadius = 20
        
        self.hrBodyView.attendanceBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.attendanceBgView.layer.borderWidth = 0.05
        self.hrBodyView.attendanceBgView.layer.cornerRadius = 20
        
        
        self.hrBodyView.leaveUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.leaveUnderBgView.layer.borderWidth = 0.05
        self.hrBodyView.leaveUnderBgView.layer.cornerRadius = 20
        
        self.hrBodyView.leaveBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.leaveBgView.layer.borderWidth = 0.05
        self.hrBodyView.leaveBgView.layer.cornerRadius = 20
        
        
        self.hrBodyView.taxUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.taxUnderBgView.layer.borderWidth = 0.05
        self.hrBodyView.taxUnderBgView.layer.cornerRadius = 20
        
        self.hrBodyView.taxBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.taxBgView.layer.borderWidth = 0.05
        self.hrBodyView.taxBgView.layer.cornerRadius = 20
        
        self.innerHeaderView.searchBgView.layer.cornerRadius = 10
        
        self.innerHeaderView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showHomeController()
        }
        
        self.hrBodyView.attendanceHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showAttendanceController()
        }
        
        
        self.hrBodyView.leaveHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showLeaveController()
        }
        
        self.hrBodyView.incomeTaxHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showIncomeTaxController()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func showHomeController(){
        
        let controller = HomeViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showAttendanceController(){
        
        let controller = DailyAttendanceViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showLeaveController(){
        
        let controller = LeaveViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showIncomeTaxController(){
        
        let controller = IncomeTaxViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}
