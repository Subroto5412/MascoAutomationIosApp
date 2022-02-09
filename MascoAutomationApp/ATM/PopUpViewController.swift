//
//  PopUpViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 20/1/22.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var assetNoLbl: UILabel!
    @IBOutlet weak var assetNameLbl: UILabel!
    @IBOutlet weak var unitLbl: UILabel!
    @IBOutlet weak var purchaseDateLbl: UILabel!
    @IBOutlet weak var purchaseValueLbl: UILabel!
    @IBOutlet weak var assetEntryDateLbl: UILabel!
    
    @IBOutlet weak var popupViewBg: UIView!
    
    @IBOutlet weak var scanAnotherQR: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    var vSpinner : UIView?
    class func initWithStoryboard() -> PopUpViewController
    {
        let storyboard = UIStoryboard(name: "ATM", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: PopUpViewController.className) as! PopUpViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.uiViewDesign()
        getQRCoder(qrCode: QRCODE)
    }
    
    @IBAction func scanAnotherQRBtn(_ sender: Any) {
        
         self.dismiss(animated: true, completion: nil)
        let controller = QRCodeScannerViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
        
    }
    @IBAction func cancelBtn(_ sender: Any) {
        let controller = ATMViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
        
    }
}

extension PopUpViewController {
    
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

extension PopUpViewController{
 
    func uiViewDesign(){
        self.popupViewBg.layer.cornerRadius = 5
        self.scanAnotherQR.layer.cornerRadius = 20
        self.cancel.layer.cornerRadius = 20
    }
    
    func getQRCoder(qrCode: String){
        
        let url = URL(string: ATM_QRCODE_READ_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTodoItem = QRCodeRequest(qr_code: qrCode)
        let jsonData = try? JSONEncoder().encode(newTodoItem)
    
        request.httpBody = jsonData
        
        self.showSpinner(onView: self.view)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                self.removeSpinner()
                DispatchQueue.main.async {
                        
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        let itemModel = try JSONDecoder().decode(QRCodeDataResponse.self, from: data)
                       
                        self.assetNoLbl.text = itemModel.assetDataDetails.assetNo
                        self.assetNameLbl.text = itemModel.assetDataDetails.assetName
                        self.unitLbl.text = itemModel.assetDataDetails.unitName
                        self.purchaseDateLbl.text = itemModel.assetDataDetails.purchaseDate
                        self.purchaseValueLbl.text = "\(String(describing: itemModel.assetDataDetails.purchaseValue!))"
                        self.assetEntryDateLbl.text = itemModel.assetDataDetails.assetEntryDate
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                }
        }
        task.resume()
       // })
    }
}
