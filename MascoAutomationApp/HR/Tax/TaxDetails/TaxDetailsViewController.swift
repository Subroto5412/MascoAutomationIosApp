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
        
        evenHandler()
        viewDesign()
        
        let headerViewSize = self.headerView.frame.size.height
        let taxYearViewSize = self.taxYearBgView.frame.size.height/1.5
        totalHeight = Int(headerViewSize+taxYearViewSize)
        
        self.getTaxYearList()
    }
    
    @IBAction func taxYearBtn(_ sender: Any) {
        
        selectedButton = taxYearSelect
        addTransparentView(frames: taxYearSelect.frame)
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
        self.showLoading(finished: {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    self.hideLoading(finished: {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let TDItemModel = try JSONDecoder().decode(ListTaxDeductResponse.self, from: data)
                        self.dataSourceTD = TDItemModel._taxDeductionsList
                        
//                        var totalOuput : Int = 0
//                        for i in LWPItemModel._lineWiseProduction{
//                            totalOuput = totalOuput + i.goodGarments!
//                            self.totalOutputPcs.text = "\(totalOuput)"
//                        }
                        self.taxTableView.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                    })
                }
        }
        task.resume()
        })
    }
    
    func evenHandler() {
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    
    func viewDesign()
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

extension TaxDetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == taxTableView {
        }else{
            selectedButton.setTitle(dataSource[indexPath.row].yearName, for: .normal)
            getTaxDeductionList(taxYearNo: dataSource[indexPath.row].taxYearNo!)
            print("Final Year id: \(dataSource[indexPath.row].taxYearNo!)")
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
                cell.slLbl.textColor = UIColor.red
                cell.monthLbl.textColor = UIColor.red
                cell.deductionAmountLbl.textColor = UIColor.white
                cell.deductionAmoutBgView.backgroundColor = UIColor.red
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
  
    struct ListTaxYear: Codable {
        var taxYearNo: Int?
        var yearName: String = ""
        
        enum CodingKeys: String, CodingKey {
            case taxYearNo = "taxYearNo"
            case yearName = "yearName"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.taxYearNo = try container.decodeIfPresent(Int.self, forKey: .taxYearNo) ?? 0
               self.yearName = try container.decodeIfPresent(String.self, forKey: .yearName) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(taxYearNo, forKey: .taxYearNo)
               try container.encode(yearName, forKey: .yearName)
           }
    }
    
    struct ListTaxYearResponse: Codable {
        var error: String = ""
        var _taxYearList : [ListTaxYear]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _taxYearList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._taxYearList = try container.decodeIfPresent([ListTaxYear].self, forKey: ._taxYearList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_taxYearList, forKey: ._taxYearList)
            }
    }
    
    struct TaxDeductRequest: Codable {
        var taxYearNo: Int?
        
        enum CodingKeys: String, CodingKey {
            case taxYearNo = "taxYearNo"
        }
    }
    
    struct ListTaxDeduct: Codable {
        var taxMonthNo: Int?
        var monthYear: String = ""
        var taxDeductionAmount: Double?
        
        enum CodingKeys: String, CodingKey {
            case taxMonthNo = "taxMonthNo"
            case monthYear = "monthYear"
            case taxDeductionAmount = "taxDeductionAmount"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.taxMonthNo = try container.decodeIfPresent(Int.self, forKey: .taxMonthNo) ?? 0
               self.monthYear = try container.decodeIfPresent(String.self, forKey: .monthYear) ?? ""
               self.taxDeductionAmount = try container.decodeIfPresent(Double.self, forKey: .taxDeductionAmount) ?? 0.0
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(taxMonthNo, forKey: .taxMonthNo)
               try container.encode(monthYear, forKey: .monthYear)
               try container.encode(taxDeductionAmount, forKey: .taxDeductionAmount)
           }
    }
    
    struct ListTaxDeductResponse: Codable {
        var error: String = ""
        var _taxDeductionsList : [ListTaxDeduct]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _taxDeductionsList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._taxDeductionsList = try container.decodeIfPresent([ListTaxDeduct].self, forKey: ._taxDeductionsList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_taxDeductionsList, forKey: ._taxDeductionsList)
            }
    }
}

extension TaxDetailsViewController {
    func showLoading(finished: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)

        present(alert, animated: false, completion: finished)
    }

    func hideLoading(finished: @escaping () -> Void) {
        if ( presentedViewController != nil && !presentedViewController!.isBeingPresented ) {
            dismiss(animated: false, completion: finished)
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
