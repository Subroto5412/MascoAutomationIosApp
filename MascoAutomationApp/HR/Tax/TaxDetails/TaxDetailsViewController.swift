//
//  TaxDetailsViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 6/12/21.
//

import UIKit

class TaxDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var detailsBgView: UILabel!
    @IBOutlet weak var taxYearBgView: UIView!
    
    @IBOutlet weak var slBgView: UILabel!
    @IBOutlet weak var DeductionAmountBgView: UILabel!
    @IBOutlet weak var monthBgView: UILabel!
    
    class func initWithStoryboard() -> TaxDetailsViewController
    {
        let storyboard = UIStoryboard(name: "Tax", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TaxDetailsViewController.className) as! TaxDetailsViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "TaxDetailsViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.taxYearBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.taxYearBgView.layer.borderWidth = 0.5
        self.taxYearBgView.layer.cornerRadius = 15
        
        self.detailsBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.detailsBgView.layer.borderWidth = 0.5
        self.detailsBgView.layer.cornerRadius = 12
        
        self.slBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.slBgView.layer.borderWidth = 0.5
        self.slBgView.layer.cornerRadius = 15
        
        self.DeductionAmountBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.DeductionAmountBgView.layer.borderWidth = 0.5
        self.DeductionAmountBgView.layer.cornerRadius = 15
        
        
        self.monthBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.monthBgView.layer.borderWidth = 0.5
        self.monthBgView.layer.cornerRadius = 15
    }

}

extension TaxDetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("---you tapped me!----")
    }
}

extension TaxDetailsViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaxDetailsViewControllerCell
        cell.slLbl.text = "1"
        cell.monthLbl.text = "July - 20"
        cell.deductionAmountLbl.text = "400"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}

