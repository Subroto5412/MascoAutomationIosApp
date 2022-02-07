//
//  SideMenuViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 24/11/21.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var customerIdLbl: UILabel!
    @IBOutlet weak var unitName: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    
    @IBOutlet weak var profilePicImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let utils = Utils()
        self.nameLbl.text = utils.readStringData(key: "empName")
        self.customerIdLbl.text = utils.readStringData(key: "empCode")
        self.mobileLbl.text = utils.readStringData(key: "mobile")
        self.unitName.text = utils.readStringData(key: "unitName")
        
        
        
        let urlLinkPhoto = (PHOTO_LINK_URL+utils.readStringData(key: "photo"))
        let photoUrl =  URL(string: urlLinkPhoto)!

        if let data = try? Data(contentsOf: photoUrl) {
                // Create Image and Update Image View
            self.profilePicImg.image = UIImage(data: data)
            self.profilePicImg.setRounded()
            let skyBlueColor = UIColor(red: 104/255.0, green: 156/255.0, blue: 255/255.0, alpha: 1.0)
            self.profilePicImg.layer.borderWidth = 2.0
            self.profilePicImg.layer.borderColor = skyBlueColor.cgColor
            }
        
        
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
        utils.writeAnyData(key: "photo", value: "")
        utils.writeAnyData(key: "empName", value: "")
        utils.writeAnyData(key: "unitName", value: "")
        utils.writeAnyData(key: "token", value: "")
        utils.writeAnyData(key: "GPMSModule", value: "")
        utils.writeAnyData(key: "HRModule", value: "")
        utils.writeAnyData(key: "SCMModule", value: "")
        utils.writeAnyData(key: "BWPD", value: "")
        utils.writeAnyData(key: "HPD", value: "")
        utils.writeAnyData(key: "HPDs", value: "")
        utils.writeAnyData(key: "LWP", value: "")
        utils.writeAnyData(key: "DA", value: "")
        utils.writeAnyData(key: "LH", value: "")
        utils.writeAnyData(key: "TH", value: "")
        
//        self.dismiss(animated: true, completion: nil)
        let controller = ViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
}
