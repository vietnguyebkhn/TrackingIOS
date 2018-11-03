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
    var mConfigFunction = ConfigFunction()
    var itemEventData = VEventType.jsonObj["event-data"] as? [[String:Any]] ?? [[String:Any]]()
    var itemDeviceInfo = VEventType.jsonObj["device-info"] as? [[String:Any]] ?? [[String:Any]]()
    //tracking location
     func trackLocation(params: NSDictionary?) {
        var locationManager : CLLocationManager?
            if locationManager == nil {
                locationManager = CLLocationManager()
                locationManager!.delegate = self
                locationManager!.desiredAccuracy = kCLLocationAccuracyBest
                if CLLocationManager.locationServicesEnabled() == false {
                    print("Your location service is not enabled, So go to Settings>Location Services")
                    
                } else {
                    print("Your location service is enabled")
                    locationManager!.startUpdatingLocation()
                    let longitude = locationManager?.location?.coordinate.longitude
                    print(longitude)
                }
//                locationManager!.requestWhenInUseAuthorization()
            }
        
//        let longitude = locationManager?.location?.coordinate.longitude
//        let latitude = locationManager?.location?.coordinate.latitude
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
//        if longitude != nil || latitude != nil{
//            print("longitdude: \(longitude!) latitude: \(latitude!)")
//        }
    }
    //tracking device info
    func trackDeviceInfo(params: NSDictionary?){
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        let deviceModel = withUnsafeBytes(of: &systemInfo.machine) { (rawPtr) -> String in
            let ptr = rawPtr.baseAddress!.assumingMemoryBound(to: CChar.self)
            return String(cString: ptr)
        }
        let iOSVersion = UIDevice.current.systemVersion
        var dict = [
            "track_branch_name" : build ?? "",
            "track_app_version" : version ?? "",
            "track_app_name" : appName ?? "",
            "deviceModel" : "\(UIDevice.current.model) \(deviceModel)" ,
            "track_os_version" : iOSVersion
        ]
        itemDeviceInfo.append(dict)
        VEventType.jsonObj["device-info"] = itemDeviceInfo
        if params == nil {
            dict = [:]
        }else{
            mConfigFunction.logToFile(params: dict as NSDictionary)
        }
    }
    //tracking thong tin ca nhan
    func trackPersonalInfo(params: NSDictionary?) {
        let eventType = VEventType.kTrackPersonalInfo
        
    }
    //tracking cai app
    var defaults = UserDefaults.standard
    func setFirstInstallStatus(firstInstall: Bool) {
        defaults.set(firstInstall, forKey: "firstInstall")
    }
    func getFirstInstallStatus() -> Bool {
        return defaults.object(forKey: "firstInstall") as? Bool ?? false
    }
    func trackAppInstall(params: NSDictionary?){
        if getFirstInstallStatus() == false {
            setFirstInstallStatus(firstInstall: true)
            let dict = ["tracking_app_install": getFirstInstallStatus()]
            var itemEventData = VEventType.jsonObj["event-data"] as? [[String:Any]] ?? [[String:Any]]()
            itemEventData.append(dict)
            VEventType.jsonObj["event-data"] = itemEventData
            mConfigFunction.logToFile(params: dict as NSDictionary)
        } else {


            let dict = ["tracking_app_install": getFirstInstallStatus()]
            var itemEventData = VEventType.jsonObj["event-data"] as? [[String:Any]] ?? [[String:Any]]()
            itemEventData.append(dict)
            VEventType.jsonObj["event-data"] = itemEventData
            mConfigFunction.logToFile(params: dict as NSDictionary)
            return               
        }
    }
    //tracking go app
    func trackAppUninstall(params: NSDictionary?) {
        
    }
    //"track_app_crash": Crash ứng dụng
    func trackAppCrash(params: NSDictionary?) {
        
    }
    // "track_app_start": Mở app chạy mới
    func setAppStartStatus(appStart: Bool) {
        defaults.set(appStart, forKey: "appStart")
    }
    func getAppStartStatus() -> Bool {
        return defaults.object(forKey: "appStart") as? Bool ?? false
    }
    func trackAppStart(params: NSDictionary?) {
        setAppStartStatus(appStart: true)
        let dict = ["track-app-start":getAppStartStatus()]
        itemEventData.append(dict)
        VEventType.jsonObj["event-data"] = itemEventData
        mConfigFunction.logToFile(params: dict as NSDictionary)
    }
    //"track_event_window_open": Mở màn hình
    func trackEventWindowOpen(params: NSDictionary?) {
        
    }
    //"track_event_button_click": Click button, link
    var count = 0
    func trackEventButtonClick(params: NSDictionary?){
        count = count + 1
        let dict = ["track_event_button_click":"tap \(count) times!!"]
        itemEventData.append(dict)
        VEventType.jsonObj["event-data"] = itemEventData
        mConfigFunction.logToFile(params: dict as NSDictionary)
        print("Tap on this button: \(count) times!!")
    }
    //"track_event_window_close": Đóng màn hình
    func trackEventWindowClose(params: NSDictionary?) {
        
    }
    //"track_app_close": Đóng hẳn app (kill)
    func setAppCloseStatus(appStart: Bool) {
        defaults.set(appStart, forKey: "appStart")
    }
    func getAppCloseStatus() -> Bool {
        return defaults.object(forKey: "appStart") as? Bool ?? false
    }
    func trackAppClose(params: NSDictionary?) {
        setAppCloseStatus(appStart: true)
        let dict = ["track-app-close":getAppCloseStatus()]
        itemEventData.append(dict)
        VEventType.jsonObj["event-data"] = itemEventData
        mConfigFunction.logToFile(params: dict as NSDictionary)
        
        
        setAppStartStatus(appStart: false)
        let dic = ["track-app-start":getAppStartStatus()]
        itemEventData.append(dic)
        VEventType.jsonObj["event-data"] = itemEventData
        mConfigFunction.logToFile(params: dic as NSDictionary)
    }
}
