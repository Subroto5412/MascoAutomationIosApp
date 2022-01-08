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
var AVAIL_HISTORY_URL = BASE_URL+"v1/leave/avail-history"
var YEAR_URL = BASE_URL+"v1/Attendance/getFinalYear"
var UNIT_NAME_URL = BASE_URL+"v1/gpms/production/load-unitname"
var HWD_URL = BASE_URL+"v1/gpms/production/hour-wise-data"
var BWPD_URL = BASE_URL+"v1/gpms/production/buyer-wise-data"
var HWPDs_URL = BASE_URL+"v1/gpms/production/hour-wise-production-details"
var LWP_URL = BASE_URL+"v1/gpms/production/line-wise"
var TAX_URL = BASE_URL+"v1/tax/tax-year"
var TAX_DEDUCTION_URL = BASE_URL+"v1/tax/tax-deduct"
var PROFILE_PHOTO_URL = BASE_URL+"v1/LoginAccess/getImageById?empCode="
var PHOTO_LINK_URL = "https://mis-api.mascoknit.com/EmpImages/"
var ATTENDANCE_DETAILS_URL = BASE_URL+"v1/Attendance/details"
var LEAVE_COUNT_URL = BASE_URL+"v1/Attendance/summary"


var LOAD_UNITNAME_URL = BASE_URL+"v1/sem/communication-portal/load-unitname"
var LOAD_EMPNAME_URL = BASE_URL+"v1/sem/communication-portal/load-emp-name-autocomplete"
var GET_EMP_DETAILS_URL = BASE_URL+"v1/sem/communication-portal/get-emp-details"

var FORM_DATA_URL = BASE_URL+"v1/leave/form-data"
var LEAVE_SUBMIT_URL = BASE_URL+"v1/leave/submit"

var LEAVE_APPROVAL_PENDING_LIST_URL = BASE_URL+"v1/leave/pending"
var LEAVE_APPROVE_LIST_URL = BASE_URL+"v1/leave/approve"
var LEAVE_REJECT_LIST_URL = BASE_URL+"v1/leave/reject"
