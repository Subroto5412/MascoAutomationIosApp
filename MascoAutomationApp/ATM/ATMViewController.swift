//
//  ATMViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 19/12/21.
//

import UIKit

class ATMViewController: UIViewController {

    @IBOutlet weak var headerView: InnerHeader!
    @IBOutlet weak var bodyView: ATMBodyView!
    
    class func initWithStoryboard() -> ATMViewController
    {
        let storyboard = UIStoryboard(name: "ATM", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ATMViewController.className) as! ATMViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bodyView.assetBasicUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.assetBasicUnderBgView.layer.borderWidth = 0.5
        self.bodyView.assetBasicUnderBgView.layer.cornerRadius = 20
        
        self.bodyView.assetBasicBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.assetBasicBgView.layer.borderWidth = 0.5
        self.bodyView.assetBasicBgView.layer.cornerRadius = 20
        
        self.headerView.searchBgView.layer.cornerRadius = 10
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showHomeController()
        }
    }

    func showHomeController(){
        let controller = HomeViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}
