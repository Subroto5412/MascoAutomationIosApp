//
//  DailyAttendanceViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/11/21.
//

import UIKit

class DailyAttendanceViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var bodyView: DailyAttendanceView!
    @IBOutlet weak var footerView: CommonFooter!
    
    class func initWithStoryboard() -> DailyAttendanceViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: DailyAttendanceViewController.className) as! DailyAttendanceViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bodyView.dailyAttendanceUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.dailyAttendanceUnderBgView.layer.borderWidth = 0.5
        self.bodyView.dailyAttendanceUnderBgView.layer.cornerRadius = 20
        
        self.bodyView.dailyAttendanceBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.dailyAttendanceBgView.layer.borderWidth = 0.5
        self.bodyView.dailyAttendanceBgView.layer.cornerRadius = 20
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
        
        self.bodyView.dailyAttendanceHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showDailyAttendanceController()
        }
    }
    
        func showBackController(){
            let controller = HRViewController.initWithStoryboard()
            self.present(controller, animated: true, completion: nil);
        }
    
    
    func showDailyAttendanceController(){
        let controller = DailyAttendanceViewControllerDetails.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}


