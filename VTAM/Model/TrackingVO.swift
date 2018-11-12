//
//  TrackingVO.swift
//  VTAM
//
//  Created by Fate on 11/5/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class TrackingVO {
    var baseUrl = "https://vtam-sdk.viettel.com.vn"
    var trackingCode = ""
    var  PackageId = ""
    var  deviceInfos = DeviceVO()
    var trackingDatas = [TrackingDataVO]()
    var sentDatetime = ""
    
    init(){}
    
    init(data: [String: AnyObject]) {
        trackingCode = data["trackingCode"] as? String ?? ""
        PackageId = data["packageId"] as? String ?? ""
        sentDatetime = data["sentDatetime"] as? String ?? ""
        
        guard let deviceInfosArr = data["deviceInfo"] as? [String: Any] ?? nil else {
            print("Khong the doc")
            return
        }
        
        guard let TrackingDatasArr = data["trackingData"] as? [[String: Any]] ?? nil else {
            print("Khong the doc")
            return
        }
        
        do {
            let DataDeviceInfo = try  JSONSerialization.data(withJSONObject: deviceInfosArr, options: .prettyPrinted)
            let DataDeviceInfoJson = try JSONSerialization.jsonObject(with: DataDeviceInfo, options: .mutableLeaves)
            let result = DataDeviceInfoJson as? [String: AnyObject] ?? nil
            deviceInfos = DeviceVO(data: result!)
        } catch {
            
        }

        for item in TrackingDatasArr {
            do {
                let DataTrackingData = try  JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                let DataTrackingDataJson = try JSONSerialization.jsonObject(with: DataTrackingData, options: .mutableLeaves)
                let result = DataTrackingDataJson as? [String: AnyObject] ?? nil
                let  TrackingData = TrackingDataVO(data: result!)
                trackingDatas.append(TrackingData)
            } catch {
                
            }
        }
        
    }
    func toJsonSTring1() -> [String: Any] {
        
        var parameters = [String: Any]()
        
        parameters["trackingCode"] = trackingCode
        parameters["packageId"] = PackageId
        parameters["deviceInfo"] = deviceInfos.toJsonString1()
        
        var trackingDataJson = [[String : Any]]()
        trackingDatas.forEach { (obj) in
            trackingDataJson.append(obj.toJsonString1())
        }
        parameters["trackingData"] = trackingDataJson
        parameters["sentDatetime"] = sentDatetime
        return parameters
    }
}
//tracking-code
//package-id
//request-id
//device-info
//tracking-data
