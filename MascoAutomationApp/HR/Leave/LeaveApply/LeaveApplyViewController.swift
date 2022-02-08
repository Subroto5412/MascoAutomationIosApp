//
//  LeaveApplyViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 13/12/21.
//

import UIKit
import YYCalendar

class LeaveApplyViewController: UIViewController {
    
    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var bodyView: ApplyFormView!
    @IBOutlet weak var footerView: CommonFooter!
    
    let transparentView = UIView()
    let tableViewLeaveTypeDropDown = UITableView()
    
    var selectedButton = UIButton()
    var dataSource = [ListLeaveAvail]()
    var totalHeight:Int = 0
    var fromDate:String = ""
    var toDate:String = ""
    var leaveTypeId:Int = 0
    var vSpinner : UIView?
    class func initWithStoryboard() -> LeaveApplyViewController
    {
        let storyboard = UIStoryboard(name: "LeaveApply", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LeaveApplyViewController.className) as! LeaveApplyViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.titleNameLbl.text = "Leave Application Form"
        
        self.hideKeyboardWhenTappedAround()
        
        self.getLeaveFormData()
        
        let utils = Utils()
        
        let urlLinkPhoto = (PHOTO_LINK_URL+utils.readStringData(key: "photo"))
        let photoUrl =  URL(string: urlLinkPhoto)!

        if let data = try? Data(contentsOf: photoUrl) {
                // Create Image and Update Image View
            self.bodyView.profilePhotoImg.image = UIImage(data: data)
            self.self.bodyView.profilePhotoImg.setCornerRounded()
            let skyBlueColor = UIColor(red: 104/255.0, green: 156/255.0, blue: 255/255.0, alpha: 1.0)
            self.self.bodyView.profilePhotoImg.layer.borderWidth = 2.0
            self.self.bodyView.profilePhotoImg.layer.borderColor = skyBlueColor.cgColor
            }
        
        
        

        tableViewLeaveTypeDropDown.delegate = self
        tableViewLeaveTypeDropDown.dataSource = self
        tableViewLeaveTypeDropDown.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        self.bodyView.IdBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.IdBgView.layer.borderWidth = 0.5
        self.bodyView.IdBgView.layer.cornerRadius = 4
        
        self.bodyView.nameBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.nameBgView.layer.borderWidth = 0.5
        self.bodyView.nameBgView.layer.cornerRadius = 4
        
        self.bodyView.designationBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.designationBgView.layer.borderWidth = 0.5
        self.bodyView.designationBgView.layer.cornerRadius = 4
        
        self.bodyView.leaveTypeBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveTypeBgView.layer.borderWidth = 0.5
        self.bodyView.leaveTypeBgView.layer.cornerRadius = 4
        
        self.bodyView.leaveNoBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveNoBgView.layer.borderWidth = 0.5
        self.bodyView.leaveNoBgView.layer.cornerRadius = 4
        
        self.bodyView.leaveRequiredBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveRequiredBgView.layer.borderWidth = 0.5
        self.bodyView.leaveRequiredBgView.layer.cornerRadius = 4
        
        self.bodyView.leaveRequiredToBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.leaveRequiredToBgView.layer.borderWidth = 0.5
        self.bodyView.leaveRequiredToBgView.layer.cornerRadius = 4
        
        self.bodyView.totalDaysBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.totalDaysBgView.layer.borderWidth = 0.5
        self.bodyView.totalDaysBgView.layer.cornerRadius = 4
        
        self.bodyView.reasonBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.reasonBgView.layer.borderWidth = 0.5
        self.bodyView.reasonBgView.layer.cornerRadius = 4
        
        self.bodyView.saveBgView.layer.cornerRadius = 20
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
        
        self.bodyView.applyFromHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.applyFromDate()
        }
        
