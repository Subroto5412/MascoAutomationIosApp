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
    @IBOutlet weak var customerProfilePhoto: UIImageView!
    @IBOutlet weak var rememberMe: UIButton!
    
    var empCodeString = ""
    
    
    class func initWithStoryboard() -> ViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ViewController.className) as! ViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        let utils = Utils()
         if utils.readStringData(key: "REMEMBER_ME") == "true"{
             self.rememberMe.setImage(UIImage(named: "checking"), for: UIControl.State.normal)
             self.empId.text = utils.readStringData(key: "EMP_ID")
             self.password.text = utils.readStringData(key: "PASSWORD")
         } else {
             self.rememberMe.setImage(UIImage(named: "not_checking"), for: UIControl.State.normal)
             utils.writeAnyData(key: "EMP_ID", value: "")
             utils.writeAnyData(key: "PASSWORD", value: "")
         }
        
        
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
        let utils = Utils()
        if InternetConnectionManager.isConnectedToNetwork(){
            
            if let text = empId.text, text.isEmpty {
                self.toastMessage("Enter EmpId")
            } else if let text1 = password.text, text1.isEmpty {
                self.toastMessage("Enter password")
            }else{
                let _empId: String = empId.text!
                let _password: String = password.text!
               
                utils.writeAnyData(key: "EMP_ID", value: _empId)
                utils.writeAnyData(key: "PASSWORD", value: _password)
                
                self.userLogin(userId: _empId, password: _password)
            }
            
        }else{
            self.toastMessage("No Internet Connected!!")
        }
    }
    @IBAction func rememberMeBtn(_ sender: Any) {

       let utils = Utils()
        if utils.readStringData(key: "REMEMBER_ME") == "true"{
            self.rememberMe.setImage(UIImage(named: "not_checking"), for: UIControl.State.normal)
            utils.writeAnyData(key: "REMEMBER_ME", value: "false")
        } else {
            self.rememberMe.setImage(UIImage(named: "checking"), for: UIControl.State.normal)
            utils.writeAnyData(key: "REMEMBER_ME", value: "true")
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
    
    @IBAction func getProfileImageTF(_ sender: Any) {
        getProfilePhot(photoId: empId.text!)
    }
    
    func userLogin(userId: String, password: String){
        
        let utils = Utils()
       
        let url = URL(string: LOGIN_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let newTodoItem = ToDoRequestModel(empId: userId, password: password)
        let jsonData = try? JSONEncoder().encode(newTodoItem)
        
        

        request.httpBody = jsonData

        print("jsonData jsonData  data:\n \(jsonData!)")
        
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
                        
                        let todoItemModel = try JSONDecoder().decode(LoginResponse.self, from: data)
                        print("Response data:\n \(todoItemModel)")
                        print("todoItemModel Title: \(todoItemModel.mobile)")
                        print("todoItemModel empCode: \(todoItemModel.empCode)")
                        print("todoItemModel empId: \(todoItemModel.empId!)")
                        print("todoItemModel token: \(todoItemModel.token)")
                        print("todoItemModel refresh_token: \(todoItemModel.refresh_token)")
                        print("todoItemModel error: \(todoItemModel.error)")
                        
                        utils.writeAnyData(key: "token", value: todoItemModel.token)
                        utils.writeAnyData(key: "empCode", value: todoItemModel.empCode)
                        
                        self.empCodeString = todoItemModel.empCode
                        
                        for permission in todoItemModel._permissionList {
                            
                            if permission.moduleName == "GPMSModule"{
                                utils.writeAnyData(key: "GPMSModule", value: permission.moduleName)
                            }
                            else if permission.moduleName == "HRModule"{
                                utils.writeAnyData(key: "HRModule", value: permission.moduleName)
                            }
                            else if permission.moduleName == "SCMModule"{
                                utils.writeAnyData(key: "SCMModule", value: permission.moduleName)
                            }
                            
                            print("todoItemModel -----: \(permission.moduleName)")
                            print("_subMenuList -----: \(permission._subMenuList)")
                            
                            for subMenuList in permission._subMenuList {
                                print("activityName -----: \(subMenuList.activityNameStr)")
                                dataSourceScreen.append(subMenuList.activityNameStr)
                                
                                if subMenuList.activityName == "buyer_wise_production_data"{
                                    utils.writeAnyData(key: "BWPD", value: subMenuList.activityNameStr)
                                }
                                else if subMenuList.activityName == "hourly_production_data"{
                                    utils.writeAnyData(key: "HPD", value: subMenuList.activityNameStr)
                                }
                                else if subMenuList.activityName == "hourly_production_details"{
                                    utils.writeAnyData(key: "HPDs", value: subMenuList.activityNameStr)
                                }
                                else if subMenuList.activityName == "line_wise_production"{
                                    utils.writeAnyData(key: "LWP", value: subMenuList.activityNameStr)
                                }
                                else if subMenuList.activityName == "daily_attendance"{
                                    utils.writeAnyData(key: "DA", value: subMenuList.activityNameStr)
                                }
                                else if subMenuList.activityName == "leave_history"{
                                    utils.writeAnyData(key: "LH", value: subMenuList.activityNameStr)
                                }
                                else if subMenuList.activityName == "tax_history"{
                                    utils.writeAnyData(key: "TH", value: subMenuList.activityNameStr)
                                }
                            }
                        }
                        
                        if !self.empCodeString.isEmpty{
                            
                            self.dismiss(animated: true, completion: nil)
                        }
                      
                        if !self.empCodeString.isEmpty{
                            
                            let controller = HomeViewController.initWithStoryboard()
                            self.present(controller, animated: true, completion: nil);
                        }else{
                            self.popupMsg(error: "UserId and Password isn't matched")
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
        
    
    func getProfilePhot(photoId: String){
        
        let utils = Utils()
        
        let urlLink = (PROFILE_PHOTO_URL+photoId)
        
        let url = URL(string: urlLink)!
//        guard let requestUrl = url else { fatalError() }
        
        print("-----Subroto-----\(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let itemModel = try JSONDecoder().decode(ProfilePhoto.self, from: data)
                        print("--unitEName----\(itemModel.unitEName)")
                        
                        utils.writeAnyData(key: "empName", value: itemModel.emP_ENAME)
                        utils.writeAnyData(key: "unitName", value: itemModel.unitEName)
                        
                        let photoArr = itemModel.serverFileName.components(separatedBy: "\\")
                        let photo = photoArr[1] //Last
                        
                        utils.writeAnyData(key: "photo", value: photo)
                        
                        let urlLinkPhoto = (PHOTO_LINK_URL+photo)
                        let photoUrl =  URL(string: urlLinkPhoto)!

                        if let data = try? Data(contentsOf: photoUrl) {
                                // Create Image and Update Image View
                            self.customerProfilePhoto.image = UIImage(data: data)
                            self.customerProfilePhoto.setRounded()
                            let skyBlueColor = UIColor(red: 104/255.0, green: 156/255.0, blue: 255/255.0, alpha: 1.0)
                            self.customerProfilePhoto.layer.borderWidth = 2.0
                            self.customerProfilePhoto.layer.borderColor = skyBlueColor.cgColor
                            }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    
    func pageNavigation(){
        
        let controller = HomeViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}

extension ViewController {
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
    
    func popupMsg(error:String){
        let alert = UIAlertController(title: "Error Message", message: error, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
 }

//extension UIViewController {
//  func toastMessage(_ message: String){
//    guard let window = UIApplication.shared.keyWindow else {return}
//    let messageLbl = UILabel()
//    messageLbl.text = message
//    messageLbl.textAlignment = .center
//    messageLbl.font = UIFont.systemFont(ofSize: 12)
//    messageLbl.textColor = .white
//    messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)
//
//    let textSize:CGSize = messageLbl.intrinsicContentSize
//    let labelWidth = min(textSize.width, window.frame.width - 40)
//
//    messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
//    messageLbl.center.x = window.center.x
//    messageLbl.layer.cornerRadius = messageLbl.frame.height/2
//    messageLbl.layer.masksToBounds = true
//    window.addSubview(messageLbl)
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//
//    UIView.animate(withDuration: 1, animations: {
//        messageLbl.alpha = 0
//    }) { (_) in
//        messageLbl.removeFromSuperview()
//    }
//    }
//}}

extension UIImageView {

   func setRounded() {
    let radius = 15.0
    self.layer.cornerRadius = CGFloat(radius)
    self.layer.masksToBounds = true
   }
    
    func setCornerRounded() {
     let radius = 40.0
     self.layer.cornerRadius = CGFloat(radius)
     self.layer.masksToBounds = true
    }
}
