//
//  DailyAttendanceModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct AttendanceDetailsRequest: Codable {
    var fromDate: String
    var toDate: String
    
    enum CodingKeys: String, CodingKey {
        case fromDate = "fromDate"
        case toDate = "toDate"
    }
}

struct AttendanceDetails: Codable {
    var datePunch: String = ""
    var shiftInTime: String = ""
    var shiftOutTime: String = ""
    var shiftLateTime: String = ""
    var punchInTime: String = ""
    var punchOutTime: String = ""
    var shiftName: String = ""
    var lateTime: String = ""
    var additionalTime: String = ""
    var fSts: String = ""
    
    enum CodingKeys: String, CodingKey {
        case datePunch = "datePunch"
        case shiftInTime = "shiftInTime"
        case shiftOutTime = "shiftOutTime"
        case shiftLateTime = "shiftLateTime"
        case punchInTime = "punchInTime"
        case punchOutTime = "punchOutTime"
        case shiftName = "shiftName"
        case lateTime = "lateTime"
        case additionalTime = "additionalTime"
        case fSts = "fSts"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.datePunch = try container.decodeIfPresent(String.self, forKey: .datePunch) ?? ""
        self.shiftInTime = try container.decodeIfPresent(String.self, forKey: .shiftInTime) ?? ""
        self.shiftOutTime = try container.decodeIfPresent(String.self, forKey: .shiftOutTime) ?? ""
        self.shiftLateTime = try container.decodeIfPresent(String.self, forKey: .shiftLateTime) ?? ""
        self.punchInTime = try container.decodeIfPresent(String.self, forKey: .punchInTime) ?? ""
        self.punchOutTime = try container.decodeIfPresent(String.self, forKey: .punchOutTime) ?? ""
        self.shiftName = try container.decodeIfPresent(String.self, forKey: .shiftName) ?? ""
        self.lateTime = try container.decodeIfPresent(String.self, forKey: .lateTime) ?? ""
        self.additionalTime = try container.decodeIfPresent(String.self, forKey: .additionalTime) ?? ""
        self.fSts = try container.decodeIfPresent(String.self, forKey: .fSts) ?? ""
        
    }

       func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(datePunch, forKey: .datePunch)
        try container.encode(shiftInTime, forKey: .shiftInTime)
        try container.encode(shiftOutTime, forKey: .shiftOutTime)
        try container.encode(shiftLateTime, forKey: .shiftLateTime)
        try container.encode(punchInTime, forKey: .punchInTime)
        try container.encode(punchOutTime, forKey: .punchOutTime)
        try container.encode(shiftName, forKey: .shiftName)
        try container.encode(lateTime, forKey: .lateTime)
        try container.encode(additionalTime, forKey: .additionalTime)
        try container.encode(fSts, forKey: .fSts)
    }
}

struct AttendanceDetailsResponse: Codable {
    var error: String = ""
    var _attHistoryListStr : [AttendanceDetails]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _attHistoryListStr
    }
    
     init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._attHistoryListStr = try container.decodeIfPresent([AttendanceDetails].self, forKey: ._attHistoryListStr) ?? []
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_attHistoryListStr, forKey: ._attHistoryListStr)
        }
}


struct LeaveCountRequest: Codable {
    var fromDate: String
    var toDate: String
    
    enum CodingKeys: String, CodingKey {
        case fromDate = "fromDate"
        case toDate = "toDate"
    }
    
}
struct LeaveCount: Codable {
    var status: String = ""
    var statusValue: String = ""
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case statusValue = "statusValue"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.statusValue = try container.decodeIfPresent(String.self, forKey: .statusValue) ?? ""
       }

       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(status, forKey: .status)
           try container.encode(statusValue, forKey: .statusValue)
       }
}

struct LeaveCountResponse: Codable {
    var error: String = ""
    var _listLeaveCount : [LeaveCount]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _listLeaveCount
    }
    
     init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._listLeaveCount = try container.decodeIfPresent([LeaveCount].self, forKey: ._listLeaveCount) ?? []
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_listLeaveCount, forKey: ._listLeaveCount)
        }
}
