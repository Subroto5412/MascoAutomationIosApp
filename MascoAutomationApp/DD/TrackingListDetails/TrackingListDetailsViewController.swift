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
        self.uiViewDesign()
        self.nibRegister()
        self.getTrackingDetailsList()
        self.navigationLinking()
    }
    @IBAction func doneBtn(_ sender: Any) {
        showAlertAction()
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

extension TrackingListDetailsViewController {
    
    func uiViewDesign(){
        
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
    }
}

extension TrackingListDetailsViewController {
    func navigationLinking(){
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    
    func showBackController(){
        let controller = TrackingListViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}

extension TrackingListDetailsViewController {
    func nibRegister(){
        self.trackingTableView.tableView.register(UINib(nibName: "TrackingDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        trackingTableView.tableView.delegate = self
        trackingTableView.tableView.dataSource = self
    }
    
    func showAlertAction(){
        let alert = UIAlertController(title: "", message: "Do You Want to Delivery?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.getTrackingOnConfirm()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension TrackingListDetailsViewController{
    
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
}
