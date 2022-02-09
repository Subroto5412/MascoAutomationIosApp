//
//  BWPDModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct BWPDRequest: Codable {
    var unit_no: Int?
    var created_date: String = ""
    
    enum CodingKeys: String, CodingKey {
        case unit_no = "unit_no"
        case created_date = "created_date"
    }
}

struct BuyerWiseData: Codable {
    
    var buyerName: String = ""
    var orderNo: String = ""
    var styleNo: String = ""
    var buyerId: Int?
    var styleId: Int?
    var buyerReferenceId: Int?
    var orderQty: Int?
    var sewingQty: Int?
    var balance: Int?
    
    enum CodingKeys: String, CodingKey {
        case buyerName = "buyerName"
        case orderNo = "orderNo"
        case styleNo = "styleNo"
        case buyerId = "buyerId"
        case styleId = "styleId"
        case buyerReferenceId = "buyerReferenceId"
        case orderQty = "orderQty"
        case sewingQty = "sewingQty"
        case balance = "balance"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.buyerName = try container.decodeIfPresent(String.self, forKey: .buyerName) ?? ""
           self.orderNo = try container.decodeIfPresent(String.self, forKey: .orderNo) ?? ""
           self.styleNo = try container.decodeIfPresent(String.self, forKey: .styleNo) ?? ""
           self.buyerId = try container.decodeIfPresent(Int.self, forKey: .buyerId) ?? 0
           self.styleId = try container.decodeIfPresent(Int.self, forKey: .styleId) ?? 0
           self.buyerReferenceId = try container.decodeIfPresent(Int.self, forKey: .buyerReferenceId) ?? 0
           self.orderQty = try container.decodeIfPresent(Int.self, forKey: .orderQty) ?? 0
           self.sewingQty = try container.decodeIfPresent(Int.self, forKey: .sewingQty) ?? 0
           self.balance = try container.decodeIfPresent(Int.self, forKey: .balance) ?? 0
        
        
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(buyerName, forKey: .buyerName)
           try container.encode(orderNo, forKey: .orderNo)
           try container.encode(styleNo, forKey: .styleNo)
           try container.encode(buyerId, forKey: .buyerId)
           try container.encode(styleId, forKey: .styleId)
           try container.encode(buyerReferenceId, forKey: .buyerReferenceId)
           try container.encode(orderQty, forKey: .orderQty)
           try container.encode(sewingQty, forKey: .sewingQty)
           try container.encode(balance, forKey: .balance)
       }
}

struct ListBWPDResponse: Codable {
    var error: String = ""
    var _listBuyerWiseData : [BuyerWiseData]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _listBuyerWiseData
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._listBuyerWiseData = try container.decodeIfPresent([BuyerWiseData].self, forKey: ._listBuyerWiseData) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_listBuyerWiseData, forKey: ._listBuyerWiseData)
        }
}
