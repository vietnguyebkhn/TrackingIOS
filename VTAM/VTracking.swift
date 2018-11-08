//
//  VTracking.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit

@objc open class VTracking : NSObject  {
    var mTrackingFunction : TrackingFunction!
    var mConfigFunction : ConfigFunction?
    private static var sharedVTTracking: VTracking = {
    
        let vTracking = VTracking()
        // Configuration
        vTracking.mTrackingFunction = TrackingFunction()
        vTracking.mConfigFunction = ConfigFunction()
        return vTracking
    }()
    
//    private init(){}
    
    @objc open class func shared() -> VTracking {
        
        return sharedVTTracking
    }       
    
    //Ham thiet lap cac config ban dau cua app
    @objc open func configure() {
        //load cac thiet lap config tu file tracking-info.plist
        
        if let fileUrl = Bundle.main.url(forResource: "SDK-config", withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! NSDictionary { // [String: Any] which ever it is
                print(result)
                mConfigFunction?.logToFile(key: VEventType.kTrackingConfig, params: result)
                
               
//                urlBase = result
            }
        }
        
    }
    //ham tracking cua app
    @objc open func trackingEvent(eventType: String, params: NSDictionary?) {
        switch eventType {
        case VEventType.kTrackLocation:
            mTrackingFunction.trackLocation(params: params)
            break
        case VEventType.kTrackDeviceInfo:
            mTrackingFunction.trackDeviceInfo()
            break
        case VEventType.kTrackAppInstall:
            mTrackingFunction.trackAppInstall(params: params)
            break
        case VEventType.kTrackAppStart:
            mTrackingFunction.trackAppStart(params: params)
            break
        case VEventType.kTrackAppClose:
            mTrackingFunction.trackAppClose(params: params)
            break
        case VEventType.kTrackEventButtonClick:
            mTrackingFunction.trackEventButtonClick(params: params)
            break
        case VEventType.kTrackAppSize:
            mTrackingFunction.appSizeInMegaBytes()
            break
        default:
            break
        }
    }
  
}
