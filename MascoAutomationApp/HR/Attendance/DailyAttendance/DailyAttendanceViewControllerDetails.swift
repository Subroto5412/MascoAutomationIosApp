//
//  DailyAttendanceViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 5/12/21.
//

import UIKit

class DailyAttendanceViewControllerDetails: UIViewController {

    @IBOutlet weak var tableViewDailyAttendance: UITableView!
    @IBOutlet weak var monthBgView: UIView!
    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var financialYearSelect: UIButton!
    @IBOutlet weak var yearBgView: UIView!
    
    @IBOutlet weak var leaveCountCollectionView: UICollectionView!
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [ListFinalYear]()
    var dataSourceAttendanceDetails = [ListAttendanceDetails]()
    var dataSourceLeaveCount = [ListLeaveCount]()
    
    var totalHeight: Int = 0
    
    var vSpinner : UIView?
    
    class func initWithStoryboard() -> DailyAttendanceViewControllerDetails
    {
        let storyboard = UIStoryboard(name: "DailyAttendance", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: DailyAttendanceViewControllerDetails.className) as! DailyAttendanceViewControllerDetails
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tableViewDailyAttendance.register(UINib(nibName: "DailyAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "cell_daily_attendance")

        tableViewDailyAttendance.delegate = self
        tableViewDailyAttendance.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        self.monthBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.monthBgView.layer.borderWidth = 0.5
        self.monthBgView.layer.cornerRadius = 15
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
        
        let headerViewSize = self.headerView.frame.size.height
        let taxYearViewSize = self.yearBgView.frame.size.height/1.5
        totalHeight = Int(headerViewSize+taxYearViewSize)
        getFinancialYearList()
       
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+CGFloat(totalHeight), width: frames.width+100, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5+CGFloat(self.totalHeight), width: frames.width+100, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+CGFloat(self.totalHeight), width: frames.width+100, height: 0)
        }, completion: nil)
    }
    
    func getFinancialYearList(){
        
        let url = URL(string: YEAR_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
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
                        let finalYearItemModel = try JSONDecoder().decode(ListFinalYearResponse.self, from: data)
                        self.dataSource = finalYearItemModel._listFinalYear
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
        self.getAttendanceDetailsList(FromDate: "2021-09-01", ToDate: "2021-09-30")
    }
    
    
    func getAttendanceDetailsList(FromDate: String, ToDate: String){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")

        let url = URL(string: ATTENDANCE_DETAILS_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        let newItem = AttendanceDetailsRequest(fromDate: FromDate, toDate: ToDate)
        let jsonData = try? JSONEncoder().encode(newItem)
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
                        let ItemModel = try JSONDecoder().decode(ListAttendanceDetailsResponse.self, from: data)
                        self.dataSourceAttendanceDetails = ItemModel._attHistoryListStr
                        self.tableViewDailyAttendance.reloadData()
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
        self.getLeaveCountList(FromDate: FromDate, ToDate: ToDate)
    }
    
    
    func getLeaveCountList(FromDate: String, ToDate: String){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        let url = URL(string: LEAVE_COUNT_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        let newItem = AttendanceDetailsRequest(fromDate: FromDate, toDate: ToDate)
        let jsonData = try? JSONEncoder().encode(newItem)
        
        request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

                DispatchQueue.main.async {
                
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let ItemModel = try JSONDecoder().decode(ListLeaveCountResponse.self, from: data)
                        self.dataSourceLeaveCount = ItemModel._listLeaveCount
                        self.leaveCountCollectionView.reloadData()
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    @IBAction func financialYearBtn(_ sender: Any) {
        
        selectedButton = financialYearSelect
        addTransparentView(frames: financialYearSelect.frame)
    }
    
    func showBackController(){
        let controller = DailyAttendanceViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}

extension DailyAttendanceViewControllerDetails : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewDailyAttendance {
        }else{
            selectedButton.setTitle(dataSource[indexPath.row].finalYearName, for: .normal)
            print("Final Year id: \(dataSource[indexPath.row].finalYearNo!)")
            removeTransparentView()
        }
    }
}

extension DailyAttendanceViewControllerDetails : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewDailyAttendance {
            return dataSourceAttendanceDetails.count
        }else{
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewDailyAttendance {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_daily_attendance", for: indexPath) as! DailyAttendanceTableViewCell
            cell.punchInLbl.text = dataSourceAttendanceDetails[indexPath.row].punchInTime
            cell.punchOutLbl.text = dataSourceAttendanceDetails[indexPath.row].punchOutTime
            cell.statusLbl.text = dataSourceAttendanceDetails[indexPath.row].fSts
            cell.otLbl.text = dataSourceAttendanceDetails[indexPath.row].additionalTime
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row].finalYearName
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewDailyAttendance {
            return 110
        }else{
            return 50
        }
    }
}

extension DailyAttendanceViewControllerDetails : UICollectionViewDelegate {
}

extension DailyAttendanceViewControllerDetails : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceLeaveCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! LeaveStatusCollectionViewCell
        cell.statusNameLbl.text = dataSourceLeaveCount[indexPath.row].status
        cell.starusValueLbl.text = dataSourceLeaveCount[indexPath.row].statusValue
        return cell
    }
}

extension DailyAttendanceViewControllerDetails : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 58)
    }
}


extension DailyAttendanceViewControllerDetails {
  
