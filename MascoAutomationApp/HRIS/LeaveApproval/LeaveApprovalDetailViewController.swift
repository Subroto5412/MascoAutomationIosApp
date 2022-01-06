//
//  LeaveApprovalDetailViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/12/21.
//

import UIKit

class LeaveApprovalDetailViewController: UIViewController {

    @IBOutlet weak var leaveApprovalDetailsTableView: UITableView!
    @IBOutlet weak var approvalView: ApprovalBgView!
    @IBOutlet weak var headerView: CommonHeaderView!
    
    class func initWithStoryboard() -> LeaveApprovalDetailViewController
    {
        let storyboard = UIStoryboard(name: "HRIS", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LeaveApprovalDetailViewController.className) as! LeaveApprovalDetailViewController
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.leaveApprovalDetailsTableView.register(UINib(nibName: "LeaveApprovalItemViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        leaveApprovalDetailsTableView.delegate = self
        leaveApprovalDetailsTableView.dataSource = self
        
        self.approvalView.approvedBtnView.layer.cornerRadius = 20.0;
        self.approvalView.rejectBtnView.layer.cornerRadius = 20.0;
        
        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    
    func showBackController(){
        let controller = LeaveApprovalViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
}

extension LeaveApprovalDetailViewController :  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaveApprovalItemViewCell
        cell.idLbl.text = "1"
        cell.nameLbl.text = "Subroto"
        cell.designationLbl.text = "Asst. Manager"
    
        cell.fromDateLbl.text = "18-09-2021"
        cell.toDateLbl.text = "18-09-2021"
        cell.leaveLbl.text = "Bl - 6 Days"
        cell.balanceLbl.text = "18-09-2021"
        cell.totalDaysLbl.text = "AP - 1 Day"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
