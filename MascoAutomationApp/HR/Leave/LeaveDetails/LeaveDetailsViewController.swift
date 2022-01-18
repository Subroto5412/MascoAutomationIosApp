//
//  LeaveDetailsViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 6/12/21.
//

import UIKit

class LeaveDetailsViewControllerCellClass: UITableViewCell {
}

class LeaveDetailsViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var footerView: CommonFooter!
    @IBOutlet weak var tableViewAvail: UITableView!
    @IBOutlet weak var leaveSummaryCollectionView: UICollectionView!
    
    @IBOutlet weak var financialBgView: UIView!
    @IBOutlet weak var leaveSummaryBgView: UIView!
    @IBOutlet weak var availSummaryBgView: UILabel!
    
    @IBOutlet weak var slBgView: UIView!
    @IBOutlet weak var leaveTypeBgView: UIView!
    @IBOutlet weak var availDayBgView: UIView!
    @IBOutlet weak var fromDateBgView: UIView!
    @IBOutlet weak var toDateBgView: UIView!
    @IBOutlet weak var applicationDateBgView: UIView!
    
    @IBOutlet weak var financialYear: UIButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var totalHeight:Int = 0
    var vSpinner : UIView?
    var dataSource = [ListFinalYear]()
    var dataSourceLeaveHistory = [LeaveHistoryformatList]()
    var dataSourceAvail = [AvailHistorySummaryList]()

    class func initWithStoryboard() -> LeaveDetailsViewController
    {
        let storyboard = UIStoryboard(name: "LeaveDetailsView", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LeaveDetailsViewController.className) as! LeaveDetailsViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Personal Leave Details"
        
        tableViewAvail.delegate = self
        tableViewAvail.dataSource = self
        self.tableViewAvail.register(UINib(nibName: "LeaveDetailsControllerCell", bundle: nil), forCellReuseIdentifier: "cell_avail")
        
        
        self.leaveSummaryCollectionView.register(UINib(nibName: "LeaveSummaryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "leave_summary_cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        evenHandler()
        viewDesign()
        
        let headerViewSize = self.headerView.frame.size.height
        let taxYearViewSize = self.financialBgView.frame.size.height/1.5
        totalHeight = Int(headerViewSize+taxYearViewSize)
       
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getYearList()
        }else{
            self.toastMessage("No Internet Connected!!")
        }
    }
    @IBAction func financialYearBtn(_ sender: Any) {
        
        selectedButton = financialYear
        addTransparentView(frames: financialYear.frame)
    
    }
    
    func showBackController(){
        let controller = LeaveViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func evenHandler() {
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    
    func viewDesign(){
        
        self.financialBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.financialBgView.layer.borderWidth = 0.5
        self.financialBgView.layer.cornerRadius = 15
        
        self.leaveSummaryBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.leaveSummaryBgView.layer.borderWidth = 0.5
        self.leaveSummaryBgView.layer.cornerRadius = 12
        
        self.availSummaryBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.availSummaryBgView.layer.borderWidth = 0.5
        self.availSummaryBgView.layer.cornerRadius = 12
        
        
        self.slBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.slBgView.layer.borderWidth = 0.5
        self.slBgView.layer.cornerRadius = 15
        
        self.leaveTypeBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.leaveTypeBgView.layer.borderWidth = 0.5
        self.leaveTypeBgView.layer.cornerRadius = 15
        
        
        self.availDayBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.availDayBgView.layer.borderWidth = 0.5
        self.availDayBgView.layer.cornerRadius = 15
        
        self.fromDateBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.fromDateBgView.layer.borderWidth = 0.5
        self.fromDateBgView.layer.cornerRadius = 15
        
        self.toDateBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.toDateBgView.layer.borderWidth = 0.5
        self.toDateBgView.layer.cornerRadius = 15
        
        self.applicationDateBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.applicationDateBgView.layer.borderWidth = 0.5
        self.applicationDateBgView.layer.cornerRadius = 15
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
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+CGFloat(self.totalHeight) + 5, width: frames.width+100, height: CGFloat(self.dataSource.count * 50))
           }, completion: nil)
       }
       
       @objc func removeTransparentView() {
           let frames = selectedButton.frame
           UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
               self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+CGFloat(self.totalHeight), width: frames.width+100, height: 0)
           }, completion: nil)
       }
    
    func getLeaveHistorySummary(finalYear:Int){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        
        let url = URL(string: LEAVE_HISTORY_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let newTodoItem = LeaveDetailRequestModel(finalYear: finalYear)
        let jsonData = try? JSONEncoder().encode(newTodoItem)
        
        request.httpBody = jsonData

        print("jsonData jsonData  data:\n \(jsonData!)")
       // indicator.startAnimating()
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                
                    
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        
                        let todoItemModel = try JSONDecoder().decode(LeaveDetailsResponse.self, from: data)
                        self.dataSourceLeaveHistory = todoItemModel._LeaveHistoryformatList
                        
                      
                        
                        for leaveHistoryformatList in todoItemModel._LeaveHistoryformatList {
                            
                            print("------type_name -----: \(leaveHistoryformatList.type_name)")
                            print("------cl -----: \(leaveHistoryformatList.cl)")
                            print("----sl -----: \(leaveHistoryformatList.sl)")
                            print("----el -----: \(leaveHistoryformatList.el)")
                            
                        }
                        
//                        if !self.empCodeString.isEmpty{
//                            let controller = HomeViewController.initWithStoryboard()
//                            self.present(controller, animated: true, completion: nil);
//                            print("----error: \("Success")----")
//                        }else{
//                                print("----error: \(todoItemModel.error)----")
//                        }
                        self.leaveSummaryCollectionView.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                //    self.indicator.stopAnimating()
                  //  self.indicator.isHidden = true
//                    self.getYearList()
                }
               
        }
     
        task.resume()
        getAvailHistorySummary(finalYear:finalYear)
       
    }

    
    func getAvailHistorySummary(finalYear:Int){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        
        let url = URL(string: AVAIL_HISTORY_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let newTodoItem = LeaveDetailRequestModel(finalYear: finalYear)
        let jsonData = try? JSONEncoder().encode(newTodoItem)
        
        request.httpBody = jsonData

        print("jsonData jsonData  data:\n \(jsonData!)")
       // indicator.startAnimating()
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
                        
                        let todoItemModel = try JSONDecoder().decode(AvailHistorySummaryResponse.self, from: data)
                        self.dataSourceAvail = todoItemModel._availHistoryList
                        self.tableViewAvail.reloadData()
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
     
        task.resume()
       
    }

func getYearList(){
    
    let url = URL(string: YEAR_URL)
    guard let requestUrl = url else { fatalError() }
    
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "GET"
    
    // Set HTTP Request Header
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
   // self.indicator.isHidden = false
    //indicator.startAnimating()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
            
                
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                guard let data = data else {return}

                do{
                    
                    let todoItemModel = try JSONDecoder().decode(ListFinalYearResponse.self, from: data)
                    self.dataSource = todoItemModel._listFinalYear
                    print("Response data:\n \(todoItemModel)")
                    print("todoItemModel error: \(todoItemModel.error)")
                    
                  
                    
                    for leaveHistoryformatList in todoItemModel._listFinalYear {
                        
                        print("------type_finalYearNamename -----: \(leaveHistoryformatList.finalYearName)")
                        print("------yearName -----: \(leaveHistoryformatList.yearName)")
                        print("----finalYearNo -----: \(leaveHistoryformatList.finalYearNo!)")
                       
                        
                    }
                    
//                        if !self.empCodeString.isEmpty{
//                            let controller = HomeViewController.initWithStoryboard()
//                            self.present(controller, animated: true, completion: nil);
//                            print("----error: \("Success")----")
//                        }else{
//                                print("----error: \(todoItemModel.error)----")
//                        }
                    
                }catch let jsonErr{
                    print(jsonErr)
               }
            //    self.indicator.isHidden = true
            //    self.indicator.stopAnimating()
            }
    }
 
    task.resume()
}
}

