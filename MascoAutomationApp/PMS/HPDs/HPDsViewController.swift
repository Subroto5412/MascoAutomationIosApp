//
//  HPDsViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit
import YYCalendar

class HPDsViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    
    @IBOutlet weak var totalAmoutView: TotalAmountHPDsView!
    @IBOutlet weak var dateDropDown: UIButton!
    @IBOutlet weak var unitNameDropDown: UIButton!
    @IBOutlet weak var tableViewHPDs: UITableView!
    @IBOutlet weak var slBgView: UIView!
    @IBOutlet weak var hourBgView: UIView!
    @IBOutlet weak var cuttingBgView: UIView!
    
    @IBOutlet weak var ironBgView: UIView!
    @IBOutlet weak var sewingOutputBgView: UIView!
    @IBOutlet weak var lineInputBgView: UIView!
    @IBOutlet weak var foldingBgView: UIView!
    @IBOutlet weak var polyBgView: UIView!
    @IBOutlet weak var cartonBgView: UIView!
    @IBOutlet weak var dateSelect: UILabel!
    
    @IBOutlet weak var btnSelectUnitName: UIButton!
    @IBOutlet weak var unitNameBgView: UIView!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [ListUnitName]()
    var dataSourceHPDs = [ListProductionDetails]()
    var extraHeight: Int = 0
    var unitNoId: Int = 0
    
    class func initWithStoryboard() -> HPDsViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HPDsViewController.className) as! HPDsViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Hourly Production \nDetails"
        self.hideKeyboardWhenTappedAround()
        
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getUnitNameList()
        }else{
            self.toastMessage("No Internet Connected!!")
        }
        
        self.tableViewHPDs.register(UINib(nibName: "HPDsViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableViewHPDs.delegate = self
        tableViewHPDs.dataSource = self
        
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
        
        self.slBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.slBgView.layer.borderWidth = 0.5
        self.slBgView.layer.cornerRadius = 10
        
        self.hourBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hourBgView.layer.borderWidth = 0.5
        self.hourBgView.layer.cornerRadius = 10
        
        self.cuttingBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.cuttingBgView.layer.borderWidth = 0.5
        self.cuttingBgView.layer.cornerRadius = 10
        
        self.lineInputBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.lineInputBgView.layer.borderWidth = 0.5
        self.lineInputBgView.layer.cornerRadius = 10
        
        self.sewingOutputBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.sewingOutputBgView.layer.borderWidth = 0.5
        self.sewingOutputBgView.layer.cornerRadius = 10
        
        self.ironBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.ironBgView.layer.borderWidth = 0.5
        self.ironBgView.layer.cornerRadius = 10
        
        
        self.foldingBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.foldingBgView.layer.borderWidth = 0.5
        self.foldingBgView.layer.cornerRadius = 10
        
        self.polyBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.polyBgView.layer.borderWidth = 0.5
        self.polyBgView.layer.cornerRadius = 10
        
        self.cartonBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.cartonBgView.layer.borderWidth = 0.5
        self.cartonBgView.layer.cornerRadius = 10
        
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
         dateFormatter.dateFormat = "dd-MM-yyyy"
         
         let calendar = YYCalendar(normalCalendarLangType: .ENG3,
                                   date: dateFormatter.string(from: currentDate),
                                           format: "dd-MM-yyyy") { [weak self] date in
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
    
    
    func getHWPDsList(unitNo: Int, createDate: String){
        
        let url = URL(string: HWPDs_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTodoItem = HPDsRequest(unit_no: unitNo, created_date: createDate)
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
                        let HWPDsItemModel = try JSONDecoder().decode(ListHPDsResponse.self, from: data)
                        self.dataSourceHPDs = HWPDsItemModel._productionDetailsList
                        
                        var totalCutting : Int = 0
                        var totalLineInput : Int = 0
                        var totalSewOutput : Int = 0
                        var totalIron : Int = 0
                        var totalFolding: Int = 0
                        var totalPoly : Int = 0
                        var totalCarton : Int = 0
                        
                        for index in HWPDsItemModel._productionDetailsList{
                            totalCutting = totalCutting + index.cutting!
                            totalLineInput = totalLineInput + index.lineInput!
                            totalSewOutput = totalSewOutput + index.swingOutput!
                            totalIron = totalIron + index.iron!
                            totalFolding = totalFolding + index.folder!
                            totalPoly = totalPoly + index.ploy!
                            totalCarton = totalCarton + index.cartoon!
                            self.totalAmoutView.cuttingLbl.text = "\(totalCutting)"
                            self.totalAmoutView.lineInputLbl.text = "\(totalLineInput)"
                            self.totalAmoutView.sewOutputLbl.text = "\(totalSewOutput)"
                            self.totalAmoutView.ironLbl.text = "\(totalIron)"
                            self.totalAmoutView.foldingLbl.text = "\(totalFolding)"
                            self.totalAmoutView.polyLbl.text = "\(totalPoly)"
                            self.totalAmoutView.cartonLbl.text = "\(totalCarton)"
                        }
                        self.tableViewHPDs.reloadData()
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

extension HPDsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewHPDs {
            print("---you tapped me!----")
        }else{
            unitNoId = dataSource[indexPath.row].unitNo!
            selectedButton.setTitle(dataSource[indexPath.row].unitName, for: .normal)
            
            if InternetConnectionManager.isConnectedToNetwork(){
                self.getHWPDsList(unitNo: unitNoId, createDate: dateSelect.text!)
            }else{
                self.toastMessage("No Internet Connected!!")
            }
            removeTransparentView()
        }
    }
}

extension HPDsViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewHPDs {
            return dataSourceHPDs.count
        }else{
            return dataSource.count
        }
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewHPDs {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HPDsViewControllerCell
            cell.slLbl.text = "\(indexPath.row+1)"
            cell.hourLbl.text = dataSourceHPDs[indexPath.row].timeSlot
            cell.cuttingLbl.text = "\(String(describing: dataSourceHPDs[indexPath.row].cutting!))"
            cell.lineInputLbl.text = "\(String(describing: dataSourceHPDs[indexPath.row].lineInput!))"
            cell.sewingOutputLbl.text = "\(String(describing: dataSourceHPDs[indexPath.row].swingOutput!))"
            cell.ironLbl.text = "\(String(describing: dataSourceHPDs[indexPath.row].iron!))"
            cell.foldingLbl.text = "\(String(describing: dataSourceHPDs[indexPath.row].folder!))"
            cell.polyLbl.text = "\(String(describing: dataSourceHPDs[indexPath.row].ploy!))"
            cell.cartonLbl.text = "\(String(describing: dataSourceHPDs[indexPath.row].cartoon!))"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row].unitName
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewHPDs {
            return 40
        }else{
            return 50
        }
    }

}

extension HPDsViewController {
  
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


extension HPDsViewController {

    //hour-wise-data
    
    struct HPDsRequest: Codable {
        var unit_no: Int?
        var created_date: String = ""
        
        enum CodingKeys: String, CodingKey {
            case unit_no = "unit_no"
            case created_date = "created_date"
        }
    }
    
    struct ListProductionDetails: Codable {
        
        var timeSlot: String = ""
        var cutting: Int?
        var swingOutput: Int?
        var lineInput: Int?
        var iron: Int?
        var folder: Int?
        var ploy: Int?
        var cartoon: Int?
        
        enum CodingKeys: String, CodingKey {
            case timeSlot = "timeSlot"
            case cutting = "cutting"
            case swingOutput = "swingOutput"
            case lineInput = "lineInput"
            case iron = "iron"
            case folder = "folder"
            case ploy = "ploy"
            case cartoon = "cartoon"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.timeSlot = try container.decodeIfPresent(String.self, forKey: .timeSlot) ?? ""
               self.cutting = try container.decodeIfPresent(Int.self, forKey: .cutting) ?? 0
               self.swingOutput = try container.decodeIfPresent(Int.self, forKey: .swingOutput) ?? 0
               self.lineInput = try container.decodeIfPresent(Int.self, forKey: .lineInput) ?? 0
               self.iron = try container.decodeIfPresent(Int.self, forKey: .iron) ?? 0
               self.folder = try container.decodeIfPresent(Int.self, forKey: .folder) ?? 0
               self.ploy = try container.decodeIfPresent(Int.self, forKey: .ploy) ?? 0
               self.cartoon = try container.decodeIfPresent(Int.self, forKey: .cartoon) ?? 0
            
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(timeSlot, forKey: .timeSlot)
               try container.encode(cutting, forKey: .cutting)
               try container.encode(swingOutput, forKey: .swingOutput)
               try container.encode(lineInput, forKey: .lineInput)
               try container.encode(iron, forKey: .iron)
               try container.encode(folder, forKey: .folder)
               try container.encode(ploy, forKey: .ploy)
               try container.encode(cartoon, forKey: .cartoon)
           }
    }
    
    struct ListHPDsResponse: Codable {
        var error: String = ""
        var _productionDetailsList : [ListProductionDetails]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _productionDetailsList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._productionDetailsList = try container.decodeIfPresent([ListProductionDetails].self, forKey: ._productionDetailsList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_productionDetailsList, forKey: ._productionDetailsList)
            }
    }
}

extension HPDsViewController {
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
