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
    var eventDatas = [EventDataVO]()
    init(){}
    
    init(data: [String: AnyObject]) {
        eventType = data["event-type"] as? String ?? ""
        objectName = data["object-name"] as? String ?? ""
        eventTime = data["event-time"] as? String ?? ""
        guard let eventDataArr = data["event-data"] as? [[String : AnyObject]] ?? nil else {
            print("Khong the doc")
            return
        }
        
        for item in eventDataArr {
            do {
                let DataEventData = try  JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                let DataEventDataJson = try JSONSerialization.jsonObject(with: DataEventData, options: .mutableLeaves)
                let result = DataEventDataJson as? [String: AnyObject] ?? nil
                let eventData = EventDataVO(data: result!)
                eventDatas.append(eventData)
            } catch {
                
            }
        }
    }
    
    func toJsonString() -> [String: Any] {
        var parameters = [String: Any]()
        parameters["event-type"] = eventType
        parameters["object-name"] = objectName
        parameters["event-time"] = eventTime
        parameters["event-data"] = eventDatas

        return parameters
    }
}
