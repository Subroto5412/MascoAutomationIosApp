//
//  LeaveApprovalDetailViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/12/21.
//

import UIKit

class LeaveApprovalDetailViewController: UIViewController, AlertDialogDelegate {

    @IBOutlet weak var leaveApprovalDetailsTableView: UITableView!
    @IBOutlet weak var approvalView: ApprovalBgView!
    @IBOutlet weak var headerView: CommonHeaderView!
    
    @IBOutlet weak var tableViewHeaderView: HeaderBarTableView!
    var vSpinner : UIView?
    
    var dataSource = [ListLeaveApproval]()
    var AllCheck:Bool = false
    var empCode: String = ""
    var index: Int = 0
    
    class func initWithStoryboard() -> LeaveApprovalDetailViewController
    {
        let storyboard = UIStoryboard(name: "HRIS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LeaveApprovalDetailViewController.className) as! LeaveApprovalDetailViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Leave Approval Details"
        
        self.hideKeyboardWhenTappedAround()
        
        self.leaveApprovalDetailsTableView.register(UINib(nibName: "LeaveApprovalItemViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        leaveApprovalDetailsTableView.delegate = self
        leaveApprovalDetailsTableView.dataSource = self
        
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getLeaveApprovalDetails()
        }else{
            self.toastMessage("No Internet Connected!!")
        }
        
        self.approvalView.approvedBtnView.layer.cornerRadius = 20.0;
        self.approvalView.rejectBtnView.layer.cornerRadius = 20.0;
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
        
        self.tableViewHeaderView.allCheckingBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showAllCheckingController()
        }
        
        self.approvalView.approvedBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
            if InternetConnectionManager.isConnectedToNetwork(){
                weakSelf.submitLeaveApproval()
            }else{
                self?.toastMessage("No Internet Connected!!")
            }
        }
        
