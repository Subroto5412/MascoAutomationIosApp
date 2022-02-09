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

    @IBOutlet weak var headerView: CommonHeaderView!
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
    var totalHeight: Int = 0
    var dataSource = [ListTaxYear]()
    var dataSourceTD = [ListTaxDeduct]()
    var vSpinner : UIView?
    
    class func initWithStoryboard() -> TaxDetailsViewController
    {
        let storyboard = UIStoryboard(name: "Tax", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TaxDetailsViewController.className) as! TaxDetailsViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Income Tax Deduction \nHistory"
        self.hideKeyboardWhenTappedAround()
        self.nibRegister()
        self.uiViewDesign()
        self.navigationLink()
        
        let headerViewSize = self.headerView.frame.size.height
        let taxYearViewSize = self.taxYearBgView.frame.size.height/1.5
        totalHeight = Int(headerViewSize+taxYearViewSize)
        
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getTaxYearList()
        }else{
            self.toastMessage("No Internet Connected!!")
        }
    }
    
    @IBAction func taxYearBtn(_ sender: Any) {
        
        selectedButton = taxYearSelect
        addTransparentView(frames: taxYearSelect.frame)
    }
}

extension TaxDetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == taxTableView {
        }else{
            selectedButton.setTitle(dataSource[indexPath.row].yearName, for: .normal)
            
            if InternetConnectionManager.isConnectedToNetwork(){
                self.getTaxDeductionList(taxYearNo: dataSource[indexPath.row].taxYearNo!)
            }else{
                self.toastMessage("No Internet Connected!!")
            }
            
            removeTransparentView()
        }
    }
}

extension TaxDetailsViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == taxTableView {
            return dataSourceTD.count
        }else{
            return dataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == taxTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTax", for: indexPath) as! TaxDetailsViewControllerCell
            cell.slLbl.text = "\(String(describing: dataSourceTD[indexPath.row].taxMonthNo!))"
            cell.monthLbl.text = dataSourceTD[indexPath.row].monthYear
            cell.deductionAmountLbl.text = "\(String(describing: dataSourceTD[indexPath.row].taxDeductionAmount!))"
            
            if dataSourceTD[indexPath.row].taxMonthNo! < monthForTax() {
                cell.slLbl.textColor = UIColor(red: 1.00, green: 0.33, blue: 0.33, alpha: 1.00)
                cell.monthLbl.textColor = UIColor(red: 1.00, green: 0.33, blue: 0.33, alpha: 1.00)
                cell.deductionAmountLbl.textColor = UIColor.white
                cell.deductionAmoutBgView.backgroundColor = UIColor(red: 1.00, green: 0.33, blue: 0.33, alpha: 1.00)
            }
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row].yearName
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == taxTableView {
            return 35
        }else{
            return 50
        }
        
    }
}


extension TaxDetailsViewController {
    func showSpinner(onView : UIView) {
           let spinnerView = UIView.init(frame: onView.bounds)
           spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
           let ai = UIActivityIndicatorView.init(style: .whiteLarge)
           ai.startAnimating()
           ai.center = spinnerView.center
           
           DispatchQueue.main.async {
               spinnerView.addSubview(ai)
               onView.addSubview(spinnerView)
           }
           
           vSpinner = spinnerView
       }
       
       func removeSpinner() {
           DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
           }
       }
 }
extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}

extension TaxDetailsViewController{
    
    func nibRegister(){
        
        self.taxTableView.register(UINib(nibName: "TaxDetailsViewControllerCell", bundle: nil), forCellReuseIdentifier: "cellTax")
        taxTableView.delegate = self
        taxTableView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func navigationLink() {
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    
    func uiViewDesign()
    {
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
 
    func showBackController(){
        let controller = IncomeTaxViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+CGFloat(self.totalHeight), width: frames.width+100, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5+CGFloat(self.totalHeight), width: frames.width+100, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y+CGFloat(self.totalHeight) + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }

    func getTaxYearList(){
        
        let url = URL(string: TAX_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let taxYearItemModel = try JSONDecoder().decode(ListTaxYearResponse.self, from: data)
                        self.dataSource = taxYearItemModel._taxYearList
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    func getTaxDeductionList(taxYearNo: Int){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        let url = URL(string: TAX_DEDUCTION_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        let newTodoItem = TaxDeductRequest(taxYearNo: taxYearNo)
        let jsonData = try? JSONEncoder().encode(newTodoItem)
        
        request.httpBody = jsonData

        print("jsonData jsonData  data:\n \(jsonData!)")
//        self.showLoading(finished: {
        self.showSpinner(onView: self.view)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                self.removeSpinner()
                DispatchQueue.main.async {
                    
//                    self.hideLoading(finished: {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let TDItemModel = try JSONDecoder().decode(ListTaxDeductResponse.self, from: data)
                        self.dataSourceTD = TDItemModel._taxDeductionsList
                    
                        self.taxTableView.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
//                    })
                }
        }
        task.resume()
//        })
    }
    
  
    func monthForTax() -> Int{
        
        let date = Date()
        let monthString = date.month

        var month:Int = 0
        if monthString == "January"{
            month = 7
        } else if monthString == "February"{
            month = 8
        } else if monthString == "March"{
            month = 9
        } else if monthString == "April"{
            month = 10
        } else if monthString == "May"{
            month = 11
        } else if monthString == "June"{
            month = 12
        } else if monthString == "July"{
            month = 1
        } else if monthString == "August"{
            month = 2
        } else if monthString == "September"{
            month = 3
        } else if monthString == "October"{
            month = 4
        } else if monthString == "November"{
            month = 5
        } else if monthString == "December"{
            month = 6
        }
        return month
    }
}
