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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var unitNameDropDown: UIButton!
    @IBOutlet weak var titleView: LWPTitleView!
    @IBOutlet weak var dateDropDown: UIButton!
    @IBOutlet weak var outputLbl: UILabel!
    
    @IBOutlet weak var dateSelecct: UILabel!
    class func initWithStoryboard() -> LWPViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LWPViewController.className) as! LWPViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "LWPViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
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
             self?.dateSelecct.text = date
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


extension LWPViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("---you tapped me!----")
    }
}

extension LWPViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LWPViewControllerCell
        cell.slLbl.text = "1"
        cell.lineNoLbl.text = "101"
        cell.outputLbl.text = "400200"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}
