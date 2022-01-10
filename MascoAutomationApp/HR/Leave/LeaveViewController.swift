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
    
    
    class func initWithStoryboard() -> LeaveViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LeaveViewController.className) as! LeaveViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Leave History"
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
        
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
        
        self.leaveBodyView.leaveDetailsHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showLeaveDetails()
        }
        
        self.leaveBodyView.leaveApplyHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showLeaveApplyForm()
        }
        
    }
    func showBackController(){
        let controller = HRViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showLeaveDetails(){
        let controller = LeaveDetailsViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showLeaveApplyForm(){
        let controller = LeaveApplyViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}
