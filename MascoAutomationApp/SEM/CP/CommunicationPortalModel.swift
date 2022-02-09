//
//  CommunicationPortalModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation


struct ListUnitName: Codable {
    var unitNo: Int?
    var unitEName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case unitNo = "unitNo"
        case unitEName = "unitEName"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.unitNo = try container.decodeIfPresent(Int.self, forKey: .unitNo) ?? 0
           self.unitEName = try container.decodeIfPresent(String.self, forKey: .unitEName) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(unitNo, forKey: .unitNo)
           try container.encode(unitEName, forKey: .unitEName)
       }
}

struct ListUnitNameResponse: Codable {
    var error: String = ""
    var _listUnitName : [ListUnitName]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _listUnitName
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._listUnitName = try container.decodeIfPresent([ListUnitName].self, forKey: ._listUnitName) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_listUnitName, forKey: ._listUnitName)
        }
}

struct EmpNameRequest: Codable {
    var unit_no: Int?
    var emp_name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case unit_no = "unit_no"
        case emp_name = "emp_name"
    }
}

struct ListEmpName: Codable {
    var unitNo: Int?
    var emP_CODE: String = ""
    var emp_full: String = ""
    
    enum CodingKeys: String, CodingKey {
        case unitNo = "unitNo"
        case emP_CODE = "emP_CODE"
        case emp_full = "emp_full"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.unitNo = try container.decodeIfPresent(Int.self, forKey: .unitNo) ?? 0
           self.emP_CODE = try container.decodeIfPresent(String.self, forKey: .emP_CODE) ?? ""
           self.emp_full = try container.decodeIfPresent(String.self, forKey: .emp_full) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(unitNo, forKey: .unitNo)
           try container.encode(emP_CODE, forKey: .emP_CODE)
           try container.encode(emp_full, forKey: .emp_full)
       }
}

struct ListEmpNameResponse: Codable {
    var error: String = ""
    var _listEmployee : [ListEmpName]

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case _listEmployee
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self._listEmployee = try container.decodeIfPresent([ListEmpName].self, forKey: ._listEmployee) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(_listEmployee, forKey: ._listEmployee)
        }
}

struct EmpNameDetailsRequest: Codable {
    var emp_code: String = ""
    
    enum CodingKeys: String, CodingKey {
        case emp_code = "emp_code"
    }
}

struct ListEmpDetails: Codable {
   
    var emP_CODE: String = ""
    var emP_ID: Int?
    var emP_ENAME: String = ""
    var desigEName: String = ""
    var personal_mobile: String = ""
    var ip: String = ""
    var office_mobile: String = ""
    var email: String = ""
    var sectEName: String = ""
    var deptEName: String = ""
    var unitEName: String = ""
    var img_url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case emP_CODE = "emP_CODE"
        case emP_ID = "emP_ID"
        case emP_ENAME = "emP_ENAME"
        case desigEName = "desigEName"
        case personal_mobile = "personal_mobile"
        case ip = "ip"
        case office_mobile = "office_mobile"
        case email = "email"
        case sectEName = "sectEName"
        case deptEName = "deptEName"
        case unitEName = "unitEName"
        case img_url = "img_url"
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.emP_CODE = try container.decodeIfPresent(String.self, forKey: .emP_CODE) ?? ""
        self.emP_ID = try container.decodeIfPresent(Int.self, forKey: .emP_ID) ?? 0
        self.emP_ENAME = try container.decodeIfPresent(String.self, forKey: .emP_ENAME) ?? ""
        self.desigEName = try container.decodeIfPresent(String.self, forKey: .desigEName) ?? ""
        self.personal_mobile = try container.decodeIfPresent(String.self, forKey: .personal_mobile) ?? ""
        self.ip = try container.decodeIfPresent(String.self, forKey: .ip) ?? ""
        self.office_mobile = try container.decodeIfPresent(String.self, forKey: .office_mobile) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.sectEName = try container.decodeIfPresent(String.self, forKey: .sectEName) ?? ""
        self.deptEName = try container.decodeIfPresent(String.self, forKey: .deptEName) ?? ""
        self.unitEName = try container.decodeIfPresent(String.self, forKey: .unitEName) ?? ""
        self.img_url = try container.decodeIfPresent(String.self, forKey: .img_url) ?? ""
       }

       func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(emP_CODE, forKey: .emP_CODE)
        try container.encode(emP_ID, forKey: .emP_ID)
        try container.encode(emP_ENAME, forKey: .emP_ENAME)
        try container.encode(desigEName, forKey: .desigEName)
        try container.encode(personal_mobile, forKey: .personal_mobile)
        try container.encode(ip, forKey: .ip)
        try container.encode(office_mobile, forKey: .office_mobile)
        try container.encode(email, forKey: .email)
        try container.encode(sectEName, forKey: .sectEName)
        try container.encode(deptEName, forKey: .deptEName)
        try container.encode(unitEName, forKey: .unitEName)
        try container.encode(img_url, forKey: .img_url)
       }
}

struct ListEmpResponse: Codable {
    var error: String = ""
    var empDetails : ListEmpDetails

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case empDetails
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
            self.empDetails = try container.decodeIfPresent(ListEmpDetails.self, forKey: .empDetails)!
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(error, forKey: .error)
            try container.encode(empDetails, forKey: .empDetails)
        }
}
