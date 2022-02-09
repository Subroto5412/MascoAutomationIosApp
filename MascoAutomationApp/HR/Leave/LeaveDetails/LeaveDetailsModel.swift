//
//  LeaveDetailsModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct LeaveDetailRequestModel: Codable {
    var finalYear: Int
    
    enum CodingKeys: String, CodingKey {
        case finalYear = "finalYear"
    }
}

struct LeaveDetailsResponse: Codable {
    var error: String = ""
    var _LeaveHistoryformatList : [LeaveHistoryformatList]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _LeaveHistoryformatList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._LeaveHistoryformatList = try container.decodeIfPresent([LeaveHistoryformatList].self, forKey: ._LeaveHistoryformatList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_LeaveHistoryformatList, forKey: ._LeaveHistoryformatList)
        }

}

struct LeaveHistoryformatList: Codable {
    var type_name: String = ""
    var cl: String = ""
    var sl: String = ""
    var el: String = ""
    
    enum CodingKeys: String, CodingKey {
        case type_name = "type_name"
        case cl = "cl"
        case sl = "sl"
        case el = "el"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.type_name = try container.decodeIfPresent(String.self, forKey: .type_name) ?? ""
           self.cl = try container.decodeIfPresent(String.self, forKey: .cl) ?? ""
           self.sl = try container.decodeIfPresent(String.self, forKey: .sl) ?? ""
           self.el = try container.decodeIfPresent(String.self, forKey: .el) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(type_name, forKey: .type_name)
           try container.encode(cl, forKey: .cl)
           try container.encode(sl, forKey: .sl)
           try container.encode(el, forKey: .el)
       }
}

//AVail History Summary
struct AvailHistorySummaryList: Codable {
    var leaveType: String = ""
    var availDays: Int?
    var approveFromDate: String = ""
    var approveToDate: String = ""
    var applicationDate: String = ""
    
    enum CodingKeys: String, CodingKey {
        case leaveType = "leaveType"
        case availDays = "availDays"
        case approveFromDate = "approveFromDate"
        case approveToDate = "approveToDate"
        case applicationDate = "applicationDate"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.leaveType = try container.decodeIfPresent(String.self, forKey: .leaveType) ?? ""
           self.availDays = try container.decodeIfPresent(Int.self, forKey: .availDays) ?? 0
           self.approveFromDate = try container.decodeIfPresent(String.self, forKey: .approveFromDate) ?? ""
           self.approveToDate = try container.decodeIfPresent(String.self, forKey: .approveToDate) ?? ""
           self.applicationDate = try container.decodeIfPresent(String.self, forKey: .applicationDate) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(leaveType, forKey: .leaveType)
           try container.encode(availDays, forKey: .availDays)
           try container.encode(approveFromDate, forKey: .approveFromDate)
           try container.encode(approveToDate, forKey: .approveToDate)
           try container.encode(applicationDate, forKey: .applicationDate)
       }
}


struct AvailHistorySummaryResponse: Codable {
    var error: String = ""
    var _availHistoryList : [AvailHistorySummaryList]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _availHistoryList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._availHistoryList = try container.decodeIfPresent([AvailHistorySummaryList].self, forKey: ._availHistoryList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_availHistoryList, forKey: ._availHistoryList)
        }
}

// Final Year Select
struct ListFinalYear: Codable {
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

struct ListFinalYearResponse: Codable {
    var error: String = ""
    var _listFinalYear : [ListFinalYear]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _listFinalYear
    }
    
     init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._listFinalYear = try container.decodeIfPresent([ListFinalYear].self, forKey: ._listFinalYear) ?? []
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_listFinalYear, forKey: ._listFinalYear)
        }

}
