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
    
    var empCodeString = ""
    
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
            
            if let text = empId.text, text.isEmpty {
                self.toastMessage("Enter EmpId")
                print("--Enter EmpId--")
            } else if let text1 = password.text, text1.isEmpty {
                self.toastMessage("Enter password")
                print("--Enter password--")
            }else{
                let _empId: String = empId.text!
                let _password: String = password.text!
               
                self.userLogin(userId: _empId, password: _password)
            }
            
        }else{
            print("Not Connected")
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
        print("-----Subroto-----")
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
                            
                            print("todoItemModel -----: \(permission.moduleName)")
                            print("_subMenuList -----: \(permission._subMenuList)")
                            
                            for subMenuList in permission._subMenuList {
                                print("activityName -----: \(subMenuList.activityName)")
                            }
                        }
                        
                        if !self.empCodeString.isEmpty{
                            
                            self.dismiss(animated: true, completion: nil)
                        }
                      
                        if !self.empCodeString.isEmpty{
                            
                            let controller = HomeViewController.initWithStoryboard()
                            self.present(controller, animated: true, completion: nil);
                           
                            print("----error: \("Success")----")
                        }else{
                                print("----error: \(todoItemModel.error)----")
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
                        print("--emP_ENAME----\(itemModel.emP_ENAME)")
                        
                        utils.writeAnyData(key: "empName", value: itemModel.emP_ENAME)
                        
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

extension ViewController{
    
    struct ToDoRequestModel: Codable {
        var empId: String
        var password: String
        
        enum CodingKeys: String, CodingKey {
            case empId = "empId"
            case password = "password"
        }
    }
    
    struct LoginResponse: Codable {
        var empCode: String = ""
        var mobile: String = ""
        var empId: Int?
        var token: String  = ""
        var refresh_token: String  = ""
        var error: String = ""
        var _permissionList : [PermissionList]

        enum CodingKeys: String, CodingKey {
            case empCode = "empCode"
            case mobile = "mobile"
            case empId = "empId"
            case token = "token"
            case refresh_token = "refresh_token"
            case error = "error"
            case _permissionList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.empCode = try container.decodeIfPresent(String.self, forKey: .empCode) ?? ""
                self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
                self.empId = try container.decodeIfPresent(Int.self, forKey: .empId) ?? 0
                self.token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
                self.refresh_token = try container.decodeIfPresent(String.self, forKey: .refresh_token) ?? ""
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            
               self._permissionList = try container.decodeIfPresent([PermissionList].self, forKey: ._permissionList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(empCode, forKey: .empCode)
                try container.encode(mobile, forKey: .mobile)
                try container.encode(empId, forKey: .empId)
                try container.encode(token, forKey: .token)
                try container.encode(refresh_token, forKey: .refresh_token)
                try container.encode(error, forKey: .error)
                try container.encode(_permissionList, forKey: ._permissionList)
            }

    }
    //
    struct PermissionList: Codable {
        var moduleName: String = ""
        var _subMenuList: [SubMenuList]
        
        enum CodingKeys: String, CodingKey {
            case moduleName = "moduleName"
            case _subMenuList
            
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.moduleName = try container.decodeIfPresent(String.self, forKey: .moduleName) ?? ""
              self._subMenuList = try container.decodeIfPresent([SubMenuList].self, forKey: ._subMenuList) ?? []
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(moduleName, forKey: .moduleName)
              try container.encode(_subMenuList, forKey: ._subMenuList)
           }
    }

    struct SubMenuList: Codable {
        var activityName: String = ""
        var manuId: Int = 0
        var manuStepId: Int = 0
        var parantManuId: Int = 0
        var _specialPermission: String = ""
        
        enum CodingKeys: String, CodingKey {
            case activityName = "activityName"
            case manuId = "manuId"
            case manuStepId = "manuStepId"
            case parantManuId = "parantManuId"
            case _specialPermission = "_specialPermission"
            
        }
        
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.activityName = try container.decodeIfPresent(String.self, forKey: .activityName) ?? ""
               self.manuId = try container.decodeIfPresent(Int.self, forKey: .manuId) ?? 0
               self.manuStepId = try container.decodeIfPresent(Int.self, forKey: .manuStepId) ?? 0
               self.parantManuId = try container.decodeIfPresent(Int.self, forKey: .parantManuId) ?? 0
               self._specialPermission = try container.decodeIfPresent(String.self, forKey: ._specialPermission) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(activityName, forKey: .activityName)
           }
        
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

extension ViewController {
  
    struct ProfilePhoto: Codable {

        var serverFileName: String = ""
        var unitEName: String = ""
        var emP_ENAME: String = ""
        var error: String = ""
        
        enum CodingKeys: String, CodingKey {
            case serverFileName = "serverFileName"
            case unitEName = "unitEName"
            case emP_ENAME = "emP_ENAME"
            case error = "error"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.serverFileName = try container.decodeIfPresent(String.self, forKey: .serverFileName) ?? ""
               self.unitEName = try container.decodeIfPresent(String.self, forKey: .unitEName) ?? ""
               self.emP_ENAME = try container.decodeIfPresent(String.self, forKey: .emP_ENAME) ?? ""
               self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(serverFileName, forKey: .serverFileName)
               try container.encode(unitEName, forKey: .unitEName)
               try container.encode(emP_ENAME, forKey: .emP_ENAME)
               try container.encode(error, forKey: .error)
           }
    }
}

extension UIImageView {

   func setRounded() {
    let radius = 10.0
    self.layer.cornerRadius = CGFloat(radius)
    self.layer.masksToBounds = true
   }
    
    func setCornerRounded() {
     let radius = 40.0
     self.layer.cornerRadius = CGFloat(radius)
     self.layer.masksToBounds = true
    }
}
