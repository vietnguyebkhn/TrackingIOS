//
//  DeviceInfoVO.swift
//  VTAM
//
//  Created by Fate on 11/5/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class DeviceVO{
    var track_deviceid = ""
    var  track_branch_name = ""
    var  track_os_version = ""
    var  track_os_name = ""
    var track_sim_misdn = ""
    var track_sim_provider = ""
    var track_sim_type = ""
    var track_app_name = ""
    var track_app_size = 0.0
    var track_app_version = ""
    var trackDeviceMode = ""
    init() {}
    
    init(data: [String: AnyObject]) {
        track_deviceid = data["trackdeviceid"] as? String ?? ""
        track_branch_name = data ["branchName"] as? String ?? ""
        track_os_version = data ["osVersion"] as? String ?? ""
        track_os_name = data ["osName"] as? String ?? ""
        track_sim_misdn = data ["simMisdn"] as? String ?? ""
        track_sim_provider = data ["simProvider"] as? String ?? ""
        track_sim_type = data ["simType"] as? String ?? ""
        track_app_name = data ["appName"] as? String ?? ""
        track_app_size = data ["appSize"] as? Float64 ?? 0
        track_app_version = data ["appVersion"] as? String ?? ""
        trackDeviceMode = data ["deviceModel"] as? String ?? ""
    }
    
    func toJsonString1() -> [String: Any] {
        var parameters = [String: Any]()
        parameters["trackdeviceid"] = track_deviceid
        parameters["branchName"] = track_branch_name
        parameters["osVersion"] = track_os_version
        parameters["osVersion"] = track_os_name
        parameters["simMisdn"] = track_sim_misdn
        parameters["simProvider"] = track_sim_provider
        parameters["simType"] = track_sim_type
        parameters["appName"] = track_app_name
        parameters["appSize"] = track_app_size
        parameters["appVersion"] = track_app_version
        parameters["deviceModel"] = trackDeviceMode
        
        return parameters
    }
}

//track_deviceid
//track_branch_name
//track_os_version
//track_os_name
//track_sim_misdn
//track_sim_provider
//track_sim_type
//track_app_name
//track_app_size
//track_app_version
