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
    //var tempData: [[String: AnyObject]]?
    var params = [String: AnyObject]()

    
    init() {}

    init(data: [String: AnyObject]) {
        
            for key in data.keys {
                property = key
                value = data[property] as? String ?? ""
                for (key,value) in data {
                    params[key] = value
                }
                print(" params = \(params)")
            }
    }
    
    func toJsonString() -> [String : Any] {
        
        return params
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
