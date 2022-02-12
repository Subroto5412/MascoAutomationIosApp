//
//  LWPViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit
import YYCalendar

class LWPViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var tableViewLWP: UITableView!
    @IBOutlet weak var unitNameDropDown: UIButton!
    @IBOutlet weak var titleView: LWPTitleView!
    @IBOutlet weak var dateDropDown: UIButton!
    @IBOutlet weak var outputLbl: UILabel!
    @IBOutlet weak var dateSelecct: UILabel!
    
    @IBOutlet weak var totalOutputPcs: UILabel!
    @IBOutlet weak var unitNameBgView: UIView!
    @IBOutlet weak var btnSelectUnitName: UIButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    var vSpinner : UIView?
    
    var dataSource = [UnitName]()
    var dataSourceLWP = [LineWiseData]()
    var extraHeight: Int = 0
    var unitNoId: Int = 0
    class func initWithStoryboard() -> LWPViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LWPViewController.className) as! LWPViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.titleNameLbl.text = "Line Wise Production"
        
        self.hideKeyboardWhenTappedAround()
        
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getUnitNameList()
        }else{
            self.toastMessage("No Internet Connected!!")
        }
        
        self.nibRegister()
        self.currentDate()
        self.uiViewDesign()
        self.navigationLink()
        extraHeight = Int(self.unitNameBgView.frame.size.height) + Int(self.btnSelectUnitName.frame.size.height)
    }
    
    @IBAction func unitNameDropDown(_ sender: Any) {
       // dataSource = ["Apple", "Mango", "Orange"]
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
            self!.getLWPList(unitNo: self!.unitNoId, createDate: date)
             self?.dateSelecct.text = date
             print(date)
                 }
         
         calendar.sundayColor = UIColor.gray
         calendar.defaultDayColor = UIColor.gray
         calendar.saturdayColor = UIColor.gray
         
         calendar.show()
    }
}


extension LWPViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewLWP {
            print("---you tapped me!----")
        }else{
            unitNoId = dataSource[indexPath.row].unitNo!
            selectedButton.setTitle(dataSource[indexPath.row].unitName, for: .normal)
            
            if InternetConnectionManager.isConnectedToNetwork(){
                self.self.getLWPList(unitNo: unitNoId, createDate: dateSelecct.text!)
            }else{
                self.toastMessage("No Internet Connected!!")
            }
            
            removeTransparentView()
        }
    }
}

extension LWPViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewLWP {
            return dataSourceLWP.count
        }else{
            return dataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewLWP {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LWPViewControllerCell
            cell.slLbl.text = "\(indexPath.row+1)"
            cell.lineNoLbl.text = dataSourceLWP[indexPath.row].lineName
            cell.outputLbl.text = "\(String(describing: dataSourceLWP[indexPath.row].goodGarments!))"
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row].unitName
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewLWP {
            return 40
        }else{
            return 50
        }
    }
}

extension LWPViewController {
    
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

extension LWPViewController {
    
    func nibRegister(){
        self.tableViewLWP.register(UINib(nibName: "LWPViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableViewLWP.delegate = self
        tableViewLWP.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func currentDate(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.dateSelecct.text = dateFormatter.string(from: date)
    }
    
    func uiViewDesign(){
        
        self.unitNameDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.unitNameDropDown.layer.borderWidth = 0.5
        self.unitNameDropDown.layer.cornerRadius = 5
        
        self.dateDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.dateDropDown.layer.borderWidth = 0.5
        self.dateDropDown.layer.cornerRadius = 5
        
        self.titleView.SLView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleView.SLView.layer.borderWidth = 0.5
        self.titleView.SLView.layer.cornerRadius = 10
        
        
        self.titleView.SLView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleView.SLView.layer.borderWidth = 0.5
        self.titleView.SLView.layer.cornerRadius = 10
        
        self.titleView.LineNoView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleView.LineNoView.layer.borderWidth = 0.5
        self.titleView.LineNoView.layer.cornerRadius = 10
        
        
        self.titleView.OutputLbl.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleView.OutputLbl.layer.borderWidth = 0.5
        self.titleView.OutputLbl.layer.cornerRadius = 10
    }
    
    func navigationLink(){
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
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
                        let unitNameItemModel = try JSONDecoder().decode(UnitNameResponse.self, from: data)
                        self.dataSource = unitNameItemModel._listUnitName
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    func getLWPList(unitNo: Int, createDate: String){
        
        let url = URL(string: LWP_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let newTodoItem = LineWiseDataRequest(unit_no: unitNo, created_date: createDate)
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
                        let LWPItemModel = try JSONDecoder().decode(ListLineWiseDataResponse.self, from: data)
                        self.dataSourceLWP = LWPItemModel._lineWiseProduction
                        
                        var totalOuput : Int = 0
                        for i in LWPItemModel._lineWiseProduction{
                            totalOuput = totalOuput + i.goodGarments!
                            self.totalOutputPcs.text = "\(totalOuput)"
                        }
                        self.tableViewLWP.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
}
