//
//  VTracking.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit

open class VTracking  {
    private static var sharedVTTracking: VTracking = {
        let vTracking = VTracking()
        // Configuration
        
        return vTracking
    }()
    
    private init(){}
    
    open class func shared() -> VTracking {
        return sharedVTTracking
    }       
    
    
}
