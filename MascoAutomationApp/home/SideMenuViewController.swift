//
//  SideMenuViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 24/11/21.
//

import UIKit

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func mascoWebBtn(_ sender: Any) {
        if let url = URL(string: "https://www.mascoknit.com/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func facebookBtn(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/mascofamily/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func youtubeBtn(_ sender: Any) {
        if let url = URL(string: "https://www.youtube.com/channel/UCc98wa0Vj7KcXYZPhRKxvgw") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func linkedInBtn(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com/company/masco-group-bangladesh") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func twitterBtn(_ sender: Any) {
        if let url = URL(string: "https://twitter.com/Masco_Group") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func instagramBtn(_ sender: Any) {
        if let url = URL(string: "https://www.instagram.com/mascogroupbd") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func outputBtn(_ sender: Any) {
        let utils = Utils()
        utils.writeAnyData(key: "empCode", value: "")
        
        self.dismiss(animated: true, completion: nil)
        let controller = ViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
}
