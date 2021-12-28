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

    class func initWithStoryboard() -> LeaveDetailsViewController
    {
        let storyboard = UIStoryboard(name: "LeaveDetailsView", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LeaveDetailsViewController.className) as! LeaveDetailsViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        tableViewAvail.delegate = self
        tableViewAvail.dataSource = self
        self.tableViewAvail.register(UINib(nibName: "LeaveDetailsControllerCell", bundle: nil), forCellReuseIdentifier: "cell_avail")
        
        
        self.leaveSummaryCollectionView.register(UINib(nibName: "LeaveSummaryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "leave_summary_cell")
        
        evenHandler()
        viewDesign()
        
//        let headerViewSize = self.headerView.frame.size.height
//        let taxYearViewSize = self.financialBgView.frame.size.height/1.5
//        totalHeight = Int(headerViewSize+taxYearViewSize)
       
//        getFinancialYearList()
    }
    @IBAction func financialYearBtn(_ sender: Any) {
    
    }
    
    func showBackController(){
        let controller = LeaveViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
//    func getFinancialYearList(){
//
//        let url = URL(string: YEAR_URL)
//        guard let requestUrl = url else { fatalError() }
//
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "GET"
//
//        // Set HTTP Request Header
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//                DispatchQueue.main.async {
//
//                    if let error = error {
//                        print("Error took place \(error)")
//                        return
//                    }
//                    guard let data = data else {return}
//
//                    do{
//                        let finalYearItemModel = try JSONDecoder().decode(ListFinalYearResponse.self, from: data)
//                        self.dataSource = finalYearItemModel._listFinalYear
//
//                    }catch let jsonErr{
//                        print(jsonErr)
//                   }
//                }
//        }
//        task.resume()
//    }
//
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
    
    func getLeaveDetails(){
        
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

        let newTodoItem = LeaveDetailRequestModel(finalYear: 8)
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
                        print("Response data:\n \(todoItemModel)")
                        print("todoItemModel error: \(todoItemModel.error)")
                        
                      
                        
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
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                //    self.indicator.stopAnimating()
                  //  self.indicator.isHidden = true
                    self.getYearList()
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
               self.el = try container.decodeIfPresent(String.self, forKey: .type_name) ?? ""
            
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(type_name, forKey: .type_name)
               try container.encode(cl, forKey: .cl)
               try container.encode(sl, forKey: .sl)
               try container.encode(el, forKey: .el)
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
}
extension LeaveDetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewAvail {
            print("---you tapped me!----")
        }else{
//            selectedButton.setTitle(dataSource[indexPath.row].finalYearName, for: .normal)
//            print("Final Year id: \(dataSource[indexPath.row].finalYearNo!)")
//            removeTransparentView()
        }
    }
}

extension LeaveDetailsViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        if tableView == tableViewAvail {
//            return 10
//        }else{
//            return dataSource.count
//        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_avail", for: indexPath) as! LeaveDetailsControllerCell
        
        cell.slLbl.text = "1"
        cell.leaveTypeLbl.text = "CL"
        cell.avilDayLbl.text = "1"
        cell.fromDateLbl.text = "12-06-2021"
        cell.toDateLbl.text = "12-06-2021"
        cell.applicationDateLbl.text = "15-06-2021"
        return cell
        
//        if tableView == tableViewAvail {
//
//            cell.slLbl.text = "1"
//            cell.leaveTypeLbl.text = "CL"
//            cell.avilDayLbl.text = "1"
//            cell.fromDateLbl.text = "12-06-2021"
//            cell.toDateLbl.text = "12-06-2021"
//            cell.applicationDateLbl.text = "15-06-2021"
//            return cell
//
//        }
//        else{
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//            cell.textLabel?.text = dataSource[indexPath.row].finalYearName
//            return cell
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
//        if tableView == tableViewAvail {
//            return 40
//        }else{
//            return 50
//        }
        
    }

}


extension LeaveDetailsViewController : UICollectionViewDelegate {
    
}


extension LeaveDetailsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leave_summary_cell", for: indexPath) as! LeaveSummaryCollectionCell
        cell.clLbl.text = "10"
        cell.slLbl.text = "14"
        cell.elLbl.text = "17"
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
