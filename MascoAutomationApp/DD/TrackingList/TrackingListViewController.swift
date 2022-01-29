//
//  TrackingListViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/1/22.
//

import UIKit

class TrackingListViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: CommonFooter!
    var dataSource = [TrackingList]()
    
    class func initWithStoryboard() -> TrackingListViewController
    {
        let storyboard = UIStoryboard(name: "DD", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TrackingListViewController.className) as! TrackingListViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Tracking List"
        
        self.tableView.register(UINib(nibName: "TrackingListViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    func getTrackingList(){
        
        let url = URL(string: TRACKING_LIST_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                        let itemModel = try JSONDecoder().decode(TrackingListResponse.self, from: data)
                        self.dataSource = itemModel._trackingList
                        
                        self.tableView.reloadData()
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                    })
                }
        }
        task.resume()
        })
    }
    
}

extension TrackingListViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = TrackingListDetailsViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}

extension TrackingListViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrackingListViewCell
        cell.trackingNoLbl.text = "101407"
        cell.addressLbl.text = "Paradise Tower. Level #03, Plot #11, Road #02, Sector #03. Uttara, Dhaka 1230."
        
        return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension TrackingListViewController {

    struct TrackingList: Codable {
        
        var trackingNo: String = ""
        var sendToAddress: String = ""
        
        enum CodingKeys: String, CodingKey {
            case trackingNo = "trackingNo"
            case sendToAddress = "sendToAddress"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.trackingNo = try container.decodeIfPresent(String.self, forKey: .trackingNo) ?? ""
               self.sendToAddress = try container.decodeIfPresent(String.self, forKey: .sendToAddress) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(trackingNo, forKey: .trackingNo)
               try container.encode(sendToAddress, forKey: .sendToAddress)
           }
    }
    
    struct TrackingListResponse: Codable {
        var error: String = ""
        var success: Bool = false
        var _trackingList : [TrackingList]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case success = "success"
            case _trackingList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self.success = try container.decodeIfPresent(Bool.self, forKey: .success)!
                self._trackingList = try container.decodeIfPresent([TrackingList].self, forKey: ._trackingList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(success, forKey: .success)
                try container.encode(_trackingList, forKey: ._trackingList)
            }
    }
}

extension TrackingListViewController {
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
