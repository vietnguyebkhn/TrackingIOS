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
    var eventDatas = EventDataVO()
    init(){}
    
    init(data: [String: AnyObject]) {
        eventType = data["event-type"] as? String ?? ""
        objectName = data["object-name"] as? String ?? ""
        eventTime = data["event-time"] as? String ?? ""
        guard let eventDataArr = data["event-data"] as? [String : AnyObject] ?? nil else {
            print("Khong the doc")
            return
        }
        
        
        do {
                    let DataEventData = try  JSONSerialization.data(withJSONObject: eventDataArr, options: .prettyPrinted)
                    let DataEventDataJson = try JSONSerialization.jsonObject(with: DataEventData, options: .mutableLeaves)
                    let result = DataEventDataJson as? [String: AnyObject] ?? nil
                    eventDatas = EventDataVO(data: result!)
            } catch {
                
            }
        
    }
 
    func toJsonString() -> [String: Any] {
        var parameters = [String: Any]()
        parameters["event-type"] = eventType
        parameters["object-name"] = objectName
        parameters["event-time"] = eventTime
        
      //  var eventDataJson = [[String : Any]]()
//        eventDatas.forEach { (obj) in
//            eventDataJson.append(obj.toJsonString())
//        }
        
        parameters["event-data"] = eventDatas.toJsonString()

        return parameters
    }
}
