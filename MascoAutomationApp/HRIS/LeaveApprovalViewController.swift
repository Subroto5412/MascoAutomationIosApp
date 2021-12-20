//
//  LeaveApprovalViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/12/21.
//

import UIKit

class LeaveApprovalViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var bodyView: LeaveApprovalBodyView!
    
    
    class func initWithStoryboard() -> LeaveApprovalViewController
    {
        let storyboard = UIStoryboard(name: "HRIS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LeaveApprovalViewController.className) as! LeaveApprovalViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bodyView.leaveApprovalBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveApprovalBgView.layer.borderWidth = 0.5
        self.bodyView.leaveApprovalBgView.layer.cornerRadius = 20

        self.bodyView.leaveApprovalUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveApprovalUnderBgView.layer.borderWidth = 0.5
        self.bodyView.leaveApprovalUnderBgView.layer.cornerRadius = 20
        

        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    func showBackController(){
        let controller = HRISViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

}
