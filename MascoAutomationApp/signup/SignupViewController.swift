//
//  SignupViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/11/21.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var topUIView: UIView!
    @IBOutlet weak var verifiedDigitView: UIView!
    
    @IBOutlet weak var digitOneView: UIView!
    @IBOutlet weak var digitTwoView: UIView!
    @IBOutlet weak var digitThreeView: UIView!
    @IBOutlet weak var digitFourView: UIView!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var repasswordTxtField: UITextField!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTxtField.layer.borderColor = UIColor(red: 104, green: 156, blue: 255, alpha: 1.0).cgColor
        passwordTxtField.layer.borderWidth = 0.5
        passwordTxtField.layer.cornerRadius = 5.0;
        
        repasswordTxtField.layer.borderColor = UIColor(red: 104, green: 156, blue: 255, alpha: 1.0).cgColor
        repasswordTxtField.layer.borderWidth = 0.5
        repasswordTxtField.layer.cornerRadius = 5.0;
        
        
        verifiedDigitView.layer.borderColor = UIColor(red: 104, green: 156, blue: 255, alpha: 1.0).cgColor
        verifiedDigitView.layer.cornerRadius = 5.0;
        verifiedDigitView.layer.borderWidth = 0.5
        
        
        digitOneView.layer.borderColor = UIColor(red: 104, green: 156, blue: 255, alpha: 1.0).cgColor
        digitOneView.layer.borderWidth = 0.5
        digitOneView.layer.cornerRadius = 14.5
        
        
        digitTwoView.layer.borderColor = UIColor(red: 104, green: 156, blue: 255, alpha: 1.0).cgColor
        digitTwoView.layer.borderWidth = 0.5
        digitTwoView.layer.cornerRadius = 14.5
        
        digitThreeView.layer.borderColor = UIColor(red: 104, green: 156, blue: 255, alpha: 1.0).cgColor
        digitThreeView.layer.borderWidth = 0.5
        digitThreeView.layer.cornerRadius = 14.5
        
        digitFourView.layer.borderColor = UIColor(red: 104, green: 156, blue: 255, alpha: 1.0).cgColor
        digitFourView.layer.borderWidth = 0.5
        digitFourView.layer.cornerRadius = 14.5
        
        
        topUIView.layer.cornerRadius = 50
        topUIView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        signupBtn.layer.cornerRadius = 20.0;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

