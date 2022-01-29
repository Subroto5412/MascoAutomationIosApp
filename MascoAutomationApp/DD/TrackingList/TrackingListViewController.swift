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

