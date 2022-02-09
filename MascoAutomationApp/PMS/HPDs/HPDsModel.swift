//
//  HPDsModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct HPDsRequest: Codable {
    var unit_no: Int?
    var created_date: String = ""
    
    enum CodingKeys: String, CodingKey {
        case unit_no = "unit_no"
        case created_date = "created_date"
    }
}

struct ProductionDetails: Codable {
    
    var timeSlot: String = ""
    var cutting: Int?
    var swingOutput: Int?
    var lineInput: Int?
    var iron: Int?
    var folder: Int?
    var ploy: Int?
    var cartoon: Int?
    
    enum CodingKeys: String, CodingKey {
        case timeSlot = "timeSlot"
        case cutting = "cutting"
        case swingOutput = "swingOutput"
        case lineInput = "lineInput"
        case iron = "iron"
        case folder = "folder"
        case ploy = "ploy"
        case cartoon = "cartoon"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.timeSlot = try container.decodeIfPresent(String.self, forKey: .timeSlot) ?? ""
           self.cutting = try container.decodeIfPresent(Int.self, forKey: .cutting) ?? 0
           self.swingOutput = try container.decodeIfPresent(Int.self, forKey: .swingOutput) ?? 0
           self.lineInput = try container.decodeIfPresent(Int.self, forKey: .lineInput) ?? 0
           self.iron = try container.decodeIfPresent(Int.self, forKey: .iron) ?? 0
           self.folder = try container.decodeIfPresent(Int.self, forKey: .folder) ?? 0
           self.ploy = try container.decodeIfPresent(Int.self, forKey: .ploy) ?? 0
           self.cartoon = try container.decodeIfPresent(Int.self, forKey: .cartoon) ?? 0
        
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(timeSlot, forKey: .timeSlot)
           try container.encode(cutting, forKey: .cutting)
           try container.encode(swingOutput, forKey: .swingOutput)
           try container.encode(lineInput, forKey: .lineInput)
           try container.encode(iron, forKey: .iron)
           try container.encode(folder, forKey: .folder)
           try container.encode(ploy, forKey: .ploy)
           try container.encode(cartoon, forKey: .cartoon)
       }
}

struct HPDsResponse: Codable {
    var error: String = ""
    var _productionDetailsList : [ProductionDetails]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _productionDetailsList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._productionDetailsList = try container.decodeIfPresent([ProductionDetails].self, forKey: ._productionDetailsList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_productionDetailsList, forKey: ._productionDetailsList)
        }
}
