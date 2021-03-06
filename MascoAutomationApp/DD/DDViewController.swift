//
//  DDViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/1/22.
//

import UIKit

class DDViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var bodyView: DDBodyView!
    @IBOutlet weak var footerView: CommonFooter!
    
    class func initWithStoryboard() -> DDViewController
    {
        let storyboard = UIStoryboard(name: "DD", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: DDViewController.className) as! DDViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Dispatch Delivery"
        self.hideKeyboardWhenTappedAround()
        self.uiViewDesign()
        self.navigationLink()
    }
}

extension DDViewController{
    
    func uiViewDesign(){
        self.bodyView.trackingBgViewUnder.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.trackingBgViewUnder.layer.borderWidth = 0.5
        self.bodyView.trackingBgViewUnder.layer.cornerRadius = 20
        
        self.bodyView.trackingBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.trackingBgView.layer.borderWidth = 0.5
        self.bodyView.trackingBgView.layer.cornerRadius = 20
    }
}

extension DDViewController{
    
    func navigationLink(){
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
        
        self.bodyView.trackingListHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showTrackingListController()
        }
    }
    
    func showBackController(){
        let controller = HomeViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showTrackingListController(){
        let controller = TrackingListViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}