extension LeaveDetailsViewController{
    
    struct LeaveDetailRequestModel: Codable {
        var finalYear: Int
        
        enum CodingKeys: String, CodingKey {
            case finalYear = "finalYear"
        }
    }
    
    struct LeaveDetailsResponse: Codable {
        var error: String = ""
        var _LeaveHistoryformatList : [LeaveHistoryformatList]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _LeaveHistoryformatList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._LeaveHistoryformatList = try container.decodeIfPresent([LeaveHistoryformatList].self, forKey: ._LeaveHistoryformatList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_LeaveHistoryformatList, forKey: ._LeaveHistoryformatList)
            }

    }
    
    struct LeaveHistoryformatList: Codable {
        var type_name: String = ""
        var cl: String = ""
        var sl: String = ""
        var el: String = ""
        
        enum CodingKeys: String, CodingKey {
            case type_name = "type_name"
            case cl = "cl"
            case sl = "sl"
            case el = "el"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.type_name = try container.decodeIfPresent(String.self, forKey: .type_name) ?? ""
               self.cl = try container.decodeIfPresent(String.self, forKey: .cl) ?? ""
               self.sl = try container.decodeIfPresent(String.self, forKey: .sl) ?? ""
               self.el = try container.decodeIfPresent(String.self, forKey: .el) ?? ""
            
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(type_name, forKey: .type_name)
               try container.encode(cl, forKey: .cl)
               try container.encode(sl, forKey: .sl)
               try container.encode(el, forKey: .el)
           }
    }
    
    
    //AVail History Summary
    struct AvailHistorySummaryList: Codable {
        var leaveType: String = ""
        var availDays: Int?
        var approveFromDate: String = ""
        var approveToDate: String = ""
        var applicationDate: String = ""
        
        enum CodingKeys: String, CodingKey {
            case leaveType = "leaveType"
            case availDays = "availDays"
            case approveFromDate = "approveFromDate"
            case approveToDate = "approveToDate"
            case applicationDate = "applicationDate"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.leaveType = try container.decodeIfPresent(String.self, forKey: .leaveType) ?? ""
               self.availDays = try container.decodeIfPresent(Int.self, forKey: .availDays) ?? 0
               self.approveFromDate = try container.decodeIfPresent(String.self, forKey: .approveFromDate) ?? ""
               self.approveToDate = try container.decodeIfPresent(String.self, forKey: .approveToDate) ?? ""
               self.applicationDate = try container.decodeIfPresent(String.self, forKey: .applicationDate) ?? ""
            
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(leaveType, forKey: .leaveType)
               try container.encode(availDays, forKey: .availDays)
               try container.encode(approveFromDate, forKey: .approveFromDate)
               try container.encode(approveToDate, forKey: .approveToDate)
               try container.encode(applicationDate, forKey: .applicationDate)
           }
    }
    
    
    struct AvailHistorySummaryResponse: Codable {
        var error: String = ""
        var _availHistoryList : [AvailHistorySummaryList]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _availHistoryList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._availHistoryList = try container.decodeIfPresent([AvailHistorySummaryList].self, forKey: ._availHistoryList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_availHistoryList, forKey: ._availHistoryList)
            }
    }
    
    // Final Year Select
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
extension LeaveDetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewAvail {
            print("---you tapped me!----")
        }else{
            selectedButton.setTitle(dataSource[indexPath.row].finalYearName, for: .normal)
            
            if InternetConnectionManager.isConnectedToNetwork(){
                self.getLeaveHistorySummary(finalYear: dataSource[indexPath.row].finalYearNo!)
            }else{
                self.toastMessage("No Internet Connected!!")
            }
        
            removeTransparentView()
        }
    }
}

