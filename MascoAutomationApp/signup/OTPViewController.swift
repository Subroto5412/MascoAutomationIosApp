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

    @IBAction func sendOTPBtn(_ sender: Any) {
    
        if InternetConnectionManager.isConnectedToNetwork(){
            
           if let empIdTxt = empIdTxtfield.text, empIdTxt.isEmpty {
                self.toastMessage("Enter Employee ID")
            }else{
                let _empIdTxtfield: String = empIdTxtfield.text!
                self.sendOTP(empID: _empIdTxtfield)
            }
            
        }else{
            print("Not Connected")
        }
    }

    @IBAction func sendBtnActive(_ sender: Any) {
        self.optSendBtn.backgroundColor = UIColor.white
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        
        let controller = ViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
       
    }
    
    func sendOTP(empID: String){
        var utils = Utils()
        let url = URL(string: SEND_OTP_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let itemModel = OTPSendRequest(empId: empID)
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
                        let item = try JSONDecoder().decode(OTPSendResponse.self, from: data)

                        print(item.response!)
                        if item.response! {
                            utils.writeAnyData(key: "empCode", value: empID)
                            self.toastMessage("OTP Send Successfully!!")
                            let controller = SignupViewController.initWithStoryboard()
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


extension OTPViewController{
    
    struct OTPSendRequest: Codable {
        var empId: String = ""
        
        enum CodingKeys: String, CodingKey {
            case empId = "empId"
        }
    }
    
    struct OTPSendResponse: Codable {
        var response: Bool?
        var error: String = ""
        var message: String = ""
        var data: String = ""
        var token: String = ""
        var image_name: String = ""
        var user_entry_id: Int?
        var mobile: String = ""
        
        enum CodingKeys: String, CodingKey {
            case response = "response"
            case error = "error"
            case message = "message"
            case data = "data"
            case token = "token"
            case image_name = "image_name"
            case user_entry_id = "user_entry_id"
            case mobile = "mobile"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.response = try container.decodeIfPresent(Bool.self, forKey: .response)
               self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
               self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
               self.data = try container.decodeIfPresent(String.self, forKey: .data) ?? ""
               self.token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
               self.image_name = try container.decodeIfPresent(String.self, forKey: .image_name) ?? ""
               self.user_entry_id = try container.decodeIfPresent(Int.self, forKey: .user_entry_id) ?? 0
               self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(response, forKey: .response)
               try container.encode(error, forKey: .error)
               try container.encode(message, forKey: .message)
               try container.encode(data, forKey: .data)
               try container.encode(token, forKey: .token)
               try container.encode(image_name, forKey: .image_name)
               try container.encode(user_entry_id, forKey: .user_entry_id)
               try container.encode(mobile, forKey: .mobile)
           }
    }
}

extension OTPViewController {
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
