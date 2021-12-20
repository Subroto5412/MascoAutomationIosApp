//
//  CommunicationPortalViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/12/21.
//

import UIKit

class CommunicationPortalViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var unitNameDropDown: UIButton!
    
    @IBOutlet weak var nameDropDown: UIButton!
    
    
    class func initWithStoryboard() -> CommunicationPortalViewController
    {
        let storyboard = UIStoryboard(name: "SEM", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: CommunicationPortalViewController.className) as! CommunicationPortalViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.nameDropDown.layer.borderWidth = 0.5
        self.nameDropDown.layer.cornerRadius = 5
        
        self.unitNameDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.unitNameDropDown.layer.borderWidth = 0.5
        self.unitNameDropDown.layer.cornerRadius = 5
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    
    func showBackController(){
        let controller = SEMViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

}
