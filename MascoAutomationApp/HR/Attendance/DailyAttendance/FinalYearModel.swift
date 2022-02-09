//
//  FinalYearModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct FinalYear: Codable {
    var finalYearNo: Int?
    var finalYearName: String = ""
    var yearName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case finalYearNo = "finalYearNo"
        case finalYearName = "finalYearName"
        case yearName = "yearName"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.finalYearNo = try container.decodeIfPresent(Int.self, forKey: .finalYearNo) ?? 0
           self.finalYearName = try container.decodeIfPresent(String.self, forKey: .finalYearName) ?? ""
           self.yearName = try container.decodeIfPresent(String.self, forKey: .yearName) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(finalYearNo, forKey: .finalYearNo)
           try container.encode(finalYearName, forKey: .finalYearName)
           try container.encode(yearName, forKey: .yearName)
       }
}

struct FinalYearResponse: Codable {
    var error: String = ""
    var _listFinalYear : [FinalYear]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _listFinalYear
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._listFinalYear = try container.decodeIfPresent([FinalYear].self, forKey: ._listFinalYear) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_listFinalYear, forKey: ._listFinalYear)
        }
}