    struct ListFinalYear: Codable {
        var finalYearNo: Int?
        var finalYearName: String = ""
        var yearName: String = ""
        
        enum CodingKeys: String, CodingKey {
            case finalYearNo = "finalYearNo"
            case finalYearName = "finalYearName"
            case yearName = "yearName"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.finalYearNo = try container.decodeIfPresent(Int.self, forKey: .finalYearNo) ?? 0
               self.finalYearName = try container.decodeIfPresent(String.self, forKey: .finalYearName) ?? ""
               self.yearName = try container.decodeIfPresent(String.self, forKey: .yearName) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(finalYearNo, forKey: .finalYearNo)
               try container.encode(finalYearName, forKey: .finalYearName)
               try container.encode(yearName, forKey: .yearName)
           }
    }
    
    struct ListFinalYearResponse: Codable {
        var error: String = ""
        var _listFinalYear : [ListFinalYear]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _listFinalYear
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._listFinalYear = try container.decodeIfPresent([ListFinalYear].self, forKey: ._listFinalYear) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_listFinalYear, forKey: ._listFinalYear)
            }
    }
   
}

extension DailyAttendanceViewControllerDetails {
    
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
       } }


extension DailyAttendanceViewControllerDetails {
    
    //-------Daily Attendance Data--------
    
    struct AttendanceDetailsRequest: Codable {
        var fromDate: String
        var toDate: String
        
        enum CodingKeys: String, CodingKey {
            case fromDate = "fromDate"
            case toDate = "toDate"
        }
    }
    
    struct ListAttendanceDetails: Codable {
        var datePunch: String = ""
        var shiftInTime: String = ""
        var shiftOutTime: String = ""
        var shiftLateTime: String = ""
        var punchInTime: String = ""
        var punchOutTime: String = ""
        var shiftName: String = ""
        var lateTime: String = ""
        var additionalTime: String = ""
        var fSts: String = ""
        
        enum CodingKeys: String, CodingKey {
            case datePunch = "datePunch"
            case shiftInTime = "shiftInTime"
            case shiftOutTime = "shiftOutTime"
            case shiftLateTime = "shiftLateTime"
            case punchInTime = "punchInTime"
            case punchOutTime = "punchOutTime"
            case shiftName = "shiftName"
            case lateTime = "lateTime"
            case additionalTime = "additionalTime"
            case fSts = "fSts"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.datePunch = try container.decodeIfPresent(String.self, forKey: .datePunch) ?? ""
            self.shiftInTime = try container.decodeIfPresent(String.self, forKey: .shiftInTime) ?? ""
            self.shiftOutTime = try container.decodeIfPresent(String.self, forKey: .shiftOutTime) ?? ""
            self.shiftLateTime = try container.decodeIfPresent(String.self, forKey: .shiftLateTime) ?? ""
            self.punchInTime = try container.decodeIfPresent(String.self, forKey: .punchInTime) ?? ""
            self.punchOutTime = try container.decodeIfPresent(String.self, forKey: .punchOutTime) ?? ""
            self.shiftName = try container.decodeIfPresent(String.self, forKey: .shiftName) ?? ""
            self.lateTime = try container.decodeIfPresent(String.self, forKey: .lateTime) ?? ""
            self.additionalTime = try container.decodeIfPresent(String.self, forKey: .additionalTime) ?? ""
            self.fSts = try container.decodeIfPresent(String.self, forKey: .fSts) ?? ""
            
        }

           func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(datePunch, forKey: .datePunch)
            try container.encode(shiftInTime, forKey: .shiftInTime)
            try container.encode(shiftOutTime, forKey: .shiftOutTime)
            try container.encode(shiftLateTime, forKey: .shiftLateTime)
            try container.encode(punchInTime, forKey: .punchInTime)
            try container.encode(punchOutTime, forKey: .punchOutTime)
            try container.encode(shiftName, forKey: .shiftName)
            try container.encode(lateTime, forKey: .lateTime)
            try container.encode(additionalTime, forKey: .additionalTime)
            try container.encode(fSts, forKey: .fSts)
        }
    }
    
    struct ListAttendanceDetailsResponse: Codable {
        var error: String = ""
        var _attHistoryListStr : [ListAttendanceDetails]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _attHistoryListStr
        }
        
         init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._attHistoryListStr = try container.decodeIfPresent([ListAttendanceDetails].self, forKey: ._attHistoryListStr) ?? []
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_attHistoryListStr, forKey: ._attHistoryListStr)
            }
    }
    
    struct ListLeaveCount: Codable {
        var status: String = ""
        var statusValue: String = ""
        
        enum CodingKeys: String, CodingKey {
            case status = "status"
            case statusValue = "statusValue"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
            self.statusValue = try container.decodeIfPresent(String.self, forKey: .statusValue) ?? ""
           }

           func encode(to encoder: Encoder) throws {
               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(status, forKey: .status)
               try container.encode(statusValue, forKey: .statusValue)
           }
    }
    
    struct ListLeaveCountResponse: Codable {
        var error: String = ""
        var _listLeaveCount : [ListLeaveCount]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _listLeaveCount
        }
        
         init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._listLeaveCount = try container.decodeIfPresent([ListLeaveCount].self, forKey: ._listLeaveCount) ?? []
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_listLeaveCount, forKey: ._listLeaveCount)
            }
    }
}
