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


}

