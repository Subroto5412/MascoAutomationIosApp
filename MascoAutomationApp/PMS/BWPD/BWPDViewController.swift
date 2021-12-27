//
//  BWPDViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit
import YYCalendar

class BWPDViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var tableViewBWPD: UITableView!
    @IBOutlet weak var btnSelectUnitName: UIButton!
    @IBOutlet weak var unitNameBgView: UIView!
    @IBOutlet weak var dateSelect: UILabel!
    @IBOutlet weak var titleBgView: BWPDTitleView!
    @IBOutlet weak var dateDropDown: UIButton!
    @IBOutlet weak var unitNameDropDown: UIButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [ListUnitName]()
    var dataSourceBWPD = [ListBuyerWiseData]()
    var extraHeight: Int = 0
    var unitNoId: Int = 0
    
    class func initWithStoryboard() -> BWPDViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: BWPDViewController.className) as! BWPDViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUnitNameList()
        
        self.tableViewBWPD.register(UINib(nibName: "BWPDTitleViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableViewBWPD.delegate = self
        tableViewBWPD.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.dateSelect.text = dateFormatter.string(from: date)
        
        self.unitNameDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.unitNameDropDown.layer.borderWidth = 0.5
        self.unitNameDropDown.layer.cornerRadius = 5
        
        self.dateDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.dateDropDown.layer.borderWidth = 0.5
        self.dateDropDown.layer.cornerRadius = 5
        
        self.titleBgView.slBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.slBgView.layer.borderWidth = 0.5
        self.titleBgView.slBgView.layer.cornerRadius = 10
        
        self.titleBgView.buyerBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.buyerBgView.layer.borderWidth = 0.5
        self.titleBgView.buyerBgView.layer.cornerRadius = 10
        
        self.titleBgView.styleBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.styleBgView.layer.borderWidth = 0.5
        self.titleBgView.styleBgView.layer.cornerRadius = 10
        
        self.titleBgView.orderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.orderBgView.layer.borderWidth = 0.5
        self.titleBgView.orderBgView.layer.cornerRadius = 10
        
        self.titleBgView.orderQtsBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.orderQtsBgView.layer.borderWidth = 0.5
        self.titleBgView.orderQtsBgView.layer.cornerRadius = 10
        
        self.titleBgView.sewQtsBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.sewQtsBgView.layer.borderWidth = 0.5
        self.titleBgView.sewQtsBgView.layer.cornerRadius = 10
        
        self.titleBgView.balanceBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.balanceBgView.layer.borderWidth = 0.5
        self.titleBgView.balanceBgView.layer.cornerRadius = 10
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
        
        extraHeight = Int(self.unitNameBgView.frame.size.height) + Int(self.btnSelectUnitName.frame.size.height)
    }
    @IBAction func unitNameBtn(_ sender: Any) {
        selectedButton = btnSelectUnitName
        addTransparentView(frames: btnSelectUnitName.frame)
        
    }
    
    @IBAction func datePickerBtn(_ sender: Any) {
        
        let currentDate = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         
         let calendar = YYCalendar(normalCalendarLangType: .ENG3,
                                   date: dateFormatter.string(from: currentDate),
                                           format: "yyyy-MM-dd") { [weak self] date in
             self?.dateSelect.text = date
             print(date)
                 }
         
         calendar.sundayColor = UIColor.gray
         calendar.defaultDayColor = UIColor.gray
         calendar.saturdayColor = UIColor.gray
         
         calendar.show()
    }
    
    func showBackController(){
        let controller = GPMSViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

    func addTransparentView(frames: CGRect) {
            let window = UIApplication.shared.keyWindow
            transparentView.frame = window?.frame ?? self.view.frame
            self.view.addSubview(transparentView)
            
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+CGFloat(extraHeight), width: frames.width, height: 0)
            self.view.addSubview(tableView)
            tableView.layer.cornerRadius = 5
            
            transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            tableView.reloadData()
            let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
            transparentView.addGestureRecognizer(tapgesture)
            transparentView.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0.5
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5+CGFloat(self.extraHeight), width: frames.width, height: CGFloat(self.dataSource.count * 50))
            }, completion: nil)
        }
        
        @objc func removeTransparentView() {
            let frames = selectedButton.frame
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+CGFloat(self.extraHeight), width: frames.width, height: 0)
            }, completion: nil)
        }
    
    func getUnitNameList(){
        
        let url = URL(string: UNIT_NAME_URL)
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
                        let unitNameItemModel = try JSONDecoder().decode(ListUnitNameResponse.self, from: data)
                        self.dataSource = unitNameItemModel._listUnitName
                    
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    func getBWPDList(unitNo: Int, createDate: String){
        
        let url = URL(string: BWPD_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("unitNo  : \(unitNo) ----createDate  : \(createDate)")
//        print("createDate  : \(createDate)")
        
        let newTodoItem = BWPDRequest(unit_no: unitNo, created_date: createDate)
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
                        let BWPDItemModel = try JSONDecoder().decode(ListBWPDResponse.self, from: data)
                        self.dataSourceBWPD = BWPDItemModel._listBuyerWiseData
                        
                        var totalOuput : Int = 0
//                        for x in BWPDItemModel._listBuyerWiseData{
//                            totalOuput = totalOuput + x.output!
//                            self.totalOutputPCS.text = "\(totalOuput)"
//                        }
                        self.tableViewBWPD.reloadData()
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


extension BWPDViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewBWPD {
            print("---you tapped me!----")
        }else{
            unitNoId = dataSource[indexPath.row].unitNo!
            selectedButton.setTitle(dataSource[indexPath.row].unitName, for: .normal)
            self.getBWPDList(unitNo: unitNoId, createDate: dateSelect.text!)
            removeTransparentView()
        }
       
    }
}

extension BWPDViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewBWPD {
            return dataSourceBWPD.count
        }else{
            return dataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewBWPD {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BWPDTitleViewControllerCell
            cell.slLbl.text = "\(indexPath.row + 1)"
            cell.buyerLbl.text = dataSourceBWPD[indexPath.row].buyerName
            cell.styleLbl.text = dataSourceBWPD[indexPath.row].styleNo
            cell.orderLbl.text = dataSourceBWPD[indexPath.row].orderNo
            cell.orderQtsLbl.text = "\(String(describing: dataSourceBWPD[indexPath.row].orderQty!))"
            cell.sewQtsLbl.text = "\(String(describing: dataSourceBWPD[indexPath.row].sewingQty!))"
            cell.balanceLbl.text = "\(String(describing: dataSourceBWPD[indexPath.row].balance!))"
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row].unitName
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tableViewBWPD {
            return 40
        }else{
            return 40
        }
    }

}

