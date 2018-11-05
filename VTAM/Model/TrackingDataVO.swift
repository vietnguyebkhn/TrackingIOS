//
//  TrackingDataVO.swift
//  VTAM
//
//  Created by Fate on 11/5/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class TrackingDataVO {
    var eventType = ""
    var objectName = ""
    var eventTime = ""
    var eventDataList = [EventDataVO]()
    
    init(data: [String: AnyObject]) {
        eventType = data["event-type"] as? String ?? ""
        objectName = data["object-name"] as? String ?? ""
        eventTime = data["event-time"] as? String ?? ""
        if let response = data["event-time"] as? [[String : AnyObject]] {
            for item in response {
                eventDataList.append(EventDataVO.init(data: item))
            }
        }
    }
}
