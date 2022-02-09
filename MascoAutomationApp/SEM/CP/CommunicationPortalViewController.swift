//
//  CommunicationPortalViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/12/21.
//

import UIKit

class CommunicationPortalViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
  
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    @IBOutlet weak var sectionLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var ofcMobileLbl: UILabel!
    @IBOutlet weak var ofcIP: UILabel!
    @IBOutlet weak var unitLbl: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    var vSpinner : UIView?
    
    var searching = false
    var searchingName = false
    
    var dataSource = [ListUnitName]()
    var filteredDataSource = [ListUnitName]()
    
    var dataSourceName = [ListEmpName]()
    var filteredDataSourceName = [ListEmpName]()
    
    let transparentView = UIView()
    let tableViewUnit = UITableView()
    var selectedButton = UITextField()
    
    let transparentViewName = UIView()
    let tableViewName = UITableView()
    var selectedButtonName = UITextField()
    
    
    class func initWithStoryboard() -> CommunicationPortalViewController
    {
        let storyboard = UIStoryboard(name: "SEM", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: CommunicationPortalViewController.className) as! CommunicationPortalViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Communication Portal"
        
        self.hideKeyboardWhenTappedAround()
        self.uiViewDesign()
        self.navigationLink()
        self.nibRegister()
    
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getUnitList()
        }else{
            self.toastMessage("No Internet Connected!!")
        }
        
        if ((unitTextField.text?.isEmpty) != nil) {
            if InternetConnectionManager.isConnectedToNetwork(){
                self.getEmpNameList(unitNo: 0, EmpName: "")
            }else{
                self.toastMessage("No Internet Connected!!")
            }
        }
    }
}

extension CommunicationPortalViewController : UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableViewUnit{
            