        self.approvalView.rejectedBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
            if InternetConnectionManager.isConnectedToNetwork(){
                weakSelf.submitLeaveReject()
            }else{
                self?.toastMessage("No Internet Connected!!")
            }
        }
    }
    
    func showBackController(){
        let controller = LeaveApprovalViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    
    func getApplyDays(fromDate:String, toDate: String)->String{
        
        let calendar = Calendar.current

//        let start = self!.fromDate
//        let end = self!.toDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"

        let firstDate = dateFormatter.date(from: fromDate)!
        let secondDate = dateFormatter.date(from: toDate)!

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: firstDate)
        let date2 = calendar.startOfDay(for: secondDate)

        let components = calendar.dateComponents([Calendar.Component.day], from: date1, to: date2)
        
        let totalApplyDay = components.day!+1
        
        return "\(totalApplyDay)"
    }
    func showAllCheckingController(){
      
        let dataSourceLength:Int = Int(dataSource.count)
        if AllCheck == false {
            for index in 0...dataSourceLength-1 {
            self.dataSource[index].check = true
            self.tableViewHeaderView.allCheckingBtn.setImage(UIImage(named: "checking"), for: UIControl.State.normal)
                AllCheck = true
            }
        }else{
            for index in 0...dataSourceLength-1 {
            self.dataSource[index].check = false
            self.tableViewHeaderView.allCheckingBtn.setImage(UIImage(named: "not_checking"), for: UIControl.State.normal)
                AllCheck = false
            }
        }
       
//        for index in 0...dataSourceLength-1 {
//
//            if dataSource[index].check == !false {
//                self.dataSource[index].check = false
//                self.tableViewHeaderView.allCheckingBtn.setImage(UIImage(named: "not_checking"), for: UIControl.State.normal)
//            }else {
//                 self.dataSource[index].check = true
//                 self.tableViewHeaderView.allCheckingBtn.setImage(UIImage(named: "checking"), for: UIControl.State.normal)
//            }
//        }
        self.leaveApprovalDetailsTableView.reloadData()
    }
    
    func getLeaveApprovalDetails(){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        let empCode = utils.readStringData(key: "empCode")
        
        let url = URL(string: LEAVE_APPROVAL_PENDING_LIST_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let newTodoItem = LeaveApprovalPendingRequest(recommPersNo: Int(empCode), responsiblePersNo: Int(empCode))
        let jsonData = try? JSONEncoder().encode(newTodoItem)
        
        request.httpBody = jsonData

        print("jsonData jsonData  data:\n \(jsonData!)")
      //  self.showLoading(finished: {
        self.showSpinner(onView: self.view)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                self.removeSpinner()
                DispatchQueue.main.async {
                    
             //       self.hideLoading(finished: {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let itemModel = try JSONDecoder().decode(ListLeaveApprovalPendingResponse.self, from: data)
                        self.dataSource = itemModel._leavePendingList
                        
                        self.leaveApprovalDetailsTableView.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                 //   })
                }
        }
        task.resume()
     //   })
    }
    
    func submitLeaveApproval(){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        let url = URL(string: LEAVE_APPROVE_LIST_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        var arrayList = [LeaveApproveList]()
        
        for index in dataSource {
            
            if index.check == true {
                arrayList.append(LeaveApproveList(ApplyDays:index.applyDays, ApplyNo: index.applyNo!, ApproveFromDate: index.applyFromDate, ApproveToDate: index.applyToDate, EMP_CODE: index.emP_CODE, LeaveNo: index.leaveNo!))
            }
        }
        
        print(arrayList)
        
        let newTodoItem = LeaveApproveListRequest(approveList:arrayList)
        let jsonData = try? JSONEncoder().encode(newTodoItem)

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
                        
                        let itemModel = try JSONDecoder().decode(LeaveApproveResponse.self, from: data)
                        
                        if itemModel.response!{
                            self.toastMessage("Successfully Leave Approve!!")
                            let controller = LeaveApprovalViewController.initWithStoryboard()
                            self.present(controller, animated: true, completion: nil);
                            print("Successfully Leave Approve!!")
                        }
                        self.leaveApprovalDetailsTableView.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                    })
                }
        }
        task.resume()
        })
    }
    
    func submitLeaveReject(){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        let url = URL(string: LEAVE_REJECT_LIST_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        var arrayListReject = [LeaveRejectList]()
        
        for index in dataSource {
            
            if index.check == true {
                let applyNo = index.applyNo!
                print(LeaveRejectList(ApplyNo: applyNo))
                arrayListReject.append(LeaveRejectList(ApplyNo: applyNo))
            }
        }
        
        let newTodoItem = LeaveRejectListRequest(leaveRejectList:arrayListReject, ActionBy: utils.readStringData(key: "empName"))
        print(newTodoItem)
        let jsonData = try? JSONEncoder().encode(newTodoItem)

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
                        
                        let itemModel = try JSONDecoder().decode(LeaveRejectResponse.self, from: data)
                        
                        if itemModel.response!{
                            self.toastMessage("Successfully Reject Approve!!")
                            let controller = LeaveApprovalViewController.initWithStoryboard()
                            self.present(controller, animated: true, completion: nil);
                            print("Successfully Reject Approve!!")
                        }
                        self.leaveApprovalDetailsTableView.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                    })
                }
        }
        task.resume()
        })
    }
    
    func updateBtnTapped(from: String, to: String) {

        for item in self.dataSource {
          
            if item.emP_CODE == self.dataSource[index].emP_CODE {
                
                self.dataSource[index].applyFromDate = from
                self.dataSource[index].applyToDate = to
            }
        }

        self.leaveApprovalDetailsTableView.reloadData()
    }
    
    func fromDate(from :String){
     
    }
}

extension LeaveApprovalDetailViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        empCode = dataSource[indexPath.row].emP_CODE
    }
}


