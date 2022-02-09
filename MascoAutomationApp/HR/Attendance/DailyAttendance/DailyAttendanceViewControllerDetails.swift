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
    @IBOutlet weak var backMonthIm: UIImageView!
    @IBOutlet weak var nextMonthIm: UIImageView!
    
    @IBOutlet weak var backMonthLbl: UILabel!
    @IBOutlet weak var nextMonthLbl: UILabel!
    @IBOutlet weak var selectedMonthLbl: UILabel!
    
    @IBOutlet weak var leaveCountCollectionView: UICollectionView!
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var yearName:String = ""
    
    var dataSource = [ListFinalYear]()
    var monthList = [String]()
    
    var dataSourceAttendanceDetails = [AttendanceDetails]()
    var dataSourceLeaveCount = [LeaveCount]()
    
    var totalHeight: Int = 0
    
    var vSpinner : UIView?
    var index:Int = 0
    var totalMonth: Int = 0
    var myMonth:Int = 0
    var myDay:Int = 0
    var myYear:Int = 0
    var formattedDate:String = ""
    
    class func initWithStoryboard() -> DailyAttendanceViewControllerDetails
    {
        let storyboard = UIStoryboard(name: "DailyAttendance", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: DailyAttendanceViewControllerDetails.className) as! DailyAttendanceViewControllerDetails
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.titleNameLbl.text = "Daily Attendance"
        self.hideKeyboardWhenTappedAround()
        
        self.tableViewDailyAttendance.register(UINib(nibName: "DailyAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "cell_daily_attendance")

        tableViewDailyAttendance.delegate = self
        tableViewDailyAttendance.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        self.monthBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.monthBgView.layer.borderWidth = 0.5
        self.monthBgView.layer.cornerRadius = 15
        
        self.yearBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.yearBgView.layer.borderWidth = 0.5
        self.yearBgView.layer.cornerRadius = 15
        
        monthList = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        
       let date = Date()
       let calendar = Calendar.current
       myYear =  calendar.component(.year, from: date)
       myMonth = calendar.component(.month, from: date)
       myDay = calendar.component(.day, from: date)
        
        print("---myMonth---\(myMonth-1)")
        print("---myMonth---\(monthList[myMonth].prefix(3))")
        
       let utils = Utils()
        formattedDate = utils.currentFormattedDate()
        
        if myMonth-1 < 1 {
            self.backMonthIm.isHidden = true
        }else{
            
            self.backMonthIm.isHidden = false
            let nextMonth = monthList[myMonth-2].prefix(3)
            self.backMonthLbl.text = String(nextMonth)
        }
        
        
        self.selectedMonthLbl.text = monthList[myMonth-1]
        let nextMonth = monthList[myMonth].prefix(3)
        self.nextMonthLbl.text = String(nextMonth)
        
        
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
        
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getFinancialYearList()
        }else{
            self.toastMessage("No Internet Connected!!")
        }
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
        
//        self.showSpinner(onView: self.view)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                self.removeSpinner()
                DispatchQueue.main.async {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let ItemModel = try JSONDecoder().decode(AttendanceDetailsResponse.self, from: data)
                        self.dataSourceAttendanceDetails = ItemModel._attHistoryListStr
                        self.tableViewDailyAttendance.reloadData()
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
        
//        self.removeSpinner()
        
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getLeaveCountList(FromDate: FromDate, ToDate: ToDate)
        }else{
            self.toastMessage("No Internet Connected!!")
        }
        
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
        
        
        let newItem = LeaveCountRequest(fromDate: FromDate, toDate: ToDate)
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
                        let ItemModel = try JSONDecoder().decode(LeaveCountResponse.self, from: data)
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
    
    @IBAction func backMonthBtn(_ sender: Any) {
        
        let date = Date()
        let calendar = Calendar.current
        myDay = calendar.component(.day, from: date)
        
        if financialYearSelect.titleLabel?.text == "Select Financial Year" {
            toastMessage("Please Select Financial Year")
        }else{
            
            index = index - 1
            totalMonth = (myMonth-1) + index
            
            if totalMonth > -2 {
                
                if totalMonth == 0 {
                    let month = monthList[0]
                    let nextMonth = monthList[1]
                    
                    self.backMonthLbl.text = ""
                    self.selectedMonthLbl.text = month
                    
                    let nextMonth2 = nextMonth.prefix(3)
                    self.nextMonthLbl.text = String(nextMonth2)
                    self.backMonthIm.isHidden = true
                    self.nextMonthIm.isHidden = false
                    
                    
                }else{
                    var nextMonth:String = ""
                    var month:String = ""
                    var backMonth:String = ""
                    
                    if totalMonth == 9 {
                        month = monthList[totalMonth]
                        nextMonth = String(monthList[totalMonth + 1].prefix(3))
                        backMonth = String(monthList[totalMonth-1].prefix(3))
                        
                    }else{
                        month = monthList[totalMonth]
                        nextMonth = String(monthList[totalMonth + 1].prefix(3))
                        
                        if totalMonth == 0{
                            self.backMonthIm.isHidden = true
                            self.nextMonthIm.isHidden = false
                        }else{
                            backMonth = String(monthList[totalMonth-1].prefix(3))
                        }
                        self.nextMonthIm.isHidden = false
                    }
                   
                    if totalMonth == 0 {
                        self.backMonthLbl.text = ""
                    }else{
                        self.backMonthLbl.text = backMonth
                    }
                    
                    self.selectedMonthLbl.text = month
                    self.nextMonthLbl.text = nextMonth
                    
                }
            }
            
            let _month = monthList.firstIndex(where: {$0 == selectedMonthLbl.text})! + 1
            
            var month:String = ""
            
            if _month<10 {
                month = "0\(_month)"
            }else{
                month = "\(_month)"
            }
            
            if yearName ==  "\(myYear)"{
                
                if month == "\(myMonth)" {
                    
                    let day = myDay
                    let fromDate = "\(yearName)"+"-"+"\(month)"+"-"+"\("01")"
                    let toDate = "\(yearName)"+"-"+"\(month)"+"-"+"\(day)"
                
                    if InternetConnectionManager.isConnectedToNetwork(){
                        self.getAttendanceDetailsList(FromDate: fromDate, ToDate: toDate)
                    }else{
                        self.toastMessage("No Internet Connected!!")
                    }
                    
                }else
                {
                    
                    let fromDate = "\(yearName)"+"-"+"\(month)"+"-"+"\("01")"
                    let toDate = "\(yearName)"+"-"+"\(month)"+"-"+"\(howManyDayMonth(monthName: monthList[monthList.firstIndex(where: {$0 == selectedMonthLbl.text})!]))"
                
                    if InternetConnectionManager.isConnectedToNetwork(){
                        self.getAttendanceDetailsList(FromDate: fromDate, ToDate: toDate)
                    }else{
                        self.toastMessage("No Internet Connected!!")
                    }
                }
               
            }else{
                let fromDate = "\(yearName)"+"-"+"\(month)"+"-"+"\("01")"
                let toDate = "\(yearName)"+"-"+"\(month)"+"-"+"\(howManyDayMonth(monthName: monthList[monthList.firstIndex(where: {$0 == selectedMonthLbl.text})!]))"
            
                if InternetConnectionManager.isConnectedToNetwork(){
                    self.getAttendanceDetailsList(FromDate: fromDate, ToDate: toDate)
                }else{
                    self.toastMessage("No Internet Connected!!")
                }
            }
        }
    }
    
    @IBAction func nextMonthBtn(_ sender: Any) {
        
        if financialYearSelect.titleLabel?.text == "Select Financial Year" {
            toastMessage("Please Select Financial Year")
        }else{
            
            index = index+1
            totalMonth = (myMonth-2) + index
            
            if totalMonth < 12{
                if totalMonth == 10 {
                    let month = monthList[totalMonth+1]
                    let backMonth:String = String(monthList[totalMonth].prefix(3))
                    self.backMonthLbl.text = backMonth
                    self.selectedMonthLbl.text = month
                    self.nextMonthLbl.text = ""
                    self.totalMonth = totalMonth + 2
                    self.nextMonthIm.isHidden = true
                }else{
                    
                    let month = monthList[totalMonth+1]
                    let nextMonth:String = String(monthList[totalMonth + 2].prefix(3))
                    let backMonth:String = String(monthList[totalMonth].prefix(3))
                    
                    self.selectedMonthLbl.text = month
                    self.nextMonthLbl.text = nextMonth
                    self.backMonthLbl.text = backMonth
                    self.backMonthIm.isHidden = false
                }
            }
            
            let _month = monthList.firstIndex(where: {$0 == selectedMonthLbl.text})! + 1
            
            var month:String = ""
            
            if _month<10 {
                month = "0\(_month)"
            }else{
                month = "\(_month)"
            }
            
            if yearName ==  "\(myYear)"{

                if month == "\(myMonth)" {
                    
                    let day = myDay
                    let fromDate = "\(yearName)"+"-"+"\(month)"+"-"+"\("01")"
                    let toDate = "\(yearName)"+"-"+"\(month)"+"-"+"\(day)"
                
                    if InternetConnectionManager.isConnectedToNetwork(){
                        self.getAttendanceDetailsList(FromDate: fromDate, ToDate: toDate)
                    }else{
                        self.toastMessage("No Internet Connected!!")
                    }
                    
                }else
                {
                    
                    let fromDate = "\(yearName)"+"-"+"\(month)"+"-"+"\("01")"
                    let toDate = "\(yearName)"+"-"+"\(month)"+"-"+"\(howManyDayMonth(monthName: monthList[monthList.firstIndex(where: {$0 == selectedMonthLbl.text})!]))"
                
                    if InternetConnectionManager.isConnectedToNetwork(){
                        self.getAttendanceDetailsList(FromDate: fromDate, ToDate: toDate)
                    }else{
                        self.toastMessage("No Internet Connected!!")
                    }
                }
            
            }else{
//                let month = monthList.firstIndex(where: {$0 == selectedMonthLbl.text})! + 1
                let fromDate = "\(yearName)"+"-"+"\(month)"+"-"+"\("01")"
                let toDate = "\(yearName)"+"-"+"\(month)"+"-"+"\(howManyDayMonth(monthName: monthList[monthList.firstIndex(where: {$0 == selectedMonthLbl.text})!]))"
            
                if InternetConnectionManager.isConnectedToNetwork(){
                    self.getAttendanceDetailsList(FromDate: fromDate, ToDate: toDate)
                }else{
                    self.toastMessage("No Internet Connected!!")
                }
                
            }
        }
    }
    
    func howManyDayMonth(monthName:String)->String{
        var monthDay: String = ""
        if monthName == "January"{
            monthDay = "31"
        }
        else if monthName == "February"{
            monthDay = "28"
        }
        else if monthName == "March"{
            monthDay = "31"
        }
        else if monthName == "April"{
            monthDay = "30"
        }
        else if monthName == "May"{
            monthDay = "31"
        }else if monthName == "June"{
            monthDay = "30"
        }
        else if monthName == "July"{
            monthDay = "31"
        }
        else if monthName == "August"{
            monthDay = "31"
        }
        else if monthName == "September"{
            monthDay = "30"
        }
        else if monthName == "October"{
            monthDay = "31"
        }
        else if monthName == "November"{
            monthDay = "30"
        }
        else if monthName == "December"{
            monthDay = "31"
        }
        return monthDay
    }
}

extension DailyAttendanceViewControllerDetails : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewDailyAttendance {
        }else{
            selectedButton.setTitle(dataSource[indexPath.row].finalYearName, for: .normal)
            yearName = dataSource[indexPath.row].yearName
            print("Final Year id: \(dataSource[indexPath.row].finalYearNo!)")
            
            let _month = monthList.firstIndex(where: {$0 == selectedMonthLbl.text})! + 1
            
            var month:String = ""
            
            if _month<10 {
                month = "0\(_month)"
            }else{
                month = "\(_month)"
            }
            
            if yearName ==  "\(myYear)"{
//                let month = monthList.firstIndex(where: {$0 == selectedMonthLbl.text})! + 1
                if "\(myMonth-1)" == "\(month)"{
                    let day = myDay
                    let fromDate = "\(yearName)"+"-"+"\(month)"+"-"+"\("01")"
                    let toDate = "\(yearName)"+"-"+"\(month)"+"-"+"\(day)"
                
                    if InternetConnectionManager.isConnectedToNetwork(){
                        self.getAttendanceDetailsList(FromDate: fromDate, ToDate: toDate)
                    }else{
                        self.toastMessage("No Internet Connected!!")
                    }
                }else{
                    let fromDate = "\(yearName)"+"-"+"\(month)"+"-"+"\("01")"
                    let toDate = "\(yearName)"+"-"+"\(month)"+"-"+"\(howManyDayMonth(monthName: monthList[monthList.firstIndex(where: {$0 == selectedMonthLbl.text})!]))"
                
                    if InternetConnectionManager.isConnectedToNetwork(){
                        self.getAttendanceDetailsList(FromDate: fromDate, ToDate: toDate)
                    }else{
                        self.toastMessage("No Internet Connected!!")
                    }
                }
            }else{
//                let month = monthList.firstIndex(where: {$0 == selectedMonthLbl.text})! + 1
                let fromDate = "\(yearName)"+"-"+"\(month)"+"-"+"\("01")"
                let toDate = "\(yearName)"+"-"+"\(month)"+"-"+"\(howManyDayMonth(monthName: monthList[monthList.firstIndex(where: {$0 == selectedMonthLbl.text})!]))"
            
                if InternetConnectionManager.isConnectedToNetwork(){
                    self.getAttendanceDetailsList(FromDate: fromDate, ToDate: toDate)
                }else{
                    self.toastMessage("No Internet Connected!!")
                }
                
            }
            
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
            
            cell.setInformation(withItem: dataSourceAttendanceDetails[indexPath.row] as AttendanceDetails, formattedDate: formattedDate)
            cell.layoutIfNeeded()
            cell.setNeedsDisplay()
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
    

}
