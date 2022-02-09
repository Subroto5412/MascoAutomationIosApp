//
//  QrPopUpModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation



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
