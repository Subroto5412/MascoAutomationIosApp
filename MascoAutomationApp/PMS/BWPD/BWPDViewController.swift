//
//  BWPDViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit

class BWPDViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    
    class func initWithStoryboard() -> BWPDViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: BWPDViewController.className) as! BWPDViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    

    func showBackController(){
        let controller = PMSViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

}
