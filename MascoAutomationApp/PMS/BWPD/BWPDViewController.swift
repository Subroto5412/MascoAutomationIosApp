//
//  BWPDViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit
import YYCalendar

class BWPDViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateSelect: UILabel!
    @IBOutlet weak var titleBgView: BWPDTitleView!
    @IBOutlet weak var dateDropDown: UIButton!
    @IBOutlet weak var unitNameDropDown: UIButton!
    class func initWithStoryboard() -> BWPDViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: BWPDViewController.className) as! BWPDViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.register(UINib(nibName: "BWPDTitleViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.unitNameDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.unitNameDropDown.layer.borderWidth = 0.5
        self.unitNameDropDown.layer.cornerRadius = 5
        
        self.dateDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.dateDropDown.layer.borderWidth = 0.5
        self.dateDropDown.layer.cornerRadius = 5
        
        self.titleBgView.slBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.slBgView.layer.borderWidth = 0.5
        self.titleBgView.slBgView.layer.cornerRadius = 10
        
        self.titleBgView.buyerBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.buyerBgView.layer.borderWidth = 0.5
        self.titleBgView.buyerBgView.layer.cornerRadius = 10
        
        self.titleBgView.styleBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.styleBgView.layer.borderWidth = 0.5
        self.titleBgView.styleBgView.layer.cornerRadius = 10
        
        self.titleBgView.orderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.orderBgView.layer.borderWidth = 0.5
        self.titleBgView.orderBgView.layer.cornerRadius = 10
        
        self.titleBgView.orderQtsBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.orderQtsBgView.layer.borderWidth = 0.5
        self.titleBgView.orderQtsBgView.layer.cornerRadius = 10
        
        self.titleBgView.sewQtsBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.sewQtsBgView.layer.borderWidth = 0.5
        self.titleBgView.sewQtsBgView.layer.cornerRadius = 10
        
        self.titleBgView.balanceBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.balanceBgView.layer.borderWidth = 0.5
        self.titleBgView.balanceBgView.layer.cornerRadius = 10
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
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

}


extension BWPDViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("---you tapped me!----")
    }
}

extension BWPDViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BWPDTitleViewControllerCell
        cell.slLbl.text = "1"
        cell.buyerLbl.text = "H&M"
        cell.styleLbl.text = "000001"
        cell.orderLbl.text = "A"
        cell.orderQtsLbl.text = "50000000"
        cell.sewQtsLbl.text = "30000"
        cell.balanceLbl.text = "20000"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}
