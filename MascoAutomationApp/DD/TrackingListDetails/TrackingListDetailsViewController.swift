//
//  TrackingListDetailsViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/1/22.
//

import UIKit

class TrackingListDetailsViewController: UIViewController {
    @IBOutlet weak var headerView: CommonHeaderView!
    
    @IBOutlet weak var footerView: CommonFooter!
    @IBOutlet weak var trackingDetailBgView: TrackingDetailsBodyView!
    
    @IBOutlet weak var doneBtnView: UIButton!
    @IBOutlet weak var trackingTableView: TrackingTableBodyView!
    var vSpinner : UIView?
    var dataSource = [DispatchDetailsList]()
    
    class func initWithStoryboard() -> TrackingListDetailsViewController
    {
        let storyboard = UIStoryboard(name: "DD", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TrackingListDetailsViewController.className) as! TrackingListDetailsViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Tracking List Details"
        
        self.hideKeyboardWhenTappedAround()
        
        self.doneBtnView.layer.cornerRadius = 20
        
        self.trackingTableView.slBgView.layer.borderColor = UIColor(red: 172/255, green: 227/255, blue: 255/255, alpha: 1.0).cgColor
        self.trackingTableView.slBgView.layer.borderWidth = 0.5
        self.trackingTableView.slBgView.layer.cornerRadius = 10
        
        self.trackingTableView.itemNameBgView.layer.borderColor = UIColor(red: 172/255, green: 227/255, blue: 255/255, alpha: 1.0).cgColor
        self.trackingTableView.itemNameBgView.layer.borderWidth = 0.5
        self.trackingTableView.itemNameBgView.layer.cornerRadius = 10
        
        self.trackingTableView.buyerBgView.layer.borderColor = UIColor(red: 172/255, green: 227/255, blue: 255/255, alpha: 1.0).cgColor
        self.trackingTableView.buyerBgView.layer.borderWidth = 0.5
        self.trackingTableView.buyerBgView.layer.cornerRadius = 10
        
        self.trackingTableView.uomBgView.layer.borderColor = UIColor(red: 172/255, green: 227/255, blue: 255/255, alpha: 1.0).cgColor
        self.trackingTableView.uomBgView.layer.borderWidth = 0.5
        self.trackingTableView.uomBgView.layer.cornerRadius = 10
        
