//
//  HRISViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/12/21.
//

import UIKit

class HRISViewController: UIViewController {

    @IBOutlet weak var headerView: InnerHeader!
    @IBOutlet weak var bodyView: HRISBodyView!
    
    class func initWithStoryboard() -> HRISViewController
    {
        let storyboard = UIStoryboard(name: "HRIS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HRISViewController.className) as! HRISViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bodyView.HRISUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.HRISUnderBgView.layer.borderWidth = 0.5
        self.bodyView.HRISUnderBgView.layer.cornerRadius = 20

        self.bodyView.HRISBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.HRISBgView.layer.borderWidth = 0.5
        self.bodyView.HRISBgView.layer.cornerRadius = 20
        
        self.headerView.searchBgView.layer.cornerRadius = 10
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showHomeController()
        }
        
        self.bodyView.HRISHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showLeaveApprovalController()
        }
    }
    
    func showHomeController(){
        let controller = HomeViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showLeaveApprovalController(){
        let controller = LeaveApprovalViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

}
