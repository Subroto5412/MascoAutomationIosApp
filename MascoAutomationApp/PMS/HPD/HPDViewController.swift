//
//  HPDViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 14/12/21.
//

import UIKit
import YYCalendar

class HPDViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var tableViewHPD: UITableView!
    @IBOutlet weak var titleBgView: HPDTitleView!
    @IBOutlet weak var unitNameDropDown: UIButton!
    @IBOutlet weak var dateDropDown: UIButton!
    @IBOutlet weak var dateSelect: UILabel!
    
    @IBOutlet weak var btnSelectUnitName: UIButton!
    @IBOutlet weak var unitNameBgView: UIView!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [ListUnitName]()
    var extraHeight: Int = 0
    
    class func initWithStoryboard() -> HPDViewController
    {
        let storyboard = UIStoryboard(name: "PMS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: HPDViewController.className) as! HPDViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUnitNameList()
        
        self.tableViewHPD.register(UINib(nibName: "HPDViewControllerCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableViewHPD.delegate = self
        tableViewHPD.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
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
        
        extraHeight = Int(self.unitNameBgView.frame.size.height) + Int(self.btnSelectUnitName.frame.size.height)
    }
    
    @IBAction func unitNameBtn(_ sender: Any) {
        selectedButton = btnSelectUnitName
        addTransparentView(frames: btnSelectUnitName.frame)
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
    
    func addTransparentView(frames: CGRect) {
            let window = UIApplication.shared.keyWindow
            transparentView.frame = window?.frame ?? self.view.frame
            self.view.addSubview(transparentView)
            
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+CGFloat(extraHeight), width: frames.width, height: 0)
            self.view.addSubview(tableView)
            tableView.layer.cornerRadius = 5
            
            transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            tableView.reloadData()
            let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
            transparentView.addGestureRecognizer(tapgesture)
            transparentView.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0.5
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5+CGFloat(self.extraHeight), width: frames.width, height: CGFloat(self.dataSource.count * 50))
            }, completion: nil)
        }
        
        @objc func removeTransparentView() {
            let frames = selectedButton.frame
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height+CGFloat(self.extraHeight), width: frames.width, height: 0)
            }, completion: nil)
        }
    
    func getUnitNameList(){
        
        let url = URL(string: UNIT_NAME_URL)
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
                        let unitNameItemModel = try JSONDecoder().decode(ListUnitNameResponse.self, from: data)
                        self.dataSource = unitNameItemModel._listUnitName
                    
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
}



extension HPDViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewHPD {
            print("---you tapped me!----")
        }else{
            selectedButton.setTitle(dataSource[indexPath.row].unitName, for: .normal)
            removeTransparentView()
        }
        
    }
}

extension HPDViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewHPD {
            return 10
        }else{
            return dataSource.count
        }
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == tableViewHPD {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HPDViewControllerCell
            cell.slLbl.text = "1"
            cell.hourLbl.text = "8 - 9 AM"
            cell.outputLbl.text = "400200"
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row].unitName
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tableViewHPD {
            return 40
        }else{
            return 50
        }
    }

}

extension HPDViewController {
  
    struct ListUnitName: Codable {
        var unitNo: Int?
        var unitName: String = ""
        
        enum CodingKeys: String, CodingKey {
            case unitNo = "unitNo"
            case unitName = "unitEName"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.unitNo = try container.decodeIfPresent(Int.self, forKey: .unitNo) ?? 0
               self.unitName = try container.decodeIfPresent(String.self, forKey: .unitName) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(unitNo, forKey: .unitNo)
               try container.encode(unitName, forKey: .unitName)
           }
    }
    
    struct ListUnitNameResponse: Codable {
        var error: String = ""
        var _listUnitName : [ListUnitName]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _listUnitName
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._listUnitName = try container.decodeIfPresent([ListUnitName].self, forKey: ._listUnitName) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_listUnitName, forKey: ._listUnitName)
            }
    }
    
}
