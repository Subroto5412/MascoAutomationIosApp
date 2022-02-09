//
//  TrackingListModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation



struct TrackingList: Codable {
    
    var trackingNo: String = ""
    var sendToAddress: String = ""
    
    enum CodingKeys: String, CodingKey {
        case trackingNo = "trackingNo"
        case sendToAddress = "sendToAddress"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.trackingNo = try container.decodeIfPresent(String.self, forKey: .trackingNo) ?? ""
           self.sendToAddress = try container.decodeIfPresent(String.self, forKey: .sendToAddress) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(trackingNo, forKey: .trackingNo)
           try container.encode(sendToAddress, forKey: .sendToAddress)
       }
}

struct TrackingListResponse: Codable {
    var error: String = ""
    var success: Bool = false
    var _trackingList : [TrackingList]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case success = "success"
        case _trackingList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self.success = try container.decodeIfPresent(Bool.self, forKey: .success)!
            self._trackingList = try container.decodeIfPresent([TrackingList].self, forKey: ._trackingList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(success, forKey: .success)
            try container.encode(_trackingList, forKey: ._trackingList)
        }
}
