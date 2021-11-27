//
//  IncomeTaxViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 27/11/21.
//

import UIKit

class IncomeTaxViewController: UIViewController {
    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var bodyView: IncomeTaxView!
    @IBOutlet weak var footerView: CommonFooter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bodyView.taxUnderBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.taxUnderBgView.layer.borderWidth = 0.5
        self.bodyView.taxUnderBgView.layer.cornerRadius = 20
        
        self.bodyView.taxBgView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        self.bodyView.taxBgView.layer.borderWidth = 0.5
        self.bodyView.taxBgView.layer.cornerRadius = 20
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
