//
//  API.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 5/12/21.
//

import Foundation


var BASE_URL = "https://mis-api.mascoknit.com/api/"


var LOGIN_URL = BASE_URL+"v1/LoginAccess/login"
var LEAVE_HISTORY_URL = BASE_URL+"v1/leave/leave-history"
var YEAR_URL = BASE_URL+"v1/Attendance/getFinalYear"
var UNIT_NAME_URL = BASE_URL+"v1/gpms/production/load-unitname"
var HWD_URL = BASE_URL+"v1/gpms/production/hour-wise-data"
var BWPD_URL = BASE_URL+"v1/gpms/production/buyer-wise-data"
var HWPDs_URL = BASE_URL+"v1/gpms/production/hour-wise-production-details"
