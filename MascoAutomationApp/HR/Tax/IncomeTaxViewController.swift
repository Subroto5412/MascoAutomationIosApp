//
//  IncomeTaxViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/11/21.
//

import UIKit

class IncomeTaxViewController: UIViewController {
    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var bodyView: IncomeTaxView!
    @IBOutlet weak var footerView: CommonFooter!
    
    
    class func initWithStoryboard() -> IncomeTaxViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: IncomeTaxViewController.className) as! IncomeTaxViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        self.headerView.titleNameLbl.text = "Income Tax History"
        self.bodyView.taxUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.taxUnderBgView.layer.borderWidth = 0.5
        self.bodyView.taxUnderBgView.layer.cornerRadius = 20
        
        self.bodyView.taxBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.taxBgView.layer.borderWidth = 0.5
        self.bodyView.taxBgView.layer.cornerRadius = 20
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }

        self.bodyView.taxDetailsHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showTaxDetailsController()
        }
        
    }
    
    
    func showBackController(){
        
        let controller = HRViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showTaxDetailsController(){
        
        let controller = TaxDetailsViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}