        self.bodyView.applyToHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.applyToDate()
        }
        
        self.bodyView.leaveTypeHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.leaveType()
        }
        
        self.bodyView.saveHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
            if let textReason = self?.bodyView.reasonBgView.text, textReason.isEmpty {
                self?.toastMessage("Enter Reason!!")
            } else if self!.bodyView.totalApplyDayLbl.text == "0"{
            self?.toastMessage("Enter Correct Date!!")
            } else{
            if InternetConnectionManager.isConnectedToNetwork(){
                weakSelf.leaveSubmit()
            }else{
                self?.toastMessage("No Internet Connected!!")
            }
           }
         
        }
        
        
        let leaveTypeBgSize = self.bodyView.IdBgView.frame.size.height + self.bodyView.nameBgView.frame.size.height + self.bodyView.designationBgView.frame.size.height + 25 + (self.bodyView.fullLeaveTypeBgView.frame.size.height*4)
      
        totalHeight = Int(leaveTypeBgSize)
        
    }
    

    func showBackController(){
        let controller = LeaveViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

    func applyFromDate() {
        
       let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let calendar = YYCalendar(normalCalendarLangType: .ENG3,
                                  date: dateFormatter.string(from: currentDate),
                                          format: "yyyy-MM-dd") { [weak self] date in
            self?.bodyView.applyFromDate.text = date
            self!.fromDate = date
            print(date)
            if self?.bodyView.ApplyToDate.text != "Leave Required" {
                
                let calendar = Calendar.current

                let start = self!.fromDate
                let end = self!.toDate
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"

                let firstDate = dateFormatter.date(from: start)!
                let secondDate = dateFormatter.date(from: end)!

                // Replace the hour (time) of both dates with 00:00
                let date1 = calendar.startOfDay(for: firstDate)
                let date2 = calendar.startOfDay(for: secondDate)

                let components = calendar.dateComponents([Calendar.Component.day], from: date1, to: date2)

                let totalApplyDay = components.day!+1
                
                if totalApplyDay > 0{
                    self?.bodyView.totalApplyDayLbl.text = "\(totalApplyDay)"
                }else{
                    self?.bodyView.totalApplyDayLbl.text = "0"
                    print("Please, Select Correct Date")
                }
            }
            
                }
        
        calendar.sundayColor = UIColor.gray
        calendar.defaultDayColor = UIColor.gray
        calendar.saturdayColor = UIColor.gray
        
        calendar.show()
        
    }
    
    func applyToDate() {
        
       let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let calendar = YYCalendar(normalCalendarLangType: .ENG3,
                                  date: dateFormatter.string(from: currentDate),
                                          format: "yyyy-MM-dd") { [weak self] date in
            self?.bodyView.ApplyToDate.text = date
            
            self!.toDate = date

            if self?.bodyView.applyFromDate.text != "Leave Required" {
                
                let calendar = Calendar.current

                let start = self!.fromDate
                let end = self!.toDate
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"

                let firstDate = dateFormatter.date(from: start)!
                let secondDate = dateFormatter.date(from: end)!

                // Replace the hour (time) of both dates with 00:00
                let date1 = calendar.startOfDay(for: firstDate)
                let date2 = calendar.startOfDay(for: secondDate)

                let components = calendar.dateComponents([Calendar.Component.day], from: date1, to: date2)
                
                let totalApplyDay = components.day!+1
                
                if totalApplyDay > 0{
                    self?.bodyView.totalApplyDayLbl.text = "\(totalApplyDay)"
                }else{
                    self?.bodyView.totalApplyDayLbl.text = "0"
                    print("Please, Select Correct Date")
                }
            }
      }
        
        calendar.sundayColor = UIColor.gray
        calendar.defaultDayColor = UIColor.gray
        calendar.saturdayColor = UIColor.gray
        
        calendar.show()
        
    }

    func leaveType() {
        selectedButton = bodyView.leaveTypeBtn
        addTransparentView(frames: bodyView.leaveTypeBtn.frame)
    }
    
    func getLeaveFormData(){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        let url = URL(string: FORM_DATA_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
    
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let itemModel = try JSONDecoder().decode(ListLeaveFormDataResponse.self, from: data)
                        self.dataSource = itemModel._leaveAvailList
                        
                        self.bodyView.IdBgView.text = itemModel.emp_details.emP_CODE
                        self.bodyView.nameBgView.text = itemModel.emp_details.emP_ENAME
                        self.bodyView.designationBgView.text = itemModel.emp_details.desigEName
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    
    func leaveSubmit(){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        let url = URL(string: LEAVE_SUBMIT_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let newTodoItem = LeaveSubmitRequest(apply_from: self.bodyView.applyFromDate.text!, apply_to: self.bodyView.ApplyToDate.text!, leave_days: Int(self.bodyView.totalApplyDayLbl.text!), leave_type: self.leaveTypeId, reason: self.bodyView.reasonBgView.text!)
        let jsonData = try? JSONEncoder().encode(newTodoItem)
        
        request.httpBody = jsonData

        self.showSpinner(onView: self.view)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                self.removeSpinner()
                DispatchQueue.main.async {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let itemModel = try JSONDecoder().decode(LeaveSubmitResponse.self, from: data)
                        
                        if itemModel.response == true{
                            
                            let alert = UIAlertController(title: "", message: "Leave Successfully Submitted!", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                                let controller = LeaveViewController.initWithStoryboard()
                                self.present(controller, animated: true, completion: nil);
                            }))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableViewLeaveTypeDropDown.frame = CGRect(x: frames.origin.x+10, y: frames.origin.y + frames.height+CGFloat(totalHeight), width: frames.width+40, height: 0)
        self.view.addSubview(tableViewLeaveTypeDropDown)
        tableViewLeaveTypeDropDown.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableViewLeaveTypeDropDown.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableViewLeaveTypeDropDown.frame = CGRect(x: frames.origin.x+10, y: frames.origin.y + frames.height + 5+CGFloat(self.totalHeight), width: frames.width+40, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableViewLeaveTypeDropDown.frame = CGRect(x: frames.origin.x+10, y: frames.origin.y + frames.height+CGFloat(self.totalHeight), width: frames.width+40, height: 0)
        }, completion: nil)
    }

}

extension LeaveApplyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].abbreviation
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row].abbreviation, for: .normal)
        let maxBalance:Double = Double(dataSource[indexPath.row].maxBalance)
        let avail:Double = Double(dataSource[indexPath.row].avail!)
        self.bodyView.leaveTypeValueLbl.text = "\(maxBalance - avail)"
        self.leaveTypeId = Int(dataSource[indexPath.row].leaveTypeNo!)
        removeTransparentView()
    }
}


