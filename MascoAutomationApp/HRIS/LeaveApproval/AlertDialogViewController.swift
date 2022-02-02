//
//  AlertDialogViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 2/2/22.
//

import UIKit
import YYCalendar

protocol AlertDialogDelegate {
    func updateBtnTapped(from: String, to: String)
    func fromDate(from: String)
}

class AlertDialogViewController: UIViewController {

    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var updateBtnView: UIButton!
    @IBOutlet weak var cancelBtnView: UIButton!
    
    @IBOutlet weak var dialogBgView: UIView!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    
    var delegate:AlertDialogDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateBtnView.layer.cornerRadius = 15
        self.cancelBtnView.layer.cornerRadius = 15
        
        self.fromView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.fromView.layer.borderWidth = 0.5
        self.fromView.layer.cornerRadius = 4
        
        self.toView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.toView.layer.borderWidth = 0.5
        self.toView.layer.cornerRadius = 4
        
        self.dialogBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.dialogBgView.layer.borderWidth = 0.5
        self.dialogBgView.layer.cornerRadius = 4
        
        self.fromLbl.text = _fromDate
        self.toLbl.text = _toDate
    }
    
    @IBAction func fromBtn(_ sender: Any) {
        let currentDate = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd MMM yyyy"
         
         let calendar = YYCalendar(normalCalendarLangType: .ENG3,
                                   date: dateFormatter.string(from: currentDate),
                                           format: "dd MMM yyyy") { [weak self] date in
        
            self?.fromLbl.text = date
         }
            calendar.sundayColor = UIColor.gray
            calendar.defaultDayColor = UIColor.gray
            calendar.saturdayColor = UIColor.gray
            
            calendar.show()
    }
    
    @IBAction func toBtn(_ sender: Any) {
        
        let currentDate = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd MMM yyyy"
         
         let calendar = YYCalendar(normalCalendarLangType: .ENG3,
                                   date: dateFormatter.string(from: currentDate),
                                           format: "dd MMM yyyy") { [weak self] date in
        
            self?.toLbl.text = date
         }
            calendar.sundayColor = UIColor.gray
            calendar.defaultDayColor = UIColor.gray
            calendar.saturdayColor = UIColor.gray
            
            calendar.show()
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        delegate?.updateBtnTapped(from: fromLbl.text!,to: toLbl.text!)
        delegate?.fromDate(from: fromLbl.text!)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
