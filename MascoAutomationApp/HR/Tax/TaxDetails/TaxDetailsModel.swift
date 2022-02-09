//
//  TaxDetailsModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct ListTaxYear: Codable {
    var taxYearNo: Int?
    var yearName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case taxYearNo = "taxYearNo"
        case yearName = "yearName"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.taxYearNo = try container.decodeIfPresent(Int.self, forKey: .taxYearNo) ?? 0
           self.yearName = try container.decodeIfPresent(String.self, forKey: .yearName) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(taxYearNo, forKey: .taxYearNo)
           try container.encode(yearName, forKey: .yearName)
       }
}

struct ListTaxYearResponse: Codable {
    var error: String = ""
    var _taxYearList : [ListTaxYear]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _taxYearList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._taxYearList = try container.decodeIfPresent([ListTaxYear].self, forKey: ._taxYearList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_taxYearList, forKey: ._taxYearList)
        }
}

struct TaxDeductRequest: Codable {
    var taxYearNo: Int?
    
    enum CodingKeys: String, CodingKey {
        case taxYearNo = "taxYearNo"
    }
}

struct ListTaxDeduct: Codable {
    var taxMonthNo: Int?
    var monthYear: String = ""
    var taxDeductionAmount: Double?
    
    enum CodingKeys: String, CodingKey {
        case taxMonthNo = "taxMonthNo"
        case monthYear = "monthYear"
        case taxDeductionAmount = "taxDeductionAmount"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.taxMonthNo = try container.decodeIfPresent(Int.self, forKey: .taxMonthNo) ?? 0
           self.monthYear = try container.decodeIfPresent(String.self, forKey: .monthYear) ?? ""
           self.taxDeductionAmount = try container.decodeIfPresent(Double.self, forKey: .taxDeductionAmount) ?? 0.0
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(taxMonthNo, forKey: .taxMonthNo)
           try container.encode(monthYear, forKey: .monthYear)
           try container.encode(taxDeductionAmount, forKey: .taxDeductionAmount)
       }
}

struct ListTaxDeductResponse: Codable {
    var error: String = ""
    var _taxDeductionsList : [ListTaxDeduct]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _taxDeductionsList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._taxDeductionsList = try container.decodeIfPresent([ListTaxDeduct].self, forKey: ._taxDeductionsList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_taxDeductionsList, forKey: ._taxDeductionsList)
        }
}
