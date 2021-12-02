//
//  ViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 17/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var empId: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        empId.layer.borderColor = UIColor(red: 104, green: 156, blue: 255, alpha: 1.0).cgColor
        empId.layer.borderWidth = 0.5;
        empId.layer.cornerRadius = 5.0;
        
        password.layer.borderColor = UIColor(red: 104.0, green: 156, blue: 255, alpha: 1.0).cgColor
        password.layer.borderWidth = 0.5;
        password.layer.cornerRadius = 5.0;
        
        signInBtn.layer.cornerRadius = 20.0;
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            print(UIDevice.current.modelName)
            
        }
    
    @IBAction func signInBtn(_ sender: Any) {
        
        if InternetConnectionManager.isConnectedToNetwork(){
            print("Connected")
        }else{
            print("Not Connected")
        }
        

            
                    
        
        if let text = empId.text, text.isEmpty {
            print("--Enter EmpId--")
        } else if let text1 = password.text, text1.isEmpty {
            print("--Enter password--")
        }else{
            let controller = HomeViewController.initWithStoryboard()
            self.present(controller, animated: true, completion: nil);
        }
        
    }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        
        let controller = OTPViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    @IBAction func signipBtn(_ sender: Any) {
        
        let controller = OTPViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    

}
