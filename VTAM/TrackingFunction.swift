//
//  TrackingFunction.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation
import CoreLocation
import zlib

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
        
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        let deviceModel = withUnsafeBytes(of: &systemInfo.machine) { (rawPtr) -> String in
            let ptr = rawPtr.baseAddress!.assumingMemoryBound(to: CChar.self)
            return String(cString: ptr)
        }
        let iOSVersion = UIDevice.current.systemVersion as String
       
        let deviceInfo = [
            "branchName" : build ?? "",
            "appVersion" : version ?? "",
            "appName" : appName ?? "",
            "deviceModel" :  deviceModel ,
            "osVersion" : iOSVersion,
            "appSize": appSizeInMegaBytes(),
            "simProvider": "",
            "simMisdn": "",
            "simType": "",
            "osName": "iOS"
            ] as NSDictionary
        mConfigFunction.logToFile(key: VEventType.kTrackDeviceInfo, params: deviceInfo)
    }
    //tracking thong tin ca nhan
    func trackPersonalInfo(params: NSDictionary?) {
        mConfigFunction.logToFile(key: VEventType.kTrackPersonalInfo, params: params)

        
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
            let dict = ["trackAppInstall": getFirstInstallStatus()] as NSDictionary
            mConfigFunction.logToFile(key: VEventType.kTrackAppInstall, params: dict)
        }else{
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
    func trackAppStart(params: NSDictionary?) {
        let dict = ["trackAppStart":true] as NSDictionary
        mConfigFunction.logToFile(key: VEventType.kTrackAppStart, params: dict)
    }
    
    //"track_app_close": Đóng hẳn app (kill)
    func trackAppClose(params: NSDictionary?) {
        let dict = ["trackAppStart":false,
                    "trackAppClose":true] as NSDictionary
        mConfigFunction.logToFile(key: VEventType.kTrackAppClose, params: dict)
    }
    //Mở màn hình
    func trackScreenOpen() {
        let statusDict = ["trackEventWindowOpen":true,
                          "trackEventWindowClose":false] as NSDictionary
        mConfigFunction.logToFile(key: VEventType.kTrackScreenOpen, params: statusDict)
    }
    //Đóng màn hình
    func trackScreenClose(){
        let statusDict = ["trackEventWindowClose": true,
                          "trackEventWindowOpen":false] as NSDictionary
        mConfigFunction.logToFile(key: VEventType.kTrackScreenClose, params: statusDict)
    }
    // Button Click
    var count = 0
    func trackEventButtonClick(params: NSDictionary?){
        count = count + 1
        let dict = ["trackEventButtonClick": count] as NSDictionary
        mConfigFunction.logToFile(key: VEventType.kTrackEventButtonClick, params: dict)
    }
     func bytesIn(directory: String) ->  UInt64? {
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
        return UInt64(size)
    }
    func appSizeInMegaBytes() -> UInt64 {
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
        var totalSize: UInt64 = 0
        for path in paths {
            if let size = bytesIn(directory: path) {
                totalSize += size
            }
        }
        return totalSize
    }

}