extension BWPDViewController {
  
    struct ListUnitName: Codable {
        var unitNo: Int?
        var unitName: String = ""
        
        enum CodingKeys: String, CodingKey {
            case unitNo = "unitNo"
            case unitName = "unitEName"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.unitNo = try container.decodeIfPresent(Int.self, forKey: .unitNo) ?? 0
               self.unitName = try container.decodeIfPresent(String.self, forKey: .unitName) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(unitNo, forKey: .unitNo)
               try container.encode(unitName, forKey: .unitName)
           }
    }
    
    struct ListUnitNameResponse: Codable {
        var error: String = ""
        var _listUnitName : [ListUnitName]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _listUnitName
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._listUnitName = try container.decodeIfPresent([ListUnitName].self, forKey: ._listUnitName) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_listUnitName, forKey: ._listUnitName)
            }
    }
    
}

extension BWPDViewController {

    //hour-wise-data
    
    struct BWPDRequest: Codable {
        var unit_no: Int?
        var created_date: String = ""
        
        enum CodingKeys: String, CodingKey {
            case unit_no = "unit_no"
            case created_date = "created_date"
        }
    }
    
    struct ListBuyerWiseData: Codable {
        
        var buyerName: String = ""
        var orderNo: String = ""
        var styleNo: String = ""
        var buyerId: Int?
        var styleId: Int?
        var buyerReferenceId: Int?
        var orderQty: Int?
        var sewingQty: Int?
        var balance: Int?
        
        enum CodingKeys: String, CodingKey {
            case buyerName = "buyerName"
            case orderNo = "orderNo"
            case styleNo = "styleNo"
            case buyerId = "buyerId"
            case styleId = "styleId"
            case buyerReferenceId = "buyerReferenceId"
            case orderQty = "orderQty"
            case sewingQty = "sewingQty"
            case balance = "balance"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.buyerName = try container.decodeIfPresent(String.self, forKey: .buyerName) ?? ""
               self.orderNo = try container.decodeIfPresent(String.self, forKey: .orderNo) ?? ""
               self.styleNo = try container.decodeIfPresent(String.self, forKey: .styleNo) ?? ""
               self.buyerId = try container.decodeIfPresent(Int.self, forKey: .buyerId) ?? 0
               self.styleId = try container.decodeIfPresent(Int.self, forKey: .styleId) ?? 0
               self.buyerReferenceId = try container.decodeIfPresent(Int.self, forKey: .buyerReferenceId) ?? 0
               self.orderQty = try container.decodeIfPresent(Int.self, forKey: .orderQty) ?? 0
               self.sewingQty = try container.decodeIfPresent(Int.self, forKey: .sewingQty) ?? 0
               self.balance = try container.decodeIfPresent(Int.self, forKey: .balance) ?? 0
            
            
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(buyerName, forKey: .buyerName)
               try container.encode(orderNo, forKey: .orderNo)
               try container.encode(styleNo, forKey: .styleNo)
               try container.encode(buyerId, forKey: .buyerId)
               try container.encode(styleId, forKey: .styleId)
               try container.encode(buyerReferenceId, forKey: .buyerReferenceId)
               try container.encode(orderQty, forKey: .orderQty)
               try container.encode(sewingQty, forKey: .sewingQty)
               try container.encode(balance, forKey: .balance)
           }
    }
    
    struct ListBWPDResponse: Codable {
        var error: String = ""
        var _listBuyerWiseData : [ListBuyerWiseData]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _listBuyerWiseData
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._listBuyerWiseData = try container.decodeIfPresent([ListBuyerWiseData].self, forKey: ._listBuyerWiseData) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_listBuyerWiseData, forKey: ._listBuyerWiseData)
            }
    }
}

extension BWPDViewController {
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