        self.trackingTableView.quantityBgView.layer.borderColor = UIColor(red: 172/255, green: 227/255, blue: 255/255, alpha: 1.0).cgColor
        self.trackingTableView.quantityBgView.layer.borderWidth = 0.5
        self.trackingTableView.quantityBgView.layer.cornerRadius = 10
        
        
        self.trackingDetailBgView.trackingDetailsBgView.layer.borderColor = UIColor(red: 172/255, green: 227/255, blue: 255/255, alpha: 1.0).cgColor
        self.trackingDetailBgView.trackingDetailsBgView.layer.borderWidth = 0.5
        self.trackingDetailBgView.trackingDetailsBgView.layer.cornerRadius = 10
        
        
        self.trackingTableView.tableView.register(UINib(nibName: "TrackingDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        trackingTableView.tableView.delegate = self
        trackingTableView.tableView.dataSource = self
        
        self.getTrackingDetailsList()
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    @IBAction func doneBtn(_ sender: Any) {
        
        showAlertAction()
    }
    
    func showBackController(){
        let controller = TrackingListViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

    func getTrackingDetailsList(){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        let url = URL(string: TRACKING_LIST_DETAILS_URL+TrackingNo)
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
         self.showSpinner(onView: self.view)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                self.removeSpinner()
                DispatchQueue.main.async {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let itemModel = try JSONDecoder().decode(TrackingListDetailsResponse.self, from: data)
                        self.dataSource = itemModel.getDispatch._dispatchDetails
                        self.trackingDetailBgView.trackingNoLbl.text = itemModel.getDispatch.trackingNumber
                        self.trackingDetailBgView.attentionPersonLbl.text = itemModel.getDispatch.attentationPerson
                        self.trackingDetailBgView.addressLbl.text = itemModel.getDispatch.deliveryAddress
                        self.trackingDetailBgView.dispatchTypeLbl.text = itemModel.getDispatch.dispatchType
                        self.trackingDetailBgView.departmentLbl.text = itemModel.getDispatch.department
                        self.trackingDetailBgView.merchandiseLbl.text = itemModel.getDispatch.marchendiser
                        self.trackingDetailBgView.mobileLbl.text = itemModel.getDispatch.mobile
                        
                        self.trackingTableView.tableView.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    
    func getTrackingOnConfirm(){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        let url = URL(string: TRACKING_ON_CONFIRM_URL+TrackingNo)
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
         self.showSpinner(onView: self.view)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                self.removeSpinner()
                DispatchQueue.main.async {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let itemModel = try JSONDecoder().decode(TrackingNoConfirmResponse.self, from: data)
                        if itemModel.success == true {
                            self.toastMessage(itemModel.message)
                            let controller = TrackingListViewController.initWithStoryboard()
                            self.present(controller, animated: true, completion: nil);
                        }else{
                            self.toastMessage(itemModel.message)
                        }
                    
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
    
    func showAlertAction(){
        let alert = UIAlertController(title: "", message: "Do You Want to Delivery?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
//            print("Action")
            self.getTrackingOnConfirm()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension TrackingListDetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension TrackingListDetailsViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrackingDetailsTableViewCell
       // var sl = indexPath.row+1
        cell.slLbl.text = "\(indexPath.row+1)"
        cell.itemNameLbl.text = dataSource[indexPath.row].itemName
        cell.buyerLbl.text = dataSource[indexPath.row].buyerName
        cell.uomLbl.text = dataSource[indexPath.row].uom
        cell.quantityLbl.text = "\(dataSource[indexPath.row].quantity)"
        return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}


extension TrackingListDetailsViewController {

    struct DispatchDetailsList: Codable {
        
        var itemName: String = ""
        var buyerName: String = ""
        var uom: String = ""
        var quantity: Double = 0.0
        
        enum CodingKeys: String, CodingKey {
            case itemName = "itemName"
            case buyerName = "buyerName"
            case uom = "uom"
            case quantity = "quantity"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.itemName = try container.decodeIfPresent(String.self, forKey: .itemName) ?? ""
               self.buyerName = try container.decodeIfPresent(String.self, forKey: .buyerName) ?? ""
               self.uom = try container.decodeIfPresent(String.self, forKey: .uom) ?? ""
               self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity) ?? 0.0
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(itemName, forKey: .itemName)
               try container.encode(buyerName, forKey: .buyerName)
               try container.encode(uom, forKey: .uom)
               try container.encode(quantity, forKey: .quantity)
           }
    }
    
    struct DispatchDate: Codable {
        
        var trackingNumber: String = ""
        var attentationPerson: String = ""
        var deliveryAddress: String = ""
        var dispatchType: String = ""
        var department: String = ""
        var marchendiser: String = ""
        var mobile: String = ""
        var _dispatchDetails: [DispatchDetailsList]
        
        enum CodingKeys: String, CodingKey {
            case trackingNumber = "trackingNumber"
            case attentationPerson = "attentationPerson"
            case deliveryAddress = "deliveryAddress"
            case dispatchType = "dispatchType"
            case department = "department"
            case marchendiser = "marchendiser"
            case mobile = "mobile"
            case _dispatchDetails = "_dispatchDetails"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.trackingNumber = try container.decodeIfPresent(String.self, forKey: .trackingNumber) ?? ""
               self.attentationPerson = try container.decodeIfPresent(String.self, forKey: .attentationPerson) ?? ""
               self.deliveryAddress = try container.decodeIfPresent(String.self, forKey: .deliveryAddress) ?? ""
               self.dispatchType = try container.decodeIfPresent(String.self, forKey: .dispatchType) ?? ""
               self.department = try container.decodeIfPresent(String.self, forKey: .department) ?? ""
               self.marchendiser = try container.decodeIfPresent(String.self, forKey: .marchendiser) ?? ""
               self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
               self._dispatchDetails = try container.decodeIfPresent([DispatchDetailsList].self, forKey: ._dispatchDetails) ?? []
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(trackingNumber, forKey: .trackingNumber)
               try container.encode(attentationPerson, forKey: .attentationPerson)
               try container.encode(deliveryAddress, forKey: .deliveryAddress)
               try container.encode(dispatchType, forKey: .dispatchType)
               try container.encode(department, forKey: .department)
               try container.encode(marchendiser, forKey: .marchendiser)
               try container.encode(mobile, forKey: .mobile)
               try container.encode(_dispatchDetails, forKey: ._dispatchDetails)
           }
    }
    
    struct TrackingListDetailsResponse: Codable {
        var error: String = ""
        var success: Bool = false
        var getDispatch : DispatchDate

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case success = "success"
            case getDispatch
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self.success = try container.decodeIfPresent(Bool.self, forKey: .success)!
                self.getDispatch = try container.decodeIfPresent(DispatchDate.self, forKey: .getDispatch)!
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(success, forKey: .success)
                try container.encode(getDispatch, forKey: .getDispatch)
            }
    }
    
    struct TrackingNoConfirmResponse: Codable {
        var error: String = ""
        var success: Bool = false
        var message : String = ""

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case success = "success"
            case message = "message"
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self.success = try container.decodeIfPresent(Bool.self, forKey: .success)!
                self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(success, forKey: .success)
                try container.encode(message, forKey: .message)
            }
    }
}

extension TrackingListDetailsViewController {
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