extension LeaveApprovalDetailViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaveApprovalItemViewCell
        cell.idLbl.text = dataSource[indexPath.row].emP_CODE
        cell.nameLbl.text = dataSource[indexPath.row].emP_ENAME
        cell.designationLbl.text = dataSource[indexPath.row].desigEName
    
        cell.fromDateLbl.text = dataSource[indexPath.row].applyFromDate
        cell.toDateLbl.text = dataSource[indexPath.row].applyToDate
        cell.leaveLbl.text = dataSource[indexPath.row].leaveType
        cell.balanceLbl.text = "Bl-\(String(describing: dataSource[indexPath.row].leaveMax!)) day"
//        cell.totalDaysLbl.text = "AP-\(String(describing: dataSource[indexPath.row].leaveNo!))"
        cell.totalDaysLbl.text = "AP-\(getApplyDays(fromDate:dataSource[indexPath.row].applyFromDate, toDate: dataSource[indexPath.row].applyToDate)) day"
        
        if dataSource[indexPath.row].check == true{
            cell.checkingBtn.setImage(UIImage(named: "checking"), for: UIControl.State.normal)
        }else{
            cell.checkingBtn.setImage(UIImage(named: "not_checking"), for: UIControl.State.normal)
        }
        
        cell.checkBtnPressed = {
            if self.dataSource[indexPath.row].check == !false {
                cell.checkingBtn.setImage(UIImage(named: "not_checking"), for: UIControl.State.normal)
                self.dataSource[indexPath.row].check = false
            }else{
                cell.checkingBtn.setImage(UIImage(named: "checking"), for: UIControl.State.normal)
                self.dataSource[indexPath.row].check = true
            }
        }
        
        cell.dateUpdateBtnPressed = {
            
            self.index = indexPath.row
            _fromDate = self.dataSource[indexPath.row].applyFromDate
            _toDate = self.dataSource[indexPath.row].applyToDate
            
            let alertDialog = self.storyboard?.instantiateViewController(identifier: "AlertDialogViewController") as! AlertDialogViewController
            alertDialog.delegate = self
            alertDialog.modalPresentationStyle = .overCurrentContext
            alertDialog.providesPresentationContextTransitionStyle = true
            alertDialog.definesPresentationContext = true
            alertDialog.modalTransitionStyle = .crossDissolve
            
           
            self.present(alertDialog, animated: true, completion: nil);
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


extension LeaveApprovalDetailViewController {
    
    struct LeaveApprovalPendingRequest: Codable {
        var recommPersNo: Int?
        var responsiblePersNo: Int?
        
        enum CodingKeys: String, CodingKey {
            case recommPersNo = "recommPersNo"
            case responsiblePersNo = "responsiblePersNo"
        }
    }
    struct ListLeaveApproval: Codable {
        var applyNo: Int?
        var emP_CODE: String = ""
        var emP_ENAME: String = ""
        var desigEName: String = ""
        var applyFromDate: String = ""
        var applyToDate: String = ""
        var applyDays: String = ""
        var leaveNo: Int?
        var leaveType: String = ""
        var leaveMax: Int?
        var leaveAvail: Int?
        var check: Bool
        
        enum CodingKeys: String, CodingKey {
            case applyNo = "applyNo"
            case emP_CODE = "emP_CODE"
            case emP_ENAME = "emP_ENAME"
            case desigEName = "desigEName"
            case applyFromDate = "applyFromDate"
            case applyToDate = "applyToDate"
            case applyDays = "applyDays"
            case leaveNo = "leaveNo"
            case leaveType = "leaveType"
            case leaveMax = "leaveMax"
            case leaveAvail = "leaveAvail"
            case check = "check"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.applyNo = try container.decodeIfPresent(Int.self, forKey: .applyNo) ?? 0
               self.emP_CODE = try container.decodeIfPresent(String.self, forKey: .emP_CODE) ?? ""
               self.emP_ENAME = try container.decodeIfPresent(String.self, forKey: .emP_ENAME) ?? ""
               self.desigEName = try container.decodeIfPresent(String.self, forKey: .desigEName) ?? ""
               self.applyFromDate = try container.decodeIfPresent(String.self, forKey: .applyFromDate) ?? ""
               self.applyToDate = try container.decodeIfPresent(String.self, forKey: .applyToDate) ?? ""
               self.applyDays = try container.decodeIfPresent(String.self, forKey: .applyDays) ?? ""
               self.leaveNo = try container.decodeIfPresent(Int.self, forKey: .leaveNo) ?? 0
               self.leaveType = try container.decodeIfPresent(String.self, forKey: .leaveType) ?? ""
               self.leaveMax = try container.decodeIfPresent(Int.self, forKey: .leaveMax) ?? 0
               self.leaveAvail = try container.decodeIfPresent(Int.self, forKey: .leaveAvail) ?? 0
               self.check = false
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(applyNo, forKey: .applyNo)
               try container.encode(emP_CODE, forKey: .emP_CODE)
               try container.encode(emP_ENAME, forKey: .emP_ENAME)
               try container.encode(desigEName, forKey: .desigEName)
               try container.encode(applyFromDate, forKey: .applyFromDate)
               try container.encode(applyToDate, forKey: .applyToDate)
               try container.encode(applyDays, forKey: .applyDays)
               try container.encode(leaveNo, forKey: .leaveNo)
               try container.encode(leaveType, forKey: .leaveType)
               try container.encode(leaveAvail, forKey: .leaveAvail)
               try container.encode(check, forKey: .check)
           }
    }
    
    struct ListLeaveApprovalPendingResponse: Codable {
        var error: String = ""
        var _leavePendingList : [ListLeaveApproval]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _leavePendingList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._leavePendingList = try container.decodeIfPresent([ListLeaveApproval].self, forKey: ._leavePendingList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_leavePendingList, forKey: ._leavePendingList)
            }
    }
}