extension LeaveDetailsViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewAvail {
            return dataSourceAvail.count
        }else{
            return dataSource.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewAvail {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_avail", for: indexPath) as! LeaveDetailsControllerCell
            cell.slLbl.text = "\(indexPath.row+1)"
            cell.leaveTypeLbl.text = dataSourceAvail[indexPath.row].leaveType
            cell.avilDayLbl.text = "\(String(describing: dataSourceAvail[indexPath.row].availDays!))"
            cell.fromDateLbl.text = dataSourceAvail[indexPath.row].approveFromDate
            cell.toDateLbl.text = dataSourceAvail[indexPath.row].approveToDate
            cell.applicationDateLbl.text = dataSourceAvail[indexPath.row].applicationDate
            return cell

        }
        else{

            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row].finalYearName
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewAvail {
            return 40
        }else{
            return 50
        }
        
    }

}


extension LeaveDetailsViewController : UICollectionViewDelegate {
    
}


extension LeaveDetailsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceLeaveHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leave_summary_cell", for: indexPath) as! LeaveSummaryCollectionCell
        cell.clLbl.text = dataSourceLeaveHistory[indexPath.row].cl
        cell.slLbl.text = dataSourceLeaveHistory[indexPath.row].sl
        cell.elLbl.text = dataSourceLeaveHistory[indexPath.row].el
        
        if indexPath.row == 0 {
            cell.leaveTypeLbl.text = "Leave Type"
        }else if indexPath.row == 1 {
            cell.leaveTypeLbl.text = "Total Balance"
        }else if indexPath.row == 2 {
            cell.leaveTypeLbl.text = "Avail Day"
        }else if indexPath.row == 3 {
            cell.leaveTypeLbl.text = "Rest Balance"
        }
        
        return cell
    }
    
    

}

extension LeaveDetailsViewController : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 139)
    }
}

extension UIView{
    func roundedView(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
            byRoundingCorners: [.topLeft , .topRight],
            cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}


extension LeaveDetailsViewController {
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
