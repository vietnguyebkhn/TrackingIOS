//
//  TrackingFunction.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class TrackingFunction {
    //cac ham:
    //tracking location
     func trackLocation(params: NSDictionary?) {
        let eventType = kTrackLocation
        
    }
    
    //tracking thong tin ca nhan
    func trackPersonalInfo(params: NSDictionary?) {
        let eventType = kTrackPersonalInfo
        
    }
    
    //tracking cai app
    func trackAppInstall(params: NSDictionary?) {
        let eventType = kTrackAppInstall
        
    }
    
    //tracking go app
    func trackAppUninstall(params: NSDictionary?) {
        
    }
    
    //"track_app_crash": Crash ứng dụng
    func trackAppCrash(params: NSDictionary?) {
        
    }
    
    // "track_app_start": Mở app chạy mới
    func trackAppStart(params: NSDictionary?) {
        
    }
    
    //"track_event_window_open": Mở màn hình
    func trackEventWindowOpen(params: NSDictionary?) {
        
    }
    
    //"track_event_button_click": Click button, link
    func trackEventButtonClick(params: NSDictionary?) {
        
    }
    
    //"track_event_window_close": Đóng màn hình
    func trackEventWindowClose(params: NSDictionary?) {
        
    }
    
    //"track_app_close": Đóng hẳn app (kill)
    func trackAppClose(params: NSDictionary?) {
        
    }
    
}
