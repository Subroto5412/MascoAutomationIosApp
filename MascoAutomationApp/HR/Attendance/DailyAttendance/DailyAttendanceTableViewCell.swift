//
//  DailyAttendanceTableViewCell.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 7/12/21.
//

import UIKit

class DailyAttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var punchInLbl: UILabel!
    @IBOutlet weak var punchOutLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var otLbl: UILabel!
    @IBOutlet weak var dateBgView: UIView!
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    
    var dataSource: DailyAttendanceViewControllerDetails.ListAttendanceDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dateBgView.layer.borderColor =  UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.dateBgView.layer.borderWidth = 0.05
        self.dateBgView.layer.cornerRadius = 30
        
        self.cellBgView.layer.borderColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0).cgColor
        self.cellBgView.layer.borderWidth = 0.5
        self.cellBgView.layer.cornerRadius = 15
    }
    
    
    func setInformation(withItem item: DailyAttendanceViewControllerDetails.ListAttendanceDetails?, formattedDate: String){
        self.dataSource = item
        
        statusLbl.text = dataSource!.fSts
        otLbl.text = dataSource!.additionalTime
        punchInLbl.text = dataSource!.punchInTime
        punchInLbl.text = dataSource!.punchOutTime
        dayLbl.text = String(dataSource!.datePunch.prefix(2))
        
        let monthString:String = dataSource!.datePunch
        monthLbl.text = monthString.substring(with: 3..<6)
        
        if dataSource!.punchInTime == "12:00:00 AM" {
            punchInLbl.text = "0" }else{
            punchInLbl.text = dataSource!.punchInTime
        }

        if dataSource!.punchOutTime == "12:00:00 AM" {
            punchOutLbl.text = "0" }else{
            punchOutLbl.text = dataSource!.punchOutTime
        }
        
        if dataSource!.fSts == "SL"{
            dateBgView.backgroundColor = UIColor(red: 255/255, green: 84/255, blue: 85/255, alpha: 1.0)
        }
        else if dataSource!.fSts == "CL"{
            dateBgView.backgroundColor = UIColor(red: 255/255, green: 84/255, blue: 85/255, alpha: 1.0)
        }
        else if dataSource!.fSts == "EL"{
            dateBgView.backgroundColor = UIColor(red: 255/255, green: 84/255, blue: 85/255, alpha: 1.0)
        }
        else if dataSource!.fSts == "LWP"{
            dateBgView.backgroundColor = UIColor(red: 255/255, green: 84/255, blue: 85/255, alpha: 1.0)
        }else {
            
            if dataSource!.datePunch == formattedDate {
                dateBgView.backgroundColor = UIColor(red: 90/255, green: 236/255, blue: 129/255, alpha: 1.0)
            }
            else {
                dateBgView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
            }
        }
            
        if dataSource!.fSts == "WHD" || dataSource!.fSts == "GHD" ||
            dataSource!.fSts == "CHD" || dataSource!.fSts == "QO"{
                statusLbl.textColor = UIColor(red: 255/255, green: 84/255, blue: 85/255, alpha: 1.0)
            }else {
                statusLbl.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
            }
    }
}
