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
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [ListFinalYear]()
    
    var totalHeight: Int = 0
    
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
            return 10
        }else{
            return dataSource.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewDailyAttendance {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_daily_attendance", for: indexPath) as! DailyAttendanceTableViewCell
            cell.punchInLbl.text = "09 : 10 : 23 AM"
            cell.punchOutLbl.text = "08 : 20 : 25 PM"
            cell.statusLbl.text = "P"
            cell.otLbl.text = "02 : 10 : 23"
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! LeaveStatusCollectionViewCell
        cell.statusNameLbl.text = "Present"
        cell.starusValueLbl.text = "20"
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
