//
//  LeaveApprovalDetailModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct LeaveApprovalPendingRequest: Codable {
    var recommPersNo: Int?
    var responsiblePersNo: Int?
    
    enum CodingKeys: String, CodingKey {
        case recommPersNo = "recommPersNo"
        case responsiblePersNo = "responsiblePersNo"
    }
}
struct ListLeaveApproval: Codable {
    var applyNo: Int?
    var emP_CODE: String = ""
    var emP_ENAME: String = ""
    var desigEName: String = ""
    var applyFromDate: String = ""
    var applyToDate: String = ""
    var applyDays: String = ""
    var leaveNo: Int?
    var leaveType: String = ""
    var leaveMax: Int?
    var leaveAvail: Int?
    var check: Bool
    
    enum CodingKeys: String, CodingKey {
        case applyNo = "applyNo"
        case emP_CODE = "emP_CODE"
        case emP_ENAME = "emP_ENAME"
        case desigEName = "desigEName"
        case applyFromDate = "applyFromDate"
        case applyToDate = "applyToDate"
        case applyDays = "applyDays"
        case leaveNo = "leaveNo"
        case leaveType = "leaveType"
        case leaveMax = "leaveMax"
        case leaveAvail = "leaveAvail"
        case check = "check"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.applyNo = try container.decodeIfPresent(Int.self, forKey: .applyNo) ?? 0
           self.emP_CODE = try container.decodeIfPresent(String.self, forKey: .emP_CODE) ?? ""
           self.emP_ENAME = try container.decodeIfPresent(String.self, forKey: .emP_ENAME) ?? ""
           self.desigEName = try container.decodeIfPresent(String.self, forKey: .desigEName) ?? ""
           self.applyFromDate = try container.decodeIfPresent(String.self, forKey: .applyFromDate) ?? ""
           self.applyToDate = try container.decodeIfPresent(String.self, forKey: .applyToDate) ?? ""
           self.applyDays = try container.decodeIfPresent(String.self, forKey: .applyDays) ?? ""
           self.leaveNo = try container.decodeIfPresent(Int.self, forKey: .leaveNo) ?? 0
           self.leaveType = try container.decodeIfPresent(String.self, forKey: .leaveType) ?? ""
           self.leaveMax = try container.decodeIfPresent(Int.self, forKey: .leaveMax) ?? 0
           self.leaveAvail = try container.decodeIfPresent(Int.self, forKey: .leaveAvail) ?? 0
           self.check = false
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(applyNo, forKey: .applyNo)
           try container.encode(emP_CODE, forKey: .emP_CODE)
           try container.encode(emP_ENAME, forKey: .emP_ENAME)
           try container.encode(desigEName, forKey: .desigEName)
           try container.encode(applyFromDate, forKey: .applyFromDate)
           try container.encode(applyToDate, forKey: .applyToDate)
           try container.encode(applyDays, forKey: .applyDays)
           try container.encode(leaveNo, forKey: .leaveNo)
           try container.encode(leaveType, forKey: .leaveType)
           try container.encode(leaveAvail, forKey: .leaveAvail)
           try container.encode(check, forKey: .check)
       }
}

struct ListLeaveApprovalPendingResponse: Codable {
    var error: String = ""
    var _leavePendingList : [ListLeaveApproval]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _leavePendingList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._leavePendingList = try container.decodeIfPresent([ListLeaveApproval].self, forKey: ._leavePendingList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_leavePendingList, forKey: ._leavePendingList)
        }
}


struct LeaveApproveList: Codable {
    var ApplyDays: String = ""
    var ApplyNo: Int?
    var ApproveFromDate: String = ""
    var ApproveToDate: String = ""
    var EMP_CODE: String = ""
    var LeaveNo: Int?
    
    enum CodingKeys: String, CodingKey {
        case ApplyDays = "ApplyDays"
        case ApplyNo = "ApplyNo"
        case ApproveFromDate = "ApproveFromDate"
        case ApproveToDate = "ApproveToDate"
        case EMP_CODE = "EMP_CODE"
        case LeaveNo = "LeaveNo"

    }
}

struct LeaveApproveListRequest: Codable {
    var approveList : [LeaveApproveList]
    
    enum CodingKeys: String, CodingKey {
        case approveList
    }
    
}
    
struct LeaveApproveResponse: Codable {
    var response: Bool?
    var error: String = ""
   

    enum CodingKeys: String, CodingKey {
        case response = "response"
        case error = "error"
       
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.response = try container.decodeIfPresent(Bool.self, forKey: .response)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
           
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(response, forKey: .response)
            try container.encode(error, forKey: .error)
         
        }
}

struct LeaveRejectList: Codable {
    var ApplyNo: Int?
    
    enum CodingKeys: String, CodingKey {
        case ApplyNo = "ApplyNo"
    }
}

struct LeaveRejectListRequest: Codable {
    var leaveRejectList : [LeaveRejectList]
    var ActionBy:String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case leaveRejectList
        case ActionBy = "ActionBy"
    }
    
}
    
struct LeaveRejectResponse: Codable {
    var response: Bool?
    var error: String = ""
   

    enum CodingKeys: String, CodingKey {
        case response = "response"
        case error = "error"
       
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.response = try container.decodeIfPresent(Bool.self, forKey: .response)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
           
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(response, forKey: .response)
            try container.encode(error, forKey: .error)
         
        }
}
