//
//  HPDViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit
import YYCalendar

class HPDViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var tableViewHPD: UITableView!
    @IBOutlet weak var titleBgView: HPDTitleView!
    @IBOutlet weak var unitNameDropDown: UIButton!
    @IBOutlet weak var dateDropDown: UIButton!
    @IBOutlet weak var dateSelect: UILabel!
    
    @IBOutlet weak var totalOutputPCS: UILabel!
    @IBOutlet weak var btnSelectUnitName: UIButton!
    @IBOutlet weak var unitNameBgView: UIView!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [UnitName]()
    var dataSourceHWD = [HourWiseData]()
    var extraHeight: Int = 0
    var unitNoId: Int = 0
    var vSpinner : UIView?
    
    class func initWithStoryboard() -> HPDViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HPDViewController.className) as! HPDViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Hourly Production Data"
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
           
            self!.getHWDList(unitNo: self!.unitNoId, createDate: date)
            self?.dateSelect.text = date
            }
         calendar.sundayColor = UIColor.gray
         calendar.defaultDayColor = UIColor.gray
         calendar.saturdayColor = UIColor.gray
         calendar.show()
    }
}

extension HPDViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewHPD {
            print("---you tapped me!----")
            
        }else{
            unitNoId = dataSource[indexPath.row].unitNo!
            selectedButton.setTitle(dataSource[indexPath.row].unitName, for: .normal)
            
            if InternetConnectionManager.isConnectedToNetwork(){
                self.getHWDList(unitNo: unitNoId, createDate: dateSelect.text!)
            }else{
                self.toastMessage("No Internet Connected!!")
            }
            
            removeTransparentView()
        }
    }
}

extension HPDViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewHPD {
            return dataSourceHWD.count
        }else{
            return dataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == tableViewHPD {
            var counting :Int = 1
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HPDViewControllerCell
            counting = indexPath.row+1
            cell.slLbl.text = "\(counting)"
            cell.hourLbl.text = dataSourceHWD[indexPath.row].hour
            cell.outputLbl.text = "\(String(describing: dataSourceHWD[indexPath.row].output!))"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row].unitName
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tableViewHPD {
            return 40
        }else{
            return 50
        }
    }
}

extension HPDViewController {
    
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

extension HPDViewController{
    
    func nibRegister(){
        self.tableViewHPD.register(UINib(nibName: "HPDViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableViewHPD.delegate = self
        tableViewHPD.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func currentDate(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.dateSelect.text = dateFormatter.string(from: date)
    }
    
    func uiViewDesign(){
        
        self.unitNameDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.unitNameDropDown.layer.borderWidth = 0.5
        self.unitNameDropDown.layer.cornerRadius = 5
        
        self.dateDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.dateDropDown.layer.borderWidth = 0.5
        self.dateDropDown.layer.cornerRadius = 5
        
        self.titleBgView.slBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.slBgView.layer.borderWidth = 0.5
        self.titleBgView.slBgView.layer.cornerRadius = 10
        
        self.titleBgView.hourBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.hourBgView.layer.borderWidth = 0.5
        self.titleBgView.hourBgView.layer.cornerRadius = 10
        
        
        self.titleBgView.outputBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.outputBgView.layer.borderWidth = 0.5
        self.titleBgView.outputBgView.layer.cornerRadius = 10
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
    
    func getHWDList(unitNo: Int, createDate: String){
        
        let url = URL(string: HWD_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTodoItem = HourWiseDataRequest(unit_no: unitNo, created_date: createDate)
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
                        let HWDItemModel = try JSONDecoder().decode(HourWiseDataResponse.self, from: data)
                        self.dataSourceHWD = HWDItemModel._hourWiseDataList
                        
                        var totalOuput : Int = 0
                        for i in HWDItemModel._hourWiseDataList{
                            totalOuput = totalOuput + i.output!
                            self.totalOutputPCS.text = "\(totalOuput)"
                        }
                        self.tableViewHPD.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
}
