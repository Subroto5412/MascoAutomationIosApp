//
//  TrackingListViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/1/22.
//

import UIKit

class TrackingListViewController: UIViewController {

    @IBOutlet weak var headerView: InnerHeader!
    //   @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: CommonFooter!
    var dataSource = [TrackingList]()
    var vSpinner : UIView?
    
    class func initWithStoryboard() -> TrackingListViewController
    {
        let storyboard = UIStoryboard(name: "DD", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TrackingListViewController.className) as! TrackingListViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.commonSearchTxtField.addTarget(self, action: #selector(searchRecord), for: .editingChanged)
        
        self.hideKeyboardWhenTappedAround()
        self.nidRegister()
        self.getTrackingList(trackingNo: self.headerView.commonSearchTxtField.text!)
        navigationLinking()
        self.headerView.searchBgView.layer.cornerRadius = 10
    }
    
    @objc func searchRecord(sender:UITextField ){

        print(self.headerView.commonSearchTxtField.text as Any)
        
        if ((self.headerView.commonSearchTxtField.text?.isEmpty) != nil) {
            
            self.getTrackingList(trackingNo: self.headerView.commonSearchTxtField.text!)
            
        }else{
            if ((self.headerView.commonSearchTxtField.text!.count) > 1){
                self.getTrackingList(trackingNo: self.headerView.commonSearchTxtField.text!)
            }
        }
    }
}

extension TrackingListViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TrackingNo = dataSource[indexPath.row].trackingNo
        let controller = TrackingListDetailsViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}

extension TrackingListViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrackingListViewCell
        cell.trackingNoLbl.text = dataSource[indexPath.row].trackingNo
        cell.addressLbl.text = dataSource[indexPath.row].sendToAddress
        
        return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension TrackingListViewController {
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

extension TrackingListViewController{
    func nidRegister(){
        self.tableView.register(UINib(nibName: "TrackingListViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TrackingListViewController {
    
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
        let controller = DDViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}

extension TrackingListViewController {
    
    func getTrackingList(trackingNo:String){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        let url = URL(string: TRACKING_LIST_URL+trackingNo)
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
                        let controller = ViewController.initWithStoryboard()
                        self.present(controller, animated: true, completion: nil);
                        return
                    }
                    guard let data = data else {return}
                    do{
                        let itemModel = try JSONDecoder().decode(TrackingListResponse.self, from: data)
                        self.dataSource = itemModel._trackingList
                        
                        self.tableView.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
    }
}
