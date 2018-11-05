//
//  TrackingVO.swift
//  VTAM
//
//  Created by Fate on 11/5/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class TrackingVO {

    var TrackingCode = ""
   var  PackageId = ""
    var RequestId = ""
   var  DeviceInfos = [DeviceVO]()
   var TrackingDatas = [TrackingDataVO]()
    
    init() {}
    
    init(data: [String: AnyObject]) {
        TrackingCode = data["tracking-code"] as? String ?? ""
        PackageId = data["package-id"] as? String ?? ""
        RequestId = data["RequestId"] as? String ?? ""
        
        guard let DeviceInfosArr = data["device-info"] as? [[String: Any]] ?? nil else {
            print("Khong the doc")
            return
        }
        
        guard let TrackingDatasArr = data["tracking-data"] as? [[String: Any]] ?? nil else {
            print("Khong the doc")
            return
        }
        
        
        for item in DeviceInfosArr {
            do {
                let DataDeviceInfo = try  JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                let DataDeviceInfoJson = try JSONSerialization.jsonObject(with: DataDeviceInfo, options: .mutableLeaves)
                let result = DataDeviceInfoJson as? [String: AnyObject] ?? nil
                let  DeviceInfo = DeviceVO(data: result!)
                DeviceInfos.append(DeviceInfo)
            } catch {
                
            }
            
        }
        
        for item in TrackingDatasArr {
            do {
                let DataTrackingData = try  JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                let DataTrackingDataJson = try JSONSerialization.jsonObject(with: DataTrackingData, options: .mutableLeaves)
                let result = DataTrackingDataJson as? [String: AnyObject] ?? nil
                let  TrackingData = TrackingDataVO(data: result!)
                //  tripnearbys.append(tripnearby)
                TrackingDatas.append(TrackingData)
            } catch {
                
            }
            
        }

    }
    
    func toJsonSTring() -> [String: Any] {
        var parameters = [String: Any]()
        parameters["tracking-code"] = TrackingCode
        parameters["package-id"] = PackageId
        parameters["request-id"] = RequestId
        parameters["device-info"] = DeviceInfos
        parameters["tracking-data"] = TrackingDatas

        return parameters
    }
}
//tracking-code
//package-id
//request-id
//device-info
//tracking-data
