//
//  OTPViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/11/21.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var empIdTxtfield: UITextField!
    @IBOutlet weak var optSendBtn: UIButton!
    
    class func initWithStoryboard() -> OTPViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: OTPViewController.className) as! OTPViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        empIdTxtfield.layer.borderColor = UIColor(red: 104, green: 156, blue: 255, alpha: 1.0).cgColor
        empIdTxtfield.layer.borderWidth = 0.5
        empIdTxtfield.layer.cornerRadius = 5.0;
        
        optSendBtn.layer.cornerRadius = 20.0;
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
