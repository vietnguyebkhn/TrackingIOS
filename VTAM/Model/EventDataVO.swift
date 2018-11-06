//
//  EventDataVO.swift
//  VTAM
//
//  Created by Fate on 11/5/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class  EventDataVO {
    var data : NSDictionary = [:]

   var track_app_install = ""
   var track_app_uninstall = ""
   var track_app_crash = ""
   var track_app_start = ""
   var  track_event_window_open = ""
   var track_event_button_click = ""
   var track_event_window_close = ""
   var  track_app_close = ""
    
    init() {}

    init(data: [String: AnyObject]) {

        track_app_install = data["track_app_install"] as? String ?? ""
        track_app_uninstall = data["track_app_uninstall"] as? String ?? ""
        track_app_crash = data["track_app_crash"] as? String ?? ""
        track_app_start = data["track_app_start"] as? String ?? ""
        track_event_window_open = data["track_event_window_open"] as? String ?? ""
        track_event_button_click = data["track_event_button_click"] as? String ?? ""
        track_event_window_close = data["track_event_window_close"] as? String ?? ""
        track_app_close = data["track_app_close"] as? String ?? ""
    }
    
    func toJsonString() -> [String : Any] {
        var parameters =  [String : Any]()
        
        parameters["track_app_crash"] = track_app_crash
        parameters["track_app_start"] = track_app_start
        parameters["track_event_window_open"] = track_event_window_open
        parameters["track_event_button_click"] = track_event_button_click
        parameters["track_event_window_close"] = track_event_window_close
        parameters["track_app_close"] = track_app_close

        return parameters
    }
}

//track_app_install
//track_app_uninstall
//track_app_crash
//track_app_start
//track_event_window_open
//track_event_button_click
//track_event_window_close
//track_app_close
