//
//  EventType.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

@objc open class VEventType : NSObject {
    let kDataServerUrl = "data_server_url"
    let kDataInterval  = "data_interval"
    
    //cac su kien:
    @objc public static let kTrackLocation = "track_location"
    @objc public static let kTrackPersonalInfo = "track_personal_info"
    @objc public static let kTrackAppInstall = "track_app_install"
    @objc public static let kTrackDeviceInfo = "track_device_info"
    @objc public static let kTrackAppInstal = "track_app_install"
    @objc public static let kTrackAppStart = "track_app_start"
    @objc public static let kTrackAppUninstall = "track_app_uninstall"
    @objc public static let kTrackAppCrash = "track_app_crash"
    @objc public static let kTrackEventWindowOpen = "track_event_window_open"
    @objc public static let kTrackEventButtonClick = "track_event_button_click"
    @objc public static let kTrackEventWindowClose = "track_event_window_close"
    @objc public static let kTrackAppClose = "track_app_close"
    /*"track_location": Location
     "track_personal_info": Thông tin cá nhân //K track duoc
     "track_app_install": Cài đặt ứng dụng // xong
     "track_app_uninstall": Gỡ ứng dụng
     "track_app_crash": Crash ứng dụng
     "track_app_start": Mở app chạy mới // xong
     "track_event_window_open": Mở màn hình
     "track_event_button_click": Click button, link // xong
     "track_event_window_close": Đóng màn hình
     "track_app_close": Đóng hẳn app (kill) // xong
     */
    public static var device_info = [String:Any]()
    public static let event_data = [String:Any]()
    public static var jsonObj = [
        "tracking-code":"tracking-code đã cấu hình",
        "package-id":"packageID/bundleID của ứng dụng",
        "request-id":"id của request gửi lên",
        "tracking-data":[
            "event-type": "mã event",
            "object-name": "tên object",
            "event-time": "thời điểm phát sinh event (YYYYMMDDHH24MISS)"
        ]
        ] as [String : Any]
}


