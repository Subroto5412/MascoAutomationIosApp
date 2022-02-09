//
//  OTPModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct OTPSendRequest: Codable {
    var empId: String = ""
    
    enum CodingKeys: String, CodingKey {
        case empId = "empId"
    }
}

struct OTPSendResponse: Codable {
    var response: Bool?
    var error: String = ""
    var message: String = ""
    var data: String = ""
    var token: String = ""
    var image_name: String = ""
    var user_entry_id: Int?
    var mobile: String = ""
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
        case error = "error"
        case message = "message"
        case data = "data"
        case token = "token"
        case image_name = "image_name"
        case user_entry_id = "user_entry_id"
        case mobile = "mobile"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.response = try container.decodeIfPresent(Bool.self, forKey: .response)
           self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
           self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
           self.data = try container.decodeIfPresent(String.self, forKey: .data) ?? ""
           self.token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
           self.image_name = try container.decodeIfPresent(String.self, forKey: .image_name) ?? ""
           self.user_entry_id = try container.decodeIfPresent(Int.self, forKey: .user_entry_id) ?? 0
           self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(response, forKey: .response)
           try container.encode(error, forKey: .error)
           try container.encode(message, forKey: .message)
           try container.encode(data, forKey: .data)
           try container.encode(token, forKey: .token)
           try container.encode(image_name, forKey: .image_name)
           try container.encode(user_entry_id, forKey: .user_entry_id)
           try container.encode(mobile, forKey: .mobile)
       }
}
