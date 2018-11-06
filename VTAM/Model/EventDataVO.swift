//
//  EventDataVO.swift
//  VTAM
//
//  Created by Fate on 11/5/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class  EventDataVO {
    var property = ""
    var value = ""
    
    init() {}

    init(data: [String: AnyObject]) {
        let keys = data.keys
        for key in keys {
            property = key
            value = data[property] as? String ?? ""
        }
    }
    
    func toJsonString() -> [String : Any] {
        var parameters =  [String : Any]()
        
        parameters[property] = property
        parameters[value] = value

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
