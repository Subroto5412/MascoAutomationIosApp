//
//  TaxDetailsViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 6/12/21.
//

import UIKit

class CellClass: UITableViewCell {
}

class TaxDetailsViewController: UIViewController {

    @IBOutlet weak var taxTableView: UITableView!
    
    @IBOutlet weak var detailsBgView: UILabel!
    @IBOutlet weak var taxYearBgView: UIView!
    
    @IBOutlet weak var slBgView: UILabel!
    @IBOutlet weak var DeductionAmountBgView: UILabel!
    @IBOutlet weak var monthBgView: UILabel!
    
    @IBOutlet weak var taxYearSelect: UIButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    var dataSource = [String]()
    
    
    class func initWithStoryboard() -> TaxDetailsViewController
    {
        let storyboard = UIStoryboard(name: "Tax", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TaxDetailsViewController.className) as! TaxDetailsViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.taxTableView.register(UINib(nibName: "TaxDetailsViewControllerCell", bundle: nil), forCellReuseIdentifier: "cellTax")
        taxTableView.delegate = self
        taxTableView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        
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
    
    @IBAction func taxYearBtn(_ sender: Any) {
        
        dataSource = ["Apple", "Mango", "Orange"]
        selectedButton = taxYearSelect
        addTransparentView(frames: taxYearSelect.frame)
    }
    

    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+150, width: frames.width+100, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5+150, width: frames.width+100, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y+150 + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }

    
}

extension TaxDetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == taxTableView {
        }else{
            selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
            removeTransparentView()
        }
    }
}

extension TaxDetailsViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == taxTableView {
            return 10
        }else{
            return dataSource.count
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == taxTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTax", for: indexPath) as! TaxDetailsViewControllerCell
            cell.slLbl.text = "1"
            cell.monthLbl.text = "July - 20"
            cell.deductionAmountLbl.text = "400"
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row]
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == taxTableView {
            return 40
        }else{
            return 50
        }
        
    }

}

