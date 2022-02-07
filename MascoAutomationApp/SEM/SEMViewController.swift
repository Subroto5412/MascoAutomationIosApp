//
//  SEMViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 19/12/21.
//

import UIKit

class SEMViewController: UIViewController {


    @IBOutlet weak var bodyView: SEMBodyView!
    
    @IBOutlet weak var headerView: CommonHeaderView!
    
    
    class func initWithStoryboard() -> SEMViewController
    {
        let storyboard = UIStoryboard(name: "SEM", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: SEMViewController.className) as! SEMViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.titleNameLbl.text = "Search Engine Management"
        
        self.hideKeyboardWhenTappedAround()
        
        self.bodyView.communicationPortalUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.communicationPortalUnderBgView.layer.borderWidth = 0.5
        self.bodyView.communicationPortalUnderBgView.layer.cornerRadius = 20

        self.bodyView.communicationPortalBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.communicationPortalBgView.layer.borderWidth = 0.5
        self.bodyView.communicationPortalBgView.layer.cornerRadius = 20
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showHomeController()
        }
        
        self.bodyView.CPHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showCPController()
        }
    }
    

    func showHomeController(){
        let controller = HomeViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showCPController(){
        let controller = CommunicationPortalViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

}
