//
//  TrackingFunction.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation
import CoreLocation

class TrackingFunction : NSObject,CLLocationManagerDelegate {
    var locationManager : CLLocationManager?
    var currentLocation : CLLocation!
    var mConfigFunction = ConfigFunction()
    //tracking location
     func trackLocation(params: NSDictionary?) {
            if locationManager == nil {
                locationManager = CLLocationManager()
                locationManager!.delegate = self
                locationManager!.desiredAccuracy = kCLLocationAccuracyBest
                if CLLocationManager.locationServicesEnabled() == false {
                    print("Your location service is not enabled, So go to Settings>Location Services")
                } else {
                    print("Your location service is enabled")
                }
                locationManager!.requestWhenInUseAuthorization()
            }
            locationManager!.startUpdatingLocation()
        let longitude = locationManager?.location?.coordinate.longitude
        let latitude = locationManager?.location?.coordinate.latitude
//        let eventType = kTrackLocation
//        var dict : NSDictionary!
//        if params != nil {
//            dict = params
//        } else {
//            dict = [:]
//        }
//
//
//        dict.setValue(eventType, forKey: "eventType")
//        dict.setValue(mConfigFunction.getCurrentTime(), forKey: "current_time")
//
//        mConfigFunction.logToFile(params: dict)
        print("longitdude: \(longitude!) latitude: \(latitude!)")
    }
    //tracking device info
    func trackDeviceInfo(params: NSDictionary?){
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        let iOSVersion = UIDevice.current.systemVersion
        let deviceModel = UIDevice.current.model
        let dic = [
            "track_branch_name" : build ?? "",
            "track_app_version" : version ?? "",
            "track_app_name" : appName ?? "",
//            "deviceModel" : deviceModel ?? "",
            "track_os_version" : iOSVersion
            ] as [String : Any]
        print("\(dic)")
        print(systemInfo.machine)
        print(deviceModel)
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
