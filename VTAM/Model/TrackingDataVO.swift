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
        eventType = data["eventType"] as? String ?? ""
        objectName = data["objectName"] as? String ?? ""
        eventTime = data["eventTime"] as? String ?? ""
        guard let eventDataArr = data["eventData"] as? [String : AnyObject] ?? nil else {
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
 
//    func toJsonString() -> [String: Any] {
//        var parameters = [String: Any]()
//        parameters["event-type"] = eventType
//        parameters["object-name"] = objectName
//        parameters["event-time"] = eventTime
//        
//      //  var eventDataJson = [[String : Any]]()
////        eventDatas.forEach { (obj) in
////            eventDataJson.append(obj.toJsonString())
////        }
//        
//        parameters["event-data"] = eventDatas.toJsonString()
//
//        return parameters
//    }
    
    func toJsonString1() -> [String: Any] {
        var parameters = [String: Any]()
        parameters["eventType"] = eventType
        parameters["objectName"] = objectName
        parameters["eventTime"] = eventTime
        
        //  var eventDataJson = [[String : Any]]()
        //        eventDatas.forEach { (obj) in
        //            eventDataJson.append(obj.toJsonString())
        //        }
        
        parameters["eventData"] = eventDatas.toJsonString()
        
        return parameters
    }

}
