//
//  LeaveApplyModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct empDtails: Codable {
    
    var emP_CODE: String = ""
    var emP_ENAME: String = ""
    var doj: String = ""
    var deptEName: String = ""
    var sectEName: String = ""
    var desigEName: String = ""
    var unitEName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case emP_CODE = "emP_CODE"
        case emP_ENAME = "emP_ENAME"
        case doj = "doj"
        case deptEName = "deptEName"
        case sectEName = "sectEName"
        case desigEName = "desigEName"
        case unitEName = "unitEName"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
            self.emP_CODE = try container.decodeIfPresent(String.self, forKey: .emP_CODE) ?? ""
            self.emP_ENAME = try container.decodeIfPresent(String.self, forKey: .emP_ENAME) ?? ""
            self.doj = try container.decodeIfPresent(String.self, forKey: .doj) ?? ""
            self.deptEName = try container.decodeIfPresent(String.self, forKey: .deptEName) ?? ""
            self.sectEName = try container.decodeIfPresent(String.self, forKey: .sectEName) ?? ""
            self.desigEName = try container.decodeIfPresent(String.self, forKey: .desigEName) ?? ""
            self.unitEName = try container.decodeIfPresent(String.self, forKey: .unitEName) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(emP_CODE, forKey: .emP_CODE)
            try container.encode(emP_ENAME, forKey: .emP_ENAME)
            try container.encode(doj, forKey: .doj)
            try container.encode(deptEName, forKey: .deptEName)
            try container.encode(sectEName, forKey: .sectEName)
            try container.encode(desigEName, forKey: .desigEName)
            try container.encode(unitEName, forKey: .unitEName)
       }
}


struct ListLeaveAvail: Codable {
    var leaveTypeNo: Int?
    var abbreviation: String = ""
    var maxBalance: Double = 0.0
    var avail: Int?
    
    enum CodingKeys: String, CodingKey {
        case leaveTypeNo = "leaveTypeNo"
        case abbreviation = "abbreviation"
        case maxBalance = "maxBalance"
        case avail = "avail"
    }
    
    init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.leaveTypeNo = try container.decodeIfPresent(Int.self, forKey: .leaveTypeNo) ?? 0
            self.abbreviation = try container.decodeIfPresent(String.self, forKey: .abbreviation) ?? ""
        self.maxBalance = try container.decodeIfPresent(Double.self, forKey: .maxBalance) ?? 0.0
            self.avail = try container.decodeIfPresent(Int.self, forKey: .avail) ?? 0
       }

       func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(leaveTypeNo, forKey: .leaveTypeNo)
            try container.encode(abbreviation, forKey: .abbreviation)
            try container.encode(maxBalance, forKey: .maxBalance)
            try container.encode(avail, forKey: .avail)
       }
}

struct ListLeaveFormDataResponse: Codable {
    var error: String = ""
    var emp_details : empDtails
    var _leaveAvailList : [ListLeaveAvail]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case emp_details
        case _leaveAvailList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self.emp_details = try container.decodeIfPresent(empDtails.self, forKey: .emp_details)!
            self._leaveAvailList = try container.decodeIfPresent([ListLeaveAvail].self, forKey: ._leaveAvailList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(emp_details, forKey: .emp_details)
            try container.encode(_leaveAvailList, forKey: ._leaveAvailList)
        }
}

struct LeaveSubmitRequest: Codable {
    var apply_from: String = ""
    var apply_to: String = ""
    var leave_days: Int?
    var leave_type: Int?
    var reason: String = ""
    
    enum CodingKeys: String, CodingKey {
        case apply_from = "apply_from"
        case apply_to = "apply_to"
        case leave_days = "leave_days"
        case leave_type = "leave_type"
        case reason = "reason"
    }
}

struct LeaveSubmitResponse: Codable {
    var error: String = ""
    var message: String = ""
    var response: Bool

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case message = "message"
        case response = "response"
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        self.response = try container.decodeIfPresent(Bool.self, forKey: .response) ?? false
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(message, forKey: .message)
            try container.encode(response, forKey: .response)
        }
}
