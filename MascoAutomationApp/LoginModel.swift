//
//  LoginModel.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 9/2/22.
//

import Foundation



struct ToDoRequestModel: Codable {
    var empId: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case empId = "empId"
        case password = "password"
    }
}

struct LoginResponse: Codable {
    var empCode: String = ""
    var mobile: String = ""
    var empId: Int?
    var token: String  = ""
    var refresh_token: String  = ""
    var error: String = ""
    var _permissionList : [PermissionList]

    enum CodingKeys: String, CodingKey {
        case empCode = "empCode"
        case mobile = "mobile"
        case empId = "empId"
        case token = "token"
        case refresh_token = "refresh_token"
        case error = "error"
        case _permissionList
    }
    
     init(from decoder: Decoder) throws {

            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.empCode = try container.decodeIfPresent(String.self, forKey: .empCode) ?? ""
            self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile) ?? ""
            self.empId = try container.decodeIfPresent(Int.self, forKey: .empId) ?? 0
            self.token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
            self.refresh_token = try container.decodeIfPresent(String.self, forKey: .refresh_token) ?? ""
            self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
        
           self._permissionList = try container.decodeIfPresent([PermissionList].self, forKey: ._permissionList) ?? []
        }

        func encode(to encoder: Encoder) throws {

            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(empCode, forKey: .empCode)
            try container.encode(mobile, forKey: .mobile)
            try container.encode(empId, forKey: .empId)
            try container.encode(token, forKey: .token)
            try container.encode(refresh_token, forKey: .refresh_token)
            try container.encode(error, forKey: .error)
            try container.encode(_permissionList, forKey: ._permissionList)
        }

}
//
struct PermissionList: Codable {
    var moduleName: String = ""
    var _subMenuList: [SubMenuList]
    
    enum CodingKeys: String, CodingKey {
        case moduleName = "moduleName"
        case _subMenuList
        
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.moduleName = try container.decodeIfPresent(String.self, forKey: .moduleName) ?? ""
          self._subMenuList = try container.decodeIfPresent([SubMenuList].self, forKey: ._subMenuList) ?? []
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(moduleName, forKey: .moduleName)
          try container.encode(_subMenuList, forKey: ._subMenuList)
       }
}

struct SubMenuList: Codable {
    var activityName: String = ""
    var activityNameStr: String = ""
    var manuId: Int = 0
    var manuStepId: Int = 0
    var parantManuId: Int = 0
    var _specialPermission: String = ""
    
    enum CodingKeys: String, CodingKey {
        case activityName = "activityName"
        case activityNameStr = "activityNameStr"
        case manuId = "manuId"
        case manuStepId = "manuStepId"
        case parantManuId = "parantManuId"
        case _specialPermission = "_specialPermission"
        
    }
    
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.activityName = try container.decodeIfPresent(String.self, forKey: .activityName) ?? ""
           self.activityNameStr = try container.decodeIfPresent(String.self, forKey: .activityNameStr) ?? ""
           self.manuId = try container.decodeIfPresent(Int.self, forKey: .manuId) ?? 0
           self.manuStepId = try container.decodeIfPresent(Int.self, forKey: .manuStepId) ?? 0
           self.parantManuId = try container.decodeIfPresent(Int.self, forKey: .parantManuId) ?? 0
           self._specialPermission = try container.decodeIfPresent(String.self, forKey: ._specialPermission) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(activityName, forKey: .activityName)
           try container.encode(activityNameStr, forKey: .activityNameStr)
       }
    
}


//-----Photo----
struct ProfilePhoto: Codable {

    var serverFileName: String = ""
    var unitEName: String = ""
    var emP_ENAME: String = ""
    var error: String = ""
    
    enum CodingKeys: String, CodingKey {
        case serverFileName = "serverFileName"
        case unitEName = "unitEName"
        case emP_ENAME = "emP_ENAME"
        case error = "error"
    }
    
    init(from decoder: Decoder) throws {

           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.serverFileName = try container.decodeIfPresent(String.self, forKey: .serverFileName) ?? ""
           self.unitEName = try container.decodeIfPresent(String.self, forKey: .unitEName) ?? ""
           self.emP_ENAME = try container.decodeIfPresent(String.self, forKey: .emP_ENAME) ?? ""
           self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
       }

       func encode(to encoder: Encoder) throws {

           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(serverFileName, forKey: .serverFileName)
           try container.encode(unitEName, forKey: .unitEName)
           try container.encode(emP_ENAME, forKey: .emP_ENAME)
           try container.encode(error, forKey: .error)
       }
}
