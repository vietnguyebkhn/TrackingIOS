//
//  VTracking.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit

open class VTracking  {
    var mTrackingFunction : TrackingFunction!
    private static var sharedVTTracking: VTracking = {
       
        
        let vTracking = VTracking()
        // Configuration
        vTracking.mTrackingFunction = TrackingFunction()
        return vTracking
    }()
    
    private init(){}
    
    open class func shared() -> VTracking {
        
        return sharedVTTracking
    }       
    
    open func trackingEvent(eventType: String, params: NSDictionary?) {
        switch eventType {
        case kTrackLocation:
            mTrackingFunction.trackLocation(params: params)
        case kTrackPersonalInfo:
            mTrackingFunction.trackPersonalInfo(params: params)
            break
        default:
            break
        }
    }
  
}