extension LeaveApprovalDetailViewController {

    struct LeaveApproveList: Codable {
        var ApplyDays: String = ""
        var ApplyNo: Int?
        var ApproveFromDate: String = ""
        var ApproveToDate: String = ""
        var EMP_CODE: String = ""
        var LeaveNo: Int?
        
        enum CodingKeys: String, CodingKey {
            case ApplyDays = "ApplyDays"
            case ApplyNo = "ApplyNo"
            case ApproveFromDate = "ApproveFromDate"
            case ApproveToDate = "ApproveToDate"
            case EMP_CODE = "EMP_CODE"
            case LeaveNo = "LeaveNo"
    
        }
    }
    
    struct LeaveApproveListRequest: Codable {
        var approveList : [LeaveApproveList]
        
        enum CodingKeys: String, CodingKey {
            case approveList
        }
        
    }
        
    struct LeaveApproveResponse: Codable {
        var response: Bool?
        var error: String = ""
       

        enum CodingKeys: String, CodingKey {
            case response = "response"
            case error = "error"
           
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.response = try container.decodeIfPresent(Bool.self, forKey: .response)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
               
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(response, forKey: .response)
                try container.encode(error, forKey: .error)
             
            }
    }
}


extension LeaveApprovalDetailViewController {

    struct LeaveRejectList: Codable {
        var ApplyNo: Int?
        
        enum CodingKeys: String, CodingKey {
            case ApplyNo = "ApplyNo"
        }
    }
    
    struct LeaveRejectListRequest: Codable {
        var leaveRejectList : [LeaveRejectList]
        var ActionBy:String = ""
        
        
        enum CodingKeys: String, CodingKey {
            case leaveRejectList
            case ActionBy = "ActionBy"
        }
        
    }
        
    struct LeaveRejectResponse: Codable {
        var response: Bool?
        var error: String = ""
       

        enum CodingKeys: String, CodingKey {
            case response = "response"
            case error = "error"
           
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.response = try container.decodeIfPresent(Bool.self, forKey: .response)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
               
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(response, forKey: .response)
                try container.encode(error, forKey: .error)
             
            }
    }
}

extension LeaveApprovalDetailViewController {
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

extension LeaveApprovalDetailViewController {
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
