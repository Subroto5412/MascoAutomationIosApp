//
//  HomeViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 22/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var homeBody: HomeScreenBody!
    @IBOutlet weak var homeHeader: HomeHeader!
    @IBOutlet weak var menuBackgroundView: UIView!
    
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var leadingConstraintSideMenu: NSLayoutConstraint!
    
    private var isMenuShown:Bool = false
    
    //    @IBOutlet weak var homeBodyView: HomeBody!
    var sideMenuViewController : SideMenuViewController?
    
    var searching = false
    let transparentView = UIView()
    let tableViewDropDown = UITableView()
    var selectedButton = UITextField()
    
    //var dataSource = [String]()
    var dataSourceScreenFiltered = [String]()
    var utils = Utils()
    
    class func initWithStoryboard() -> HomeViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HomeViewController.className) as! HomeViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuBackgroundView.isHidden = true
        
        
        print("--------\(utils.readStringData(key: "empCode"))----")
        
       // dataSource = dataSourceScreen
        
        tableViewDropDown.delegate = self
        tableViewDropDown.dataSource = self
        tableViewDropDown.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        self.homeHeader.commonSearchTxtField.addTarget(self, action: #selector(searchRecord), for: .editingChanged)
        
        self.homeHeader.menuHandler = {
              [weak self] (isShow) in
              guard let weakSelf = self else {
              return
           }
           weakSelf.showSideMenuController()
       }
        
        self.homeBody.HRISHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showHrController()
        }
        
        self.homeBody.PMSHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showPMSController()
        }
        
        self.homeBody.SEMHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showSEMController()
        }
        
        self.homeBody.ATMHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showATMController()
        }
        
        self.homeBody.ILMHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showILMController()
        }
        
        self.homeBody.DSMHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showDSMController()
        }
        
        self.homeBody.DMSHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showDMSController()
        }
        
        self.homeBody.AMSHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showAMSController()
        }
        
        self.homeBody.AMHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showAMController()
        }
        
        self.homeBody.MMHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showMMController()
        }
        self.homeBody.SCMHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showSCMController()
        }
          
        let arcCenter = CGPoint(x: self.homeBody.iconView.bounds.size.width / 2, y: self.homeBody.iconView.bounds.size.height)
        let circleRadius = self.homeBody.iconView.bounds.size.width / 2
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: circleRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
        
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        self.homeBody.iconView.layer.mask = circleShape
        self.homeBody.itemNameView.layer.cornerRadius = 20
        
        
        let arcCenterSCM = CGPoint(x: self.homeBody.scmIconView.bounds.size.width / 2, y: self.homeBody.scmIconView.bounds.size.height)
        let circleRadiusSCM = self.homeBody.scmIconView.bounds.size.width / 2
        let circlePathSCM = UIBezierPath(arcCenter: arcCenterSCM, radius: circleRadiusSCM, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeSCM = CAShapeLayer()
        circleShapeSCM.path = circlePathSCM.cgPath
        self.homeBody.scmIconView.layer.mask = circleShapeSCM
        self.homeBody.scmItemNameView.layer.cornerRadius = 20
        
        let arcCenterPMS = CGPoint(x: self.homeBody.pmsIconView.bounds.size.width / 2, y: self.homeBody.pmsIconView.bounds.size.height)
        let circleRadiusPMS = self.homeBody.pmsIconView.bounds.size.width / 2
        let circlePathPMS = UIBezierPath(arcCenter: arcCenterPMS, radius: circleRadiusPMS, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapePMS = CAShapeLayer()
        circleShapePMS.path = circlePathPMS.cgPath
        self.homeBody.pmsIconView.layer.mask = circleShapePMS
        self.homeBody.pmsItemNameView.layer.cornerRadius = 20
        
        let arcCenterMM = CGPoint(x: self.homeBody.mmIconView.bounds.size.width / 2, y: self.homeBody.mmIconView.bounds.size.height)
        let circleRadiusMM = self.homeBody.mmIconView.bounds.size.width / 2
        let circlePathMM = UIBezierPath(arcCenter: arcCenterMM, radius: circleRadiusMM, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeMM = CAShapeLayer()
        circleShapeMM.path = circlePathMM.cgPath
        self.homeBody.mmIconView.layer.mask = circleShapeMM
        self.homeBody.mmItemNameView.layer.cornerRadius = 20
        
        let arcCenterATM = CGPoint(x: self.homeBody.atmIconView.bounds.size.width / 2, y: self.homeBody.atmIconView.bounds.size.height)
        let circleRadiusATM = self.homeBody.atmIconView.bounds.size.width / 2
        let circlePathATM = UIBezierPath(arcCenter: arcCenterATM, radius: circleRadiusATM, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeATM = CAShapeLayer()
        circleShapeATM.path = circlePathATM.cgPath
        self.homeBody.atmIconView.layer.mask = circleShapeATM
        self.homeBody.atmItemNameView.layer.cornerRadius = 20
        
        let arcCenterAMS = CGPoint(x: self.homeBody.amsIconView.bounds.size.width / 2, y: self.homeBody.amsIconView.bounds.size.height)
        let circleRadiusAMS = self.homeBody.amsIconView.bounds.size.width / 2
        let circlePathAMS = UIBezierPath(arcCenter: arcCenterAMS, radius: circleRadiusAMS, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeAMS = CAShapeLayer()
        circleShapeAMS.path = circlePathAMS.cgPath
        self.homeBody.amsIconView.layer.mask = circleShapeAMS
        self.homeBody.amsItemNameView.layer.cornerRadius = 20
        
        let arcCenterSEM = CGPoint(x: self.homeBody.semIconView.bounds.size.width / 2, y: self.homeBody.semIconView.bounds.size.height)
        let circleRadiusSEM = self.homeBody.semIconView.bounds.size.width / 2
        let circlePathSEM = UIBezierPath(arcCenter: arcCenterSEM, radius: circleRadiusSEM, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeSEM = CAShapeLayer()
        circleShapeSEM.path = circlePathSEM.cgPath
        self.homeBody.semIconView.layer.mask = circleShapeSEM
        self.homeBody.semItemNameView.layer.cornerRadius = 20
        
        let arcCenterDSM = CGPoint(x: self.homeBody.dsmIconView.bounds.size.width / 2, y: self.homeBody.dsmIconView.bounds.size.height)
        let circleRadiusDSM = self.homeBody.dsmIconView.bounds.size.width / 2
        let circlePathDSM = UIBezierPath(arcCenter: arcCenterDSM, radius: circleRadiusDSM, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeDSM = CAShapeLayer()
        circleShapeDSM.path = circlePathDSM.cgPath
        self.homeBody.dsmIconView.layer.mask = circleShapeDSM
        self.homeBody.dsmItemNameView.layer.cornerRadius = 20
        
        let arcCenterILM = CGPoint(x: self.homeBody.ilmIconView.bounds.size.width / 2, y: self.homeBody.ilmIconView.bounds.size.height)
        let circleRadiusILM = self.homeBody.ilmIconView.bounds.size.width / 2
        let circlePathILM = UIBezierPath(arcCenter: arcCenterILM, radius: circleRadiusILM, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeILM = CAShapeLayer()
        circleShapeILM.path = circlePathILM.cgPath
        self.homeBody.ilmIconView.layer.mask = circleShapeILM
        self.homeBody.ilmItemNameView.layer.cornerRadius = 20
        
        let arcCenterDMS = CGPoint(x: self.homeBody.dmsIconView.bounds.size.width / 2, y: self.homeBody.dmsIconView.bounds.size.height)
        let circleRadiusDMS = self.homeBody.dmsIconView.bounds.size.width / 2
        let circlePathDMS = UIBezierPath(arcCenter: arcCenterDMS, radius: circleRadiusDMS, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeDMS = CAShapeLayer()
        circleShapeDMS.path = circlePathDMS.cgPath
        self.homeBody.dmsIconView.layer.mask = circleShapeDMS
        self.homeBody.dmsItemNameview.layer.cornerRadius = 20
        
        let arcCenterAM = CGPoint(x: self.homeBody.dmsIconView.bounds.size.width / 2, y: self.homeBody.amIconView.bounds.size.height)
        let circleRadiusAM = self.homeBody.amIconView.bounds.size.width / 2
        let circlePathAM = UIBezierPath(arcCenter: arcCenterAM, radius: circleRadiusAM, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
        let circleShapeAM = CAShapeLayer()
        circleShapeAM.path = circlePathAM.cgPath
        self.homeBody.amIconView.layer.mask = circleShapeAM
        self.homeBody.amItemNameView.layer.cornerRadius = 20
        
        self.homeHeader.homeHeaderBg.layer.cornerRadius = 10
    }
    
    @IBAction func Tap(_ sender: Any) {
        
        self.hideMenuView()
        
    }
    
    func showSideMenuController() {
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintSideMenu.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            self.menuBackgroundView.alpha = 0.75
            self.menuBackgroundView.isHidden = false
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintSideMenu.constant = 0
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.isMenuShown = true
            }

        }
        self.menuBackgroundView.isHidden = false
    }
    
    func showHrController(){
        
        let controller = HRViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showPMSController(){
        
        let controller = PMSViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showSEMController(){
        
        let controller = SEMViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showATMController(){
        
        let controller = ATMViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

    func showILMController(){
        toastMessage("under construction!!")
    }
    
    func showSCMController(){
        toastMessage("under construction!!")
    }
    
    func showMMController(){
        toastMessage("under construction!!")
    }
    
    func showAMController(){
        
        let controller = HRISViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    func showAMSController(){
        toastMessage("under construction!!")
    }
    
    func showDMSController(){
        toastMessage("under construction!!")
    }
    
    func showDSMController(){
        toastMessage("under construction!!")
    }
    
    func hideMenuView()
    {
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintSideMenu.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            self.menuBackgroundView.alpha = 0.0
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintSideMenu.constant = -320
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.menuBackgroundView.isHidden = true
                self.isMenuShown = false
            }
        }
    }
    
    @objc func searchRecord(sender:UITextField ){
        self.dataSourceScreenFiltered.removeAll()
        let searchData: Int = self.homeHeader.commonSearchTxtField.text!.count
        if searchData != 0 {
            searching = true
            for screen in dataSourceScreen
            {
                if let ascreenToSearch = self.homeHeader.commonSearchTxtField.text
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
        selectedButton = homeHeader.commonSearchTxtField
        addTransparentView(frames: homeHeader.commonSearchTxtField.frame)
        
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


extension HomeViewController : UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
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
        homeHeader.commonSearchTxtField.resignFirstResponder()
        return true
    }
    
}
