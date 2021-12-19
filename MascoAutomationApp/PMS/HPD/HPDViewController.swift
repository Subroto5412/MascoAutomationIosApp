//
//  HPDViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit

class HPDViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleBgView: HPDTitleView!
    @IBOutlet weak var unitNameDropDown: UIButton!
    @IBOutlet weak var dateDropDown: UIButton!
    
    class func initWithStoryboard() -> HPDViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HPDViewController.className) as! HPDViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showToast(message: "Updating...", seconds: 5000.0)
        
        self.tableView.register(UINib(nibName: "HPDViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.unitNameDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.unitNameDropDown.layer.borderWidth = 0.5
        self.unitNameDropDown.layer.cornerRadius = 5
        
        self.dateDropDown.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.dateDropDown.layer.borderWidth = 0.5
        self.dateDropDown.layer.cornerRadius = 5
        
//        self.titleBgView.SLView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
//        self.titleBgView.SLView.layer.borderWidth = 0.5
//        self.titleBgView.SLView.layer.cornerRadius = 15
//
        
        self.titleBgView.slBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.slBgView.layer.borderWidth = 0.5
        self.titleBgView.slBgView.layer.cornerRadius = 10
        
        self.titleBgView.hourBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.hourBgView.layer.borderWidth = 0.5
        self.titleBgView.hourBgView.layer.cornerRadius = 10
        
        
        self.titleBgView.outputBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.titleBgView.outputBgView.layer.borderWidth = 0.5
        self.titleBgView.outputBgView.layer.cornerRadius = 10

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



extension HPDViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("---you tapped me!----")
    }
}

extension HPDViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HPDViewControllerCell
        cell.slLbl.text = "1"
        cell.hourLbl.text = "8 - 9 AM"
        cell.outputLbl.text = "400200"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}


extension HPDViewController{

func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
 }
