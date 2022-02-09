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
    
    @IBOutlet weak var oneTxtField: UITextField!
    @IBOutlet weak var twoTxtField: UITextField!
    @IBOutlet weak var threeTxtField: UITextField!
    @IBOutlet weak var fourTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var repasswordTxtField: UITextField!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var otpVerified: UIImageView!
    @IBOutlet weak var passwordVerified: UIImageView!
    
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var mobileLbl2: UILabel!
    
    class func initWithStoryboard() -> SignupViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: SignupViewController.className) as! SignupViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.uiViewDesign()
        let utils = Utils()
        mobileLbl.text = utils.readStringData(key: "mobile")
    }
    
    @IBAction func firstBtn(_ sender: Any) {
        let utils = Utils()
        let otp = oneTxtField.text! + twoTxtField.text! + threeTxtField.text! + fourTxtField.text!
       
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getOTPVerified(otp:otp, empID: utils.readStringData(key: "empCode"))
        }else{
            self.toastMessage("No Internet Connected!!")
        }
    }
    
    @IBAction func secondBtn(_ sender: Any) {
        let utils = Utils()
        let otp = oneTxtField.text! + twoTxtField.text! + threeTxtField.text! + fourTxtField.text!
       
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getOTPVerified(otp:otp, empID: utils.readStringData(key: "empCode"))
        }else{
            self.toastMessage("No Internet Connected!!")
        }
    }
    
    @IBAction func threeBTn(_ sender: Any) {
        let utils = Utils()
        let otp = oneTxtField.text! + twoTxtField.text! + threeTxtField.text! + fourTxtField.text!
       
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getOTPVerified(otp:otp, empID: utils.readStringData(key: "empCode"))
        }else{
            self.toastMessage("No Internet Connected!!")
        }
    }
    
    @IBAction func fourBtn(_ sender: Any) {
        let utils = Utils()
        let otp = oneTxtField.text! + twoTxtField.text! + threeTxtField.text! + fourTxtField.text!
        
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getOTPVerified(otp:otp, empID: utils.readStringData(key: "empCode"))
        }else{
            self.toastMessage("No Internet Connected!!")
        }
    }
    
    @IBAction func passwordBtn(_ sender: Any) {
        if repasswordTxtField.text == passwordTxtField.text{
            self.passwordVerified.isHidden = false
        }else{
            self.passwordVerified.isHidden = true
        }
    }
    
    @IBAction func rePasswordBtn(_ sender: Any) {
        
        if passwordTxtField.text == repasswordTxtField.text{
            self.passwordVerified.isHidden = false
        }else{
            self.passwordVerified.isHidden = true
        }
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        let utils = Utils()
        
        if InternetConnectionManager.isConnectedToNetwork(){
            self.setPassword(empCODE: utils.readStringData(key: "empCode"), Password: repasswordTxtField.text!)
        }else{
            self.toastMessage("No Internet Connected!!")
        }
    }
}

extension SignupViewController {
    func showLoading(finished: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)

        present(alert, animated: false, completion: finished)
    }

    func hideLoading(finished: @escaping () -> Void) {
        if ( presentedViewController != nil && !presentedViewController!.isBeingPresented ) {
            dismiss(animated: false, completion: finished)
        }
    }
 }

extension SignupViewController{
    
    func uiViewDesign(){
        
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
    
    func getOTPVerified(otp:String, empID: String){
        
        let url = URL(string: VERIFY_OTP_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let itemModel = OTPVerifyRequest(OTP: otp,empId: empID)
        let jsonData = try? JSONEncoder().encode(itemModel)
        
        request.httpBody = jsonData
        
        self.showLoading(finished: {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    self.hideLoading(finished: {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let item = try JSONDecoder().decode(OTPVerifyResponse.self, from: data)

                        print(item.response!)
                        if item.response! {
                            self.toastMessage("OTP Send Successfully!!")
                            self.otpVerified.isHidden = false
                        }else{
                            self.otpVerified.isHidden = true
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                    })
                }
        }
        task.resume()
        })
    }
    
    func setPassword(empCODE: String, Password: String){
        
        let url = URL(string: REGISTER_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let itemModel = setPasswordRequest(emP_CODE: empCODE, password: Password)
        let jsonData = try? JSONEncoder().encode(itemModel)
        
        request.httpBody = jsonData
        
        self.showLoading(finished: {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    self.hideLoading(finished: {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let item = try JSONDecoder().decode(setPasswordResponse.self, from: data)

                        print(item.response!)
                        if item.response! {
                            self.toastMessage("Successfully Registration!")
                            let controller = ViewController.initWithStoryboard()
                            self.present(controller, animated: true, completion: nil);
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                    })
                }
        }
        task.resume()
        })
    }
}
