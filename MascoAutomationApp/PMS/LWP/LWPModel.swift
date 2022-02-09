//
//  LWPModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct LineWiseDataRequest: Codable {
    var unit_no: Int?
    var created_date: String = ""
    
    enum CodingKeys: String, CodingKey {
        case unit_no = "unit_no"
        case created_date = "created_date"
    }
}

struct LineWiseData: Codable {
    var goodGarments: Int?
    var lineName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case goodGarments = "goodGarments"
        case lineName = "lineName"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.goodGarments = try container.decodeIfPresent(Int.self, forKey: .goodGarments) ?? 0
           self.lineName = try container.decodeIfPresent(String.self, forKey: .lineName) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(goodGarments, forKey: .goodGarments)
           try container.encode(lineName, forKey: .lineName)
       }
}

struct ListLineWiseDataResponse: Codable {
    var error: String = ""
    var _lineWiseProduction : [LineWiseData]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _lineWiseProduction
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._lineWiseProduction = try container.decodeIfPresent([LineWiseData].self, forKey: ._lineWiseProduction) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_lineWiseProduction, forKey: ._lineWiseProduction)
        }
}
