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
    
    class func initWithStoryboard() -> HomeViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HomeViewController.className) as! HomeViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuBackgroundView.isHidden = true
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "home_bg")
//        backgroundImage.contentMode = .scaleAspectFill
//        view.insertSubview(backgroundImage, at: 0)
        

     //   self.homeBody.hrisIconView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
     //   self.homeBodyView.hrisIconView.layer.borderWidth = homeBody
        
        
//        self.homeBody.iconView.layer.cornerRadius = 50
//        self.homeBody.iconView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //semiCircleUp
//     let circlePath =  UIBezierPath(arcCenter: CGPoint(x: self.homeBody.iconView.bounds.size.width/2, y: 0), radius: self.homeBody.iconView.bounds.size.height, startAngle: 2 * .pi, endAngle: .pi, clockwise: true).cgPath
//
//        let shape = CAShapeLayer()
//        shape.path = circlePath.CGPath
//        self.homeBody.iconView.layer.mask = shape
        
        
//        let circlePath =  UIBezierPath(arcCenter: CGPoint(x: self.homeBody.iconView.bounds.size.width/2, y: 0), radius: self.homeBody.iconView.bounds.size.height, startAngle: 0, endAngle: .pi, clockwise: true)
        
//        let circlePath =  UIBezierPath(arcCenter: CGPoint(x: self.homeBody.iconView.bounds.size.width/2, y: 0), radius: self.homeBody.iconView.bounds.size.height,startAngle: 2 * .pi, endAngle: .pi, clockwise: false)
        
        
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
        
        
//        let arcCenter = CGPoint(x: self.homeBody.iconView.bounds.size.width / 2.2, y: self.homeBody.iconView.bounds.size.height)
//        let circleRadius = self.homeBody.iconView.bounds.size.width / 2.2
//        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: circleRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
          
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
    
}
