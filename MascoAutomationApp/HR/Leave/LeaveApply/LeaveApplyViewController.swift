//
//  LeaveApplyViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 13/12/21.
//

import UIKit
import YYCalendar

class LeaveApplyViewController: UIViewController {
    
    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var bodyView: ApplyFormView!
    @IBOutlet weak var footerView: CommonFooter!
    
    class func initWithStoryboard() -> LeaveApplyViewController
    {
        let storyboard = UIStoryboard(name: "LeaveApply", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LeaveApplyViewController.className) as! LeaveApplyViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bodyView.IdBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.IdBgView.layer.borderWidth = 0.5
        self.bodyView.IdBgView.layer.cornerRadius = 4
        
        self.bodyView.nameBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.nameBgView.layer.borderWidth = 0.5
        self.bodyView.nameBgView.layer.cornerRadius = 4
        
        self.bodyView.designationBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.designationBgView.layer.borderWidth = 0.5
        self.bodyView.designationBgView.layer.cornerRadius = 4
        
        self.bodyView.leaveTypeBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveTypeBgView.layer.borderWidth = 0.5
        self.bodyView.leaveTypeBgView.layer.cornerRadius = 4
        
        self.bodyView.leaveNoBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveNoBgView.layer.borderWidth = 0.5
        self.bodyView.leaveNoBgView.layer.cornerRadius = 4
        
        self.bodyView.leaveRequiredBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveRequiredBgView.layer.borderWidth = 0.5
        self.bodyView.leaveRequiredBgView.layer.cornerRadius = 4
        
        self.bodyView.leaveRequiredToBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveRequiredToBgView.layer.borderWidth = 0.5
        self.bodyView.leaveRequiredToBgView.layer.cornerRadius = 4
        
        self.bodyView.totalDaysBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.totalDaysBgView.layer.borderWidth = 0.5
        self.bodyView.totalDaysBgView.layer.cornerRadius = 4
        
        self.bodyView.reasonBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.reasonBgView.layer.borderWidth = 0.5
        self.bodyView.reasonBgView.layer.cornerRadius = 4
        
       // self.bodyView.reasonBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
       // self.bodyView.reasonBgView.layer.borderWidth = 0.5
        self.bodyView.saveBgView.layer.cornerRadius = 20
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
        
        self.bodyView.applyFromHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.applyFromDate()
        }
        
        self.bodyView.applyToHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.applyToDate()
        }
    }
    

    func showBackController(){
        let controller = LeaveViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func applyFromDate() {
        
       let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let calendar = YYCalendar(normalCalendarLangType: .ENG3,
                                  date: dateFormatter.string(from: currentDate),
                                          format: "dd-MM-yyyy") { [weak self] date in
            self?.bodyView.applyFromDate.text = date
            print(date)
                }
        
        calendar.sundayColor = UIColor.gray
        calendar.defaultDayColor = UIColor.gray
        calendar.saturdayColor = UIColor.gray
        
        calendar.show()
        
    }
    
    func applyToDate() {
        
       let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let calendar = YYCalendar(normalCalendarLangType: .ENG3,
                                  date: dateFormatter.string(from: currentDate),
                                          format: "dd-MM-yyyy") { [weak self] date in
            self?.bodyView.ApplyToDate.text = date
            print(date)
                }
        
        calendar.sundayColor = UIColor.gray
        calendar.defaultDayColor = UIColor.gray
        calendar.saturdayColor = UIColor.gray
        
        calendar.show()
        
    }

}
