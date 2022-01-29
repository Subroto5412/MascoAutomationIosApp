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
    
    class func initWithStoryboard() -> TrackingListDetailsViewController
    {
        let storyboard = UIStoryboard(name: "DD", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: TrackingListDetailsViewController.className) as! TrackingListDetailsViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.titleNameLbl.text = "Tracking List Details"
        
        self.doneBtnView.layer.cornerRadius = 20
        
        self.trackingTableView.slBgView.layer.borderColor = UIColor(red: 172/255, green: 227/255, blue: 255/255, alpha: 1.0).cgColor
        self.trackingTableView.slBgView.layer.borderWidth = 0.5
        self.trackingTableView.slBgView.layer.cornerRadius = 10
        
        self.trackingTableView.itemNameBgView.layer.borderColor = UIColor(red: 172/255, green: 227/255, blue: 255/255, alpha: 1.0).cgColor
        self.trackingTableView.itemNameBgView.layer.borderWidth = 0.5
        self.trackingTableView.itemNameBgView.layer.cornerRadius = 10
        
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
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    @IBAction func doneBtn(_ sender: Any) {
    }
    
    func showBackController(){
        let controller = TrackingListViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }

}


extension TrackingListDetailsViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension TrackingListDetailsViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrackingDetailsTableViewCell
        cell.slLbl.text = "1"
        cell.itemNameLbl.text = "PP Sample"
        cell.uomLbl.text = "Piece"
        cell.quantityLbl.text = "10"
        return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

