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
   var track_app_size = ""
   var track_app_version = ""
    init() {}
    init(data: [String: AnyObject]) {
        track_deviceid = data["track_deviceid"] as? String ?? ""
        track_branch_name = data ["track_branch_name"] as? String ?? ""
        track_os_version = data ["track_os_version"] as? String ?? ""
        track_os_name = data ["track_os_name"] as? String ?? ""
        track_sim_misdn = data ["track_sim_misdn"] as? String ?? ""
        track_sim_provider = data ["track_sim_provider"] as? String ?? ""
        track_sim_type = data ["track_sim_type"] as? String ?? ""
        track_app_name = data ["track_app_name"] as? String ?? ""
        track_app_size = data ["track_app_size"] as? String ?? ""
        track_app_version = data ["track_app_version"] as? String ?? ""
        
        func toJsonString() -> [String: Any] {
            var parameters = [String: Any]()
            parameters["track_deviceid"] = track_deviceid
            parameters["track_branch_name"] = track_branch_name
            parameters["track_os_version"] = track_os_version
            parameters["track_os_name"] = track_os_name
            parameters["track_sim_misdn"] = track_sim_misdn
            parameters["track_sim_provider"] = track_sim_provider
            parameters["track_sim_type"] = track_sim_type
            parameters["track_app_name"] = track_app_name
            parameters["track_app_size"] = track_app_size
            parameters["track_app_version"] = track_app_version

            return parameters
            
        }


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
