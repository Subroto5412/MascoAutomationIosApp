//
//  TrackingListDetailsModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct DispatchDetailsList: Codable {
    
    var itemName: String = ""
    var buyerName: String = ""
    var uom: String = ""
    var quantity: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case itemName = "itemName"
        case buyerName = "buyerName"
        case uom = "uom"
        case quantity = "quantity"
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.itemName = try container.decodeIfPresent(String.self, forKey: .itemName) ?? ""
           self.buyerName = try container.decodeIfPresent(String.self, forKey: .buyerName) ?? ""
           self.uom = try container.decodeIfPresent(String.self, forKey: .uom) ?? ""
           self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity) ?? 0.0
       }

       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(itemName, forKey: .itemName)
           try container.encode(buyerName, forKey: .buyerName)
           try container.encode(uom, forKey: .uom)
           try container.encode(quantity, forKey: .quantity)
       }
}

struct DispatchDate: Codable {
    var trackingNumber: String = ""
    var attentationPerson: String = ""
    var deliveryAddress: String = ""
    var dispatchType: String = ""
    var department: String = ""
    var marchendiser: String = ""
    var mobile: String = ""
    var _dispatchDetails: [DispatchDetailsList]
    
    enum CodingKeys: String, CodingKey {
        case trackingNumber = "trackingNumber"
        case attentationPerson = "attentationPerson"
        case deliveryAddress = "deliveryAddress"
        case dispatchType = "dispatchType"
        case department = "department"
        case marchendiser = "marchendiser"
        case mobile = "mobile"
        case _dispatchDetails = "_dispatchDetails"
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.trackingNumber = try container.decodeIfPresent(String.self, forKey: .trackingNumber) ?? ""
           self.attentationPerson = try container.decodeIfPresent(String.self, forKey: .attentationPerson) ?? ""
           self.deliveryAddress = try container.decodeIfPresent(String.self, forKey: .deliveryAddress) ?? ""
           self.dispatchType = try container.decodeIfPresent(String.self, forKey: .dispatchType) ?? ""
           self.department = try container.decodeIfPresent(String.self, forKey: .department) ?? ""
           self.marchendiser = try container.decodeIfPresent(String.self, forKey: .marchendiser) ?? ""
           self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
           self._dispatchDetails = try container.decodeIfPresent([DispatchDetailsList].self, forKey: ._dispatchDetails) ?? []
       }

       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(trackingNumber, forKey: .trackingNumber)
           try container.encode(attentationPerson, forKey: .attentationPerson)
           try container.encode(deliveryAddress, forKey: .deliveryAddress)
           try container.encode(dispatchType, forKey: .dispatchType)
           try container.encode(department, forKey: .department)
           try container.encode(marchendiser, forKey: .marchendiser)
           try container.encode(mobile, forKey: .mobile)
           try container.encode(_dispatchDetails, forKey: ._dispatchDetails)
       }
}

struct TrackingListDetailsResponse: Codable {
    var error: String = ""
    var success: Bool = false
    var getDispatch : DispatchDate

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case success = "success"
        case getDispatch
    }
    
     init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self.success = try container.decodeIfPresent(Bool.self, forKey: .success)!
            self.getDispatch = try container.decodeIfPresent(DispatchDate.self, forKey: .getDispatch)!
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(success, forKey: .success)
            try container.encode(getDispatch, forKey: .getDispatch)
        }
}

struct TrackingNoConfirmResponse: Codable {
    var error: String = ""
    var success: Bool = false
    var message : String = ""

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case success = "success"
        case message = "message"
    }
    
     init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self.success = try container.decodeIfPresent(Bool.self, forKey: .success)!
            self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(success, forKey: .success)
            try container.encode(message, forKey: .message)
        }
}
