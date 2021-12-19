//
//  HPDsViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit

class HPDsViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    
    @IBOutlet weak var dateDropDown: UIButton!
    @IBOutlet weak var unitNameDropDown: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slBgView: UIView!
    @IBOutlet weak var hourBgView: UIView!
    @IBOutlet weak var cuttingBgView: UIView!
    
    @IBOutlet weak var ironBgView: UIView!
    @IBOutlet weak var sewingOutputBgView: UIView!
    @IBOutlet weak var lineInputBgView: UIView!
    @IBOutlet weak var foldingBgView: UIView!
    @IBOutlet weak var polyBgView: UIView!
    @IBOutlet weak var cartonBgView: UIView!
    
    class func initWithStoryboard() -> HPDsViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HPDsViewController.className) as! HPDsViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "HPDsViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
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
    }
    

    func showBackController(){
        let controller = GPMSViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

}

extension HPDsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("---you tapped me!----")
    }
}

extension HPDsViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HPDsViewControllerCell
        cell.slLbl.text = "1"
        cell.hourLbl.text = "8 - 9 AM"
        cell.cuttingLbl.text = "000001"
        cell.lineInputLbl.text = "20000"
        cell.sewingOutputLbl.text = "500000"
        cell.ironLbl.text = "30000"
        cell.foldingLbl.text = "20000"
        cell.polyLbl.text = "60000"
        cell.cartonLbl.text = "20000"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}
