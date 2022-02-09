//
//  HPDModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct HourWiseDataRequest: Codable {
    var unit_no: Int?
    var created_date: String = ""
    
    enum CodingKeys: String, CodingKey {
        case unit_no = "unit_no"
        case created_date = "created_date"
    }
}

struct HourWiseData: Codable {
    var output: Int?
    var hour: String = ""
    
    enum CodingKeys: String, CodingKey {
        case output = "output"
        case hour = "hour"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.output = try container.decodeIfPresent(Int.self, forKey: .output) ?? 0
           self.hour = try container.decodeIfPresent(String.self, forKey: .hour) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(output, forKey: .output)
           try container.encode(hour, forKey: .hour)
       }
}

struct HourWiseDataResponse: Codable {
    var error: String = ""
    var _hourWiseDataList : [HourWiseData]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _hourWiseDataList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._hourWiseDataList = try container.decodeIfPresent([HourWiseData].self, forKey: ._hourWiseDataList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_hourWiseDataList, forKey: ._hourWiseDataList)
        }
}
