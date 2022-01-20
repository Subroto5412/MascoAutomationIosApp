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

        self.popupViewBg.layer.cornerRadius = 5
        self.scanAnotherQR.layer.cornerRadius = 20
        self.cancel.layer.cornerRadius = 20
        
        print("--QRCODE-----\(QRCODE)")
        getQRCoder(qrCode: QRCODE)
    }
    
    @IBAction func scanAnotherQRBtn(_ sender: Any) {
        
         self.dismiss(animated: true, completion: nil)
        let controller = QRCodeScannerViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
        
    }
    @IBAction func cancelBtn(_ sender: Any) {
     //   self.dismiss(animated: true, completion: nil)
        let controller = ATMViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
        
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

extension PopUpViewController {
    
    struct QRCodeRequest: Codable {
        var qr_code: String = ""
        
        enum CodingKeys: String, CodingKey {
            case qr_code = "qr_code"
        }
    }
    
    struct QRCodeData: Codable {
       
        var assetNo: String = ""
        var assetName: String = ""
        var unitName: String = ""
        var purchaseDate: String = ""
        var purchaseValue: Double?
        var assetEntryDate: String = ""
        
        enum CodingKeys: String, CodingKey {
            case assetNo = "assetNo"
            case assetName = "assetName"
            case unitName = "unitName"
            case purchaseDate = "purchaseDate"
            case purchaseValue = "purchaseValue"
            case assetEntryDate = "assetEntryDate"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.assetNo = try container.decodeIfPresent(String.self, forKey: .assetNo) ?? ""
               self.assetName = try container.decodeIfPresent(String.self, forKey: .assetName) ?? ""
               self.unitName = try container.decodeIfPresent(String.self, forKey: .unitName) ?? ""
               self.purchaseDate = try container.decodeIfPresent(String.self, forKey: .purchaseDate) ?? ""
            self.purchaseValue = try container.decodeIfPresent(Double.self, forKey: .purchaseValue) ?? 0.0
               self.assetEntryDate = try container.decodeIfPresent(String.self, forKey: .assetEntryDate) ?? ""
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(assetNo, forKey: .assetNo)
               try container.encode(assetName, forKey: .assetName)
               try container.encode(unitName, forKey: .unitName)
               try container.encode(purchaseDate, forKey: .purchaseDate)
               try container.encode(purchaseValue, forKey: .purchaseValue)
               try container.encode(assetEntryDate, forKey: .assetEntryDate)
           }
    }
    
    struct QRCodeDataResponse: Codable {
        var error: String = ""
        var assetDataDetails : QRCodeData

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case assetDataDetails
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self.assetDataDetails = try container.decodeIfPresent(QRCodeData.self, forKey: .assetDataDetails)!
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(assetDataDetails, forKey: .assetDataDetails)
            }
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
