//
//  GPMSViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit

class GPMSViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var bodyView: GPMSBodyView!
    
    class func initWithStoryboard() -> GPMSViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: GPMSViewController.className) as! GPMSViewController
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
        
        self.bodyView.LWPHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showLWPController()
        }
        
        self.bodyView.HPDsHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showHPDController()
        }
        
        self.bodyView.BWPDHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBWPDController()
        }
        
        self.bodyView.HPDHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showHPDController()
        }
        self.bodyView.lwpUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.lwpUnderBgView.layer.borderWidth = 0.5
        self.bodyView.lwpUnderBgView.layer.cornerRadius = 20
        
        self.bodyView.lwpBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.lwpBgView.layer.borderWidth = 0.5
        self.bodyView.lwpBgView.layer.cornerRadius = 20
        
        self.bodyView.hpdUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.hpdUnderBgView.layer.borderWidth = 0.5
        self.bodyView.hpdUnderBgView.layer.cornerRadius = 20
        
        self.bodyView.hpdBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.hpdBgView.layer.borderWidth = 0.5
        self.bodyView.hpdBgView.layer.cornerRadius = 20
        
        self.bodyView.bwpdUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.bwpdUnderBgView.layer.borderWidth = 0.5
        self.bodyView.bwpdUnderBgView.layer.cornerRadius = 20
        
        self.bodyView.bwpdBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.bwpdBgView.layer.borderWidth = 0.5
        self.bodyView.bwpdBgView.layer.cornerRadius = 20
        
        self.bodyView.hpdsUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.hpdsUnderBgView.layer.borderWidth = 0.5
        self.bodyView.hpdsUnderBgView.layer.cornerRadius = 20
        
        self.bodyView.hpdsBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.hpdsBgView.layer.borderWidth = 0.5
        self.bodyView.hpdsBgView.layer.cornerRadius = 20
    }
    
    func showBackController(){
        let controller = PMSViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

    func showHPDsController(){
        let controller = HPDsViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showBWPDController(){
        let controller = BWPDViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showHPDController(){
        let controller = HPDViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showLWPController(){
        let controller = LWPViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}
