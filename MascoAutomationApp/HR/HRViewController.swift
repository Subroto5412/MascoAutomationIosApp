//
//  HRViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 25/11/21.
//

import UIKit

class HRViewController: UIViewController {

    @IBOutlet weak var innerHeaderView: InnerHeader!
    @IBOutlet weak var hrBodyView: HrBodyView!
    
    var searching = false
    let transparentView = UIView()
    let tableViewDropDown = UITableView()
    var selectedButton = UITextField()
    
    var utils = Utils()
    var dataSourceScreenFiltered = [String]()
    
    class func initWithStoryboard() -> HRViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HRViewController.className) as! HRViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.hrBodyView.attendanceUnderBgView.layer.
        self.hideKeyboardWhenTappedAround()
        
        tableViewDropDown.delegate = self
        tableViewDropDown.dataSource = self
        tableViewDropDown.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        self.innerHeaderView.commonSearchTxtField.addTarget(self, action: #selector(searchRecord), for: .editingChanged)
        
        self.hrBodyView.attendanceUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.attendanceUnderBgView.layer.borderWidth = 0.05
        self.hrBodyView.attendanceUnderBgView.layer.cornerRadius = 20
        
        self.hrBodyView.attendanceBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.attendanceBgView.layer.borderWidth = 0.05
        self.hrBodyView.attendanceBgView.layer.cornerRadius = 20
        
        
        self.hrBodyView.leaveUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.leaveUnderBgView.layer.borderWidth = 0.05
        self.hrBodyView.leaveUnderBgView.layer.cornerRadius = 20
        
        self.hrBodyView.leaveBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.leaveBgView.layer.borderWidth = 0.05
        self.hrBodyView.leaveBgView.layer.cornerRadius = 20
        
        
        self.hrBodyView.taxUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.taxUnderBgView.layer.borderWidth = 0.05
        self.hrBodyView.taxUnderBgView.layer.cornerRadius = 20
        
        self.hrBodyView.taxBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.hrBodyView.taxBgView.layer.borderWidth = 0.05
        self.hrBodyView.taxBgView.layer.cornerRadius = 20
        
        self.innerHeaderView.searchBgView.layer.cornerRadius = 10
        
        self.innerHeaderView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showHomeController()
        }
        
        self.hrBodyView.attendanceHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showAttendanceController()
        }
        
        
        self.hrBodyView.leaveHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showLeaveController()
        }
        
        self.hrBodyView.incomeTaxHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showIncomeTaxController()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func showHomeController(){
        
        let controller = HomeViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showAttendanceController(){
        
        let controller = DailyAttendanceViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showLeaveController(){
        
        let controller = LeaveViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showIncomeTaxController(){
        
        let controller = IncomeTaxViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    @objc func searchRecord(sender:UITextField ){
        self.dataSourceScreenFiltered.removeAll()
        let searchData: Int = self.innerHeaderView.commonSearchTxtField.text!.count
        if searchData != 0 {
            searching = true
            for screen in dataSourceScreen
            {
                if let ascreenToSearch = self.innerHeaderView.commonSearchTxtField.text
                {
                    let range = screen.lowercased().range(of: ascreenToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.dataSourceScreenFiltered.append(screen)
                    }
                }
            }
        }else{
            dataSourceScreenFiltered = dataSourceScreen
            searching = false
        }
        selectedButton = innerHeaderView.commonSearchTxtField
        addTransparentView(frames: innerHeaderView.commonSearchTxtField.frame)
        
        tableViewDropDown.reloadData()
    }

    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableViewDropDown.frame = CGRect(x: frames.origin.x+100, y: frames.origin.y + frames.height+80, width: frames.width, height: 0)
        self.view.addSubview(tableViewDropDown)
        tableViewDropDown.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableViewDropDown.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableViewDropDown.frame = CGRect(x: frames.origin.x+100, y: frames.origin.y + frames.height + 5+80, width: frames.width, height: CGFloat(self.dataSourceScreenFiltered.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableViewDropDown.frame = CGRect(x: frames.origin.x+100, y: frames.origin.y + frames.height+80, width: frames.width, height: 0)
        }, completion: nil)
    }

}


extension HRViewController : UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return dataSourceScreenFiltered.count
        }else{
            return dataSourceScreen.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewDropDown.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if searching {
            cell.textLabel?.text = dataSourceScreenFiltered[indexPath.row]
        }else{
            cell.textLabel?.text = dataSourceScreen[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedButton.text = dataSourceScreenFiltered[indexPath.row]
        
        if String(utils.readStringData(key: "BWPD")) == dataSourceScreenFiltered[indexPath.row] {
            let controller = BWPDViewController.initWithStoryboard()
            self.present(controller, animated: true, completion: nil);
        }
        else if String(utils.readStringData(key: "HPD")) == dataSourceScreenFiltered[indexPath.row] {
            let controller = HPDViewController.initWithStoryboard()
            self.present(controller, animated: true, completion: nil);
        }
        else if String(utils.readStringData(key: "HPDs")) == dataSourceScreenFiltered[indexPath.row] {
            let controller = HPDsViewController.initWithStoryboard()
            self.present(controller, animated: true, completion: nil);
        }
        else if String(utils.readStringData(key: "LWP")) == dataSourceScreenFiltered[indexPath.row] {
            let controller = LWPViewController.initWithStoryboard()
            self.present(controller, animated: true, completion: nil);
        }
        else if String(utils.readStringData(key: "DA")) == dataSourceScreenFiltered[indexPath.row] {
            let controller = DailyAttendanceViewController.initWithStoryboard()
            self.present(controller, animated: true, completion: nil);
        }
        else if String(utils.readStringData(key: "LH")) == dataSourceScreenFiltered[indexPath.row] {
            let controller = LeaveViewController.initWithStoryboard()
            self.present(controller, animated: true, completion: nil);
            
        }
        else if String(utils.readStringData(key: "TH")) == dataSourceScreenFiltered[indexPath.row] {
            let controller = IncomeTaxViewController.initWithStoryboard()
            self.present(controller, animated: true, completion: nil);
        }
        
        removeTransparentView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        innerHeaderView.commonSearchTxtField.resignFirstResponder()
        return true
    }
    
}