            if searching {
                return filteredDataSource.count
            }else{
                return dataSource.count
            }
            
        }else{
            
            if searchingName {
                return filteredDataSourceName.count
            }else{
                return dataSourceName.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewUnit{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            if searching {
                cell.textLabel?.text = filteredDataSource[indexPath.row].unitEName
            }else{
                cell.textLabel?.text = dataSource[indexPath.row].unitEName
            }
            return cell
            
        }else{
            
            let cell = tableViewName.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            if searchingName {
                cell.textLabel?.text = filteredDataSourceName[indexPath.row].emp_full
            }else{
                cell.textLabel?.text = dataSourceName[indexPath.row].emp_full
            }
            return cell
            
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewUnit{
            
            self.selectedButton.text = filteredDataSource[indexPath.row].unitEName
            
            if InternetConnectionManager.isConnectedToNetwork(){
                self.getEmpNameList(unitNo: filteredDataSource[indexPath.row].unitNo!, EmpName: "")
            }else{
                self.toastMessage("No Internet Connected!!")
            }
            
            removeTransparentView()
            
        }else{
            self.selectedButtonName.text = filteredDataSourceName[indexPath.row].emp_full
            
            if InternetConnectionManager.isConnectedToNetwork(){
                self.getEmpNameDetails(empCode: filteredDataSourceName[indexPath.row].emP_CODE)
            }else{
                self.toastMessage("No Internet Connected!!")
            }
            
            removeTransparentViewName()
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        unitTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        return true
    }
    
}


extension CommunicationPortalViewController {
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

extension CommunicationPortalViewController{
    
    func uiViewDesign(){
        
        self.nameTextField.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.nameTextField.layer.borderWidth = 0.5
        self.nameTextField.layer.cornerRadius = 5
        
        self.unitTextField.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.unitTextField.layer.borderWidth = 0.5
        self.unitTextField.layer.cornerRadius = 5
        
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
    
    func nibRegister(){
        tableViewUnit.delegate = self
        tableViewUnit.dataSource = self
        tableViewUnit.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        unitTextField.addTarget(self, action: #selector(searchRecord), for: .editingChanged)
        
        tableViewName.delegate = self
        tableViewName.dataSource = self
        tableViewName.register(CellClass.self, forCellReuseIdentifier: "Cell")

        nameTextField.addTarget(self, action: #selector(searchRecordName), for: .editingChanged)
    }
    
    @objc func searchRecord(sender:UITextField ){
        self.filteredDataSource.removeAll()
        let searchData: Int = unitTextField.text!.count
        if searchData != 0 {
            searching = true
            for data in dataSource
            {
                if let unitToSearch = unitTextField.text
                {
                    let range = data.unitEName.lowercased().range(of: unitToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.filteredDataSource.append(data)
                    }
                }
            }
        }else{
            filteredDataSource = dataSource
            searching = false
        }
        selectedButton = unitTextField
        addTransparentView(frames: unitTextField.frame)
        
        tableViewUnit.reloadData()
    }
    
    
    @objc func searchRecordName(sender:UITextField ){
        self.filteredDataSourceName.removeAll()
        let searchDataName: Int = nameTextField.text!.count
        if searchDataName != 0 {
            searchingName = true
            for data in dataSourceName
            {
                if let nameToSearch = nameTextField.text
                {
                    let range = data.emp_full.lowercased().range(of: nameToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.filteredDataSourceName.append(data)
                    }
                }
            }
        }else{
            filteredDataSourceName = dataSourceName
            searchingName = false
        }
        selectedButtonName = nameTextField
        addTransparentViewName(frames: nameTextField.frame)

        tableViewName.reloadData()
    }

    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)

        tableViewUnit.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableViewUnit)
        tableViewUnit.layer.cornerRadius = 5

        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableViewUnit.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableViewUnit.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.filteredDataSource.count * 50))
        }, completion: nil)
    }

    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableViewUnit.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    func addTransparentViewName(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentViewName.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentViewName)
        
        tableViewName.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+120, width: frames.width, height: 0)
        self.view.addSubview(tableViewName)
        tableViewName.layer.cornerRadius = 5
        
        transparentViewName.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableViewName.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentViewName))
        transparentViewName.addGestureRecognizer(tapgesture)
        transparentViewName.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentViewName.alpha = 0.5
            self.tableViewName.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5+120, width: frames.width, height: CGFloat(self.filteredDataSourceName.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentViewName() {
        let frames = selectedButtonName.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentViewName.alpha = 0
            self.tableViewName.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+120, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    func showBackController(){
        let controller = SEMViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func getUnitList(){
        
        let url = URL(string: LOAD_UNITNAME_URL)
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
                        let unitItemModel = try JSONDecoder().decode(ListUnitNameResponse.self, from: data)
                        self.dataSource = unitItemModel._listUnitName
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    func getEmpNameList(unitNo: Int, EmpName: String){
        
        let url = URL(string: LOAD_EMPNAME_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTodoItem = EmpNameRequest(unit_no: unitNo, emp_name: EmpName)
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
                        let empNameItemModel = try JSONDecoder().decode(ListEmpNameResponse.self, from: data)
                        self.dataSourceName = empNameItemModel._listEmployee
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    func getEmpNameDetails(empCode: String){
        
        let url = URL(string: GET_EMP_DETAILS_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTodoItem = EmpNameDetailsRequest(emp_code: empCode)
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
                        let empDetailsItemModel = try JSONDecoder().decode(ListEmpResponse.self, from: data)
                        
                        self.nameLbl.text = empDetailsItemModel.empDetails.emP_ENAME
                        self.designationLbl.text = empDetailsItemModel.empDetails.desigEName
                        self.sectionLbl.text = empDetailsItemModel.empDetails.sectEName
                        self.emailLbl.text = empDetailsItemModel.empDetails.email
                        self.mobileLbl.text = empDetailsItemModel.empDetails.personal_mobile
                        self.ofcMobileLbl.text = empDetailsItemModel.empDetails.office_mobile
                        self.ofcIP.text = empDetailsItemModel.empDetails.ip
                        self.unitLbl.text = empDetailsItemModel.empDetails.unitEName
                        
                        
                        let photoArr = empDetailsItemModel.empDetails.img_url.components(separatedBy: "\\")
                        let photo = photoArr[1] //Last
                        
                        let urlLinkPhoto = (PHOTO_LINK_URL+photo)
                        let photoUrl =  URL(string: urlLinkPhoto)!

                        if let data = try? Data(contentsOf: photoUrl) {
                                // Create Image and Update Image View
                            self.profilePic.image = UIImage(data: data)
                            self.profilePic.setCornerRounded()
                            let skyBlueColor = UIColor(red: 255/255.0, green: 234/255.0, blue: 167/255.0, alpha: 1.0)
                            self.profilePic.layer.borderWidth = 2.0
                            self.profilePic.layer.borderColor = skyBlueColor.cgColor
                            }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
}
