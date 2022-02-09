//
//  BWPDUnitModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct BWPDUnitName: Codable {
    var unitNo: Int?
    var unitName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case unitNo = "unitNo"
        case unitName = "unitEName"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.unitNo = try container.decodeIfPresent(Int.self, forKey: .unitNo) ?? 0
           self.unitName = try container.decodeIfPresent(String.self, forKey: .unitName) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(unitNo, forKey: .unitNo)
           try container.encode(unitName, forKey: .unitName)
       }
}

struct BWPDUnitNameResponse: Codable {
    var error: String = ""
    var _listUnitName : [BWPDUnitName]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _listUnitName
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._listUnitName = try container.decodeIfPresent([BWPDUnitName].self, forKey: ._listUnitName) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_listUnitName, forKey: ._listUnitName)
        }
}
