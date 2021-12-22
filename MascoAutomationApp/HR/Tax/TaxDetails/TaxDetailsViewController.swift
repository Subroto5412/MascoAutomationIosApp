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
    var dataSource = [ListFinalYear]()
    
    
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
        
        let headerViewSize = self.headerView.frame.size.height
        let taxYearViewSize = self.taxYearBgView.frame.size.height/1.5
        totalHeight = Int(headerViewSize+taxYearViewSize)
        
        self.getFinancialYearList()
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
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

    func getFinancialYearList(){
        
        let url = URL(string: YEAR_URL)
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
                        let finalYearItemModel = try JSONDecoder().decode(ListFinalYearResponse.self, from: data)
                        self.dataSource = finalYearItemModel._listFinalYear
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
}

extension TaxDetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == taxTableView {
        }else{
            selectedButton.setTitle(dataSource[indexPath.row].finalYearName, for: .normal)
            print("Final Year id: \(dataSource[indexPath.row].finalYearNo!)")
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
            cell.textLabel?.text = dataSource[indexPath.row].finalYearName
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


extension TaxDetailsViewController {
  
    struct ListFinalYear: Codable {
        var finalYearNo: Int?
        var finalYearName: String = ""
        var yearName: String = ""
        
        enum CodingKeys: String, CodingKey {
            case finalYearNo = "finalYearNo"
            case finalYearName = "finalYearName"
            case yearName = "yearName"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.finalYearNo = try container.decodeIfPresent(Int.self, forKey: .finalYearNo) ?? 0
               self.finalYearName = try container.decodeIfPresent(String.self, forKey: .finalYearName) ?? ""
               self.yearName = try container.decodeIfPresent(String.self, forKey: .yearName) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(finalYearNo, forKey: .finalYearNo)
               try container.encode(finalYearName, forKey: .finalYearName)
               try container.encode(yearName, forKey: .yearName)
           }
    }
    
    struct ListFinalYearResponse: Codable {
        var error: String = ""
        var _listFinalYear : [ListFinalYear]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _listFinalYear
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._listFinalYear = try container.decodeIfPresent([ListFinalYear].self, forKey: ._listFinalYear) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_listFinalYear, forKey: ._listFinalYear)
            }
    }
    
}
