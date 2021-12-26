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
    
    class func initWithStoryboard() -> PMSViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: PMSViewController.className) as! PMSViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