extension LeaveApplyViewController {
    
    struct empDtails: Codable {
        
        var emP_CODE: String = ""
        var emP_ENAME: String = ""
        var doj: String = ""
        var deptEName: String = ""
        var sectEName: String = ""
        var desigEName: String = ""
        var unitEName: String = ""
        
        enum CodingKeys: String, CodingKey {
            case emP_CODE = "emP_CODE"
            case emP_ENAME = "emP_ENAME"
            case doj = "doj"
            case deptEName = "deptEName"
            case sectEName = "sectEName"
            case desigEName = "desigEName"
            case unitEName = "unitEName"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
                self.emP_CODE = try container.decodeIfPresent(String.self, forKey: .emP_CODE) ?? ""
                self.emP_ENAME = try container.decodeIfPresent(String.self, forKey: .emP_ENAME) ?? ""
                self.doj = try container.decodeIfPresent(String.self, forKey: .doj) ?? ""
                self.deptEName = try container.decodeIfPresent(String.self, forKey: .deptEName) ?? ""
                self.sectEName = try container.decodeIfPresent(String.self, forKey: .sectEName) ?? ""
                self.desigEName = try container.decodeIfPresent(String.self, forKey: .desigEName) ?? ""
                self.unitEName = try container.decodeIfPresent(String.self, forKey: .unitEName) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(emP_CODE, forKey: .emP_CODE)
                try container.encode(emP_ENAME, forKey: .emP_ENAME)
                try container.encode(doj, forKey: .doj)
                try container.encode(deptEName, forKey: .deptEName)
                try container.encode(sectEName, forKey: .sectEName)
                try container.encode(desigEName, forKey: .desigEName)
                try container.encode(unitEName, forKey: .unitEName)
           }
    }
    
  
    struct ListLeaveAvail: Codable {
        var leaveTypeNo: Int?
        var abbreviation: String = ""
        var maxBalance: Double = 0.0
        var avail: Int?
        
        enum CodingKeys: String, CodingKey {
            case leaveTypeNo = "leaveTypeNo"
            case abbreviation = "abbreviation"
            case maxBalance = "maxBalance"
            case avail = "avail"
        }
        
        init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.leaveTypeNo = try container.decodeIfPresent(Int.self, forKey: .leaveTypeNo) ?? 0
                self.abbreviation = try container.decodeIfPresent(String.self, forKey: .abbreviation) ?? ""
            self.maxBalance = try container.decodeIfPresent(Double.self, forKey: .maxBalance) ?? 0.0
                self.avail = try container.decodeIfPresent(Int.self, forKey: .avail) ?? 0
           }

           func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(leaveTypeNo, forKey: .leaveTypeNo)
                try container.encode(abbreviation, forKey: .abbreviation)
                try container.encode(maxBalance, forKey: .maxBalance)
                try container.encode(avail, forKey: .avail)
           }
    }
    
    struct ListLeaveFormDataResponse: Codable {
        var error: String = ""
        var emp_details : empDtails
        var _leaveAvailList : [ListLeaveAvail]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case emp_details
            case _leaveAvailList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self.emp_details = try container.decodeIfPresent(empDtails.self, forKey: .emp_details)!
                self._leaveAvailList = try container.decodeIfPresent([ListLeaveAvail].self, forKey: ._leaveAvailList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(emp_details, forKey: .emp_details)
                try container.encode(_leaveAvailList, forKey: ._leaveAvailList)
            }
    }
}

extension LeaveApplyViewController {
  
    struct LeaveSubmitRequest: Codable {
        var apply_from: String = ""
        var apply_to: String = ""
        var leave_days: Int?
        var leave_type: Int?
        var reason: String = ""
        
        enum CodingKeys: String, CodingKey {
            case apply_from = "apply_from"
            case apply_to = "apply_to"
            case leave_days = "leave_days"
            case leave_type = "leave_type"
            case reason = "reason"
        }
    }
    
    struct LeaveSubmitResponse: Codable {
        var error: String = ""
        var message: String = ""
        var response: Bool

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case message = "message"
            case response = "response"
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
            self.response = try container.decodeIfPresent(Bool.self, forKey: .response) ?? false
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(message, forKey: .message)
                try container.encode(response, forKey: .response)
            }
    }
}
extension LeaveApplyViewController {
    func showSpinner(onView : UIView) {
           let spinnerView = UIView.init(frame: onView.bounds)
           spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
           let ai = UIActivityIndicatorView.init(style: .whiteLarge)
           ai.startAnimating()
           ai.center = spinnerView.center
           
           DispatchQueue.main.async {
               spinnerView.addSubview(ai)
               onView.addSubview(spinnerView)
           }
           
           vSpinner = spinnerView
       }
       
       func removeSpinner() {
           DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
           }
       }
 }
