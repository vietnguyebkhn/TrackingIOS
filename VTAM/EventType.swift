//
//  EventType.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

let kDataServerUrl = "data_server_url"
let kDataInterval  = "data_interval"

//cac su kien:
public let kTrackLocation = "track_location"
public let kTrackPersonalInfo = "track_personal_info"
public let kTrackAppInstall = "track_app_install"
public let kTrackDeviceInfo = "track_device_info"
public let kTrackAppInstal = "track_app_install"
public let kTrackAppStart = "track_app_start"
public let kTrackAppUninstall = "track_app_uninstall"
public let kTrackAppCrash = "track_app_crash"
public let kTrackEventWindowOpen = "track_event_window_open"
public let kTrackEventButtonClick = "track_event_button_click"
public let kTrackEventWindowClose = "track_event_window_close"
public let kTrackAppClose = "track_app_close"
/*"track_location": Location
 "track_personal_info": Thông tin cá nhân //K track duoc
 "track_app_install": Cài đặt ứng dụng // da track
 "track_app_uninstall": Gỡ ứng dụng
 "track_app_crash": Crash ứng dụng
 "track_app_start": Mở app chạy mới // xong
 "track_event_window_open": Mở màn hình
 "track_event_button_click": Click button, link
 "track_event_window_close": Đóng màn hình
 "track_app_close": Đóng hẳn app (kill) // xong 
 */
public var device_info = [String:Any]()
public let event_data = [String:Any]()
public var jsonObj = [
    "tracking-code":"tracking-code đã cấu hình",
    "package-id":"packageID/bundleID của ứng dụng",
    "request-id":"id của request gửi lên",
    "tracking-data":[
        "event-type": "mã event",
        "object-name": "tên object",
        "event-time": "thời điểm phát sinh event (YYYYMMDDHH24MISS)"
    ]
] as [String : Any]

