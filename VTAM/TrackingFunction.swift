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
    //tracking location
     func trackLocation(params: NSDictionary?) {
        mConfigFunction.logToFile(key: VEventType.kTrackLocation, params: params)
        
//        let dict = [VEventType.kTrackLocation:params]
//        VEventType.itemEventData.append(dict)
//        VEventType.jsonObj["tracking-data"] = VEventType.itemEventData
        
//        var locationManager : CLLocationManager?
//            if locationManager == nil {
//                locationManager = CLLocationManager()
//                locationManager!.delegate = self
//                locationManager!.desiredAccuracy = kCLLocationAccuracyBest
//                if CLLocationManager.locationServicesEnabled() == false {
//                    print("Your location service is not enabled, So go to Settings>Location Services")
//
//                } else {
//                    print("Your location service is enabled")
//                    locationManager!.startUpdatingLocation()
//                    let longitude = locationManager?.location?.coordinate.longitude
//                    print(longitude)
//                }
////                locationManager!.requestWhenInUseAuthorization()
//            }
        
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
    func trackDeviceInfo() {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        var build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        var version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        var appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        var deviceModel = withUnsafeBytes(of: &systemInfo.machine) { (rawPtr) -> String in
            let ptr = rawPtr.baseAddress!.assumingMemoryBound(to: CChar.self)
            return String(cString: ptr)
        }
        var iOSVersion = UIDevice.current.systemVersion
        
        let deviceInfo = [
            "track_branch_name" : build ?? "",
            "track_app_version" : version ?? "",
            "track_app_name" : appName ?? "",
            "deviceModel" :  deviceModel ,
            "track_os_version" : iOSVersion
        ]
        

        mConfigFunction.logToFile(key: VEventType.kTrackDeviceInfo, params: deviceInfo as NSDictionary )

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
//            VEventType.itemEventData.append(dict)
//            VEventType.jsonObj["tracking-data"] = VEventType.itemEventData
            mConfigFunction.logToFile(key: VEventType.kTrackAppInstall, params: dict as NSDictionary)
        }
//        else {
//            let dict = ["tracking_app_install": getFirstInstallStatus()]
//            VEventType.itemEventData.append(dict)
//            VEventType.jsonObj["tracking-data"] = VEventType.itemEventData
//            mConfigFunction.logToFile(key: VEventType.kTrackAppInstall, params: dict as NSDictionary)
//            return
//        }
        
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
        mConfigFunction.logToFile(key: VEventType.kTrackAppStart, params: params)
//        let dict = ["track-app-start":getAppStartStatus()]
//        VEventType.itemEventData.append(dict)
//        VEventType.jsonObj["tracking-data"] = VEventType.itemEventData
//        mConfigFunction.logToFile(key: VEventType.kTrackAppStart, params: dict as NSDictionary)
    }
    
    //"track_event_window_open": Mở màn hình
    func trackEventWindowOpen(params: NSDictionary?) {
        
    }
    
    //"track_event_button_click": Click button, link
//    var count = 0
    func trackEventButtonClick(params: NSDictionary?){
      //  mConfigFunction.logToFile(key: VEventType.kTrackEventButtonClick, params: params)
        let dict = [String: AnyObject]()
        dict["haha"] = ["hihi"]
//        count = count + 1
//        let dict = ["track_event_button_click":"tap \(count) times!!"]
//        VEventType.itemEventData.append(dict)
//        VEventType.jsonObj["tracking-data"] = VEventType.itemEventData
//        mConfigFunction.logToFile(key: VEventType.kTrackEventButtonClick, params: dict as NSDictionary)
//        print("Tap on this button: \(count) times!!")
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
        mConfigFunction.logToFile(key: VEventType.kTrackAppClose, params: params)
        
//        setAppCloseStatus(appStart: true)
//        let dict = ["track-app-close":getAppCloseStatus()]
//        VEventType.itemEventData.append(dict)
//        VEventType.jsonObj["tracking-data"] = VEventType.itemEventData
        
        
        
//        setAppStartStatus(appStart: false)
//        let dic = ["track-app-start":getAppStartStatus()]
//        VEventType.itemEventData.append(dic)
//        VEventType.jsonObj["tracking-data"] = VEventType.itemEventData
//        mConfigFunction.logToFile(params: dic as NSDictionary)
    }
     func bytesIn(directory: String) -> Float64? {
        let fm = FileManager.default
        guard let subdirectories = try? fm.subpathsOfDirectory(atPath: directory) as NSArray else {
            return nil
        }
        let enumerator = subdirectories.objectEnumerator()
        var size: UInt64 = 0
        while let fileName = enumerator.nextObject() as? String {
            do {
                let fileDictionary = try fm.attributesOfItem(atPath: directory.appending("/" + fileName)) as NSDictionary
                size += fileDictionary.fileSize()
            } catch let err {
                print("err getting attributes of file \(fileName): \(err.localizedDescription)")
            }
        }
        return Float64(size)
    }
    
    func appSizeInMegaBytes() -> Float64 {
        // create list of directories
        var paths = [Bundle.main.bundlePath]
        let docDirDomain = FileManager.SearchPathDirectory.documentDirectory
        let docDirs = NSSearchPathForDirectoriesInDomains(docDirDomain, .userDomainMask, true)
        if let docDir = docDirs.first {
            paths.append(docDir) // documents directory
        }
        let libDirDomain = FileManager.SearchPathDirectory.libraryDirectory
        let libDirs = NSSearchPathForDirectoriesInDomains(libDirDomain, .userDomainMask, true)
        if let libDir = libDirs.first {
            paths.append(libDir) // library directory
        }
        paths.append(NSTemporaryDirectory() as String) // temp directory
        
        // combine sizes
        var totalSize: Float64 = 0
        for path in paths {
            if let size = bytesIn(directory: path) {
                totalSize += size
            }
        }
        print(totalSize)
        return totalSize
    }

}
