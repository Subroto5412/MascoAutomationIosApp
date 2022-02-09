//
//  PMSViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 13/12/21.
//

import UIKit

class PMSViewController: UIViewController {
    @IBOutlet weak var headerView: InnerHeader!
    @IBOutlet weak var footerView: CommonFooter!
    @IBOutlet weak var bodyView: PMSBodyView!
    
    var searching = false
    let transparentView = UIView()
    let tableViewDropDown = UITableView()
    var selectedButton = UITextField()
    
    var utils = Utils()
    var dataSourceScreenFiltered = [String]()
    
    class func initWithStoryboard() -> PMSViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: PMSViewController.className) as! PMSViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.hideKeyboardWhenTappedAround()
        self.nibRegister()
        self.uiViewDesign()
        self.navigationLink()
        self.headerView.commonSearchTxtField.addTarget(self, action: #selector(searchRecord), for: .editingChanged)
    }
}

extension PMSViewController : UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
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
        headerView.commonSearchTxtField.resignFirstResponder()
        return true
    }
    
}

extension PMSViewController {
    
    func uiViewDesign(){
        
        self.headerView.searchBgView.layer.cornerRadius = 10
        let arcCenterKPMS = CGPoint(x: self.bodyView.iconKPMSBgView.bounds.size.width / 2, y: self.bodyView.iconKPMSBgView.bounds.size.height)
        let circleRadiusKPMS = self.bodyView.iconKPMSBgView.bounds.size.width / 2
        let circlePathKPMS = UIBezierPath(arcCenter: arcCenterKPMS, radius: circleRadiusKPMS, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeKPMS = CAShapeLayer()
        circleShapeKPMS.path = circlePathKPMS.cgPath
        self.bodyView.iconKPMSBgView.layer.mask = circleShapeKPMS
        self.bodyView.nameKPMSBgView.layer.cornerRadius = 20
        
        let arcCenterDPMS = CGPoint(x: self.bodyView.iconDPMSBgView.bounds.size.width / 2, y: self.bodyView.iconDPMSBgView.bounds.size.height)
        let circleRadiusDPMS = self.bodyView.iconDPMSBgView.bounds.size.width / 2
        let circlePathKDPMS = UIBezierPath(arcCenter: arcCenterDPMS, radius: circleRadiusDPMS, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeDPMS = CAShapeLayer()
        circleShapeDPMS.path = circlePathKDPMS.cgPath
        self.bodyView.iconDPMSBgView.layer.mask = circleShapeDPMS
        self.bodyView.nameDPMSBgView.layer.cornerRadius = 20
        
        
        let arcCenterGPMS = CGPoint(x: self.bodyView.iconGPMSBgView.bounds.size.width / 2, y: self.bodyView.iconGPMSBgView.bounds.size.height)
        let circleRadiusGPMS = self.bodyView.iconGPMSBgView.bounds.size.width / 2
        let circlePathKGPMS = UIBezierPath(arcCenter: arcCenterGPMS, radius: circleRadiusGPMS, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeGPMS = CAShapeLayer()
        circleShapeGPMS.path = circlePathKGPMS.cgPath
        self.bodyView.iconGPMSBgView.layer.mask = circleShapeGPMS
        self.bodyView.nameGPMSBgView.layer.cornerRadius = 20
        
        let arcCenterPPMS = CGPoint(x: self.bodyView.iconPPMSBgView.bounds.size.width / 2, y: self.bodyView.iconPPMSBgView.bounds.size.height)
        let circleRadiusPPMS = self.bodyView.iconPPMSBgView.bounds.size.width / 2
        let circlePathKPPMS = UIBezierPath(arcCenter: arcCenterPPMS, radius: circleRadiusPPMS, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapePPMS = CAShapeLayer()
        circleShapePPMS.path = circlePathKPPMS.cgPath
        self.bodyView.iconPPMSBgView.layer.mask = circleShapePPMS
        self.bodyView.namePPMSBgView.layer.cornerRadius = 20
        
        let arcCenterEPMS = CGPoint(x: self.bodyView.iconEPMSBgView.bounds.size.width / 2, y: self.bodyView.iconEPMSBgView.bounds.size.height)
        let circleRadiusEPMS = self.bodyView.iconEPMSBgView.bounds.size.width / 2
        let circlePathKEPMS = UIBezierPath(arcCenter: arcCenterEPMS, radius: circleRadiusEPMS, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeEPMS = CAShapeLayer()
        circleShapeEPMS.path = circlePathKEPMS.cgPath
        self.bodyView.iconEPMSBgView.layer.mask = circleShapeEPMS
        self.bodyView.nameEPMSBgView.layer.cornerRadius = 20
    }
    
    func nibRegister(){
        
        tableViewDropDown.delegate = self
        tableViewDropDown.dataSource = self
        tableViewDropDown.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func navigationLink(){
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showHomeController()
        }
        
        self.bodyView.GPMSHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showGPMSController()
        }
    }
    
    func showHomeController(){
        
        let controller = HomeViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showGPMSController(){
        
        let controller = GPMSViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

    @objc func searchRecord(sender:UITextField ){
        self.dataSourceScreenFiltered.removeAll()
        let searchData: Int = self.headerView.commonSearchTxtField.text!.count
        if searchData != 0 {
            searching = true
            for screen in dataSourceScreen
            {
                if let ascreenToSearch = self.headerView.commonSearchTxtField.text
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
        selectedButton = headerView.commonSearchTxtField
        addTransparentView(frames: headerView.commonSearchTxtField.frame)
        
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
