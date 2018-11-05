//
//  TrackingVO.swift
//  VTAM
//
//  Created by Fate on 11/5/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class TrackingVO {

    var trackingCode = ""
   var  PackageId = ""
    var RequestId = ""
   var  deviceInfos = DeviceVO()
   var trackingDatas = [TrackingDataVO]()
    
    init(){}
    
    init(data: [String: AnyObject]) {
        trackingCode = data["tracking-code"] as? String ?? ""
        PackageId = data["package-id"] as? String ?? ""
        RequestId = data["RequestId"] as? String ?? ""
        
        guard let deviceInfosArr = data["device-info"] as? [String: Any] ?? nil else {
            print("Khong the doc")
            return
        }
        
        guard let TrackingDatasArr = data["tracking-data"] as? [[String: Any]] ?? nil else {
            print("Khong the doc")
            return
        }
        
        do {
            let DataDeviceInfo = try  JSONSerialization.data(withJSONObject: deviceInfosArr, options: .prettyPrinted)
            let DataDeviceInfoJson = try JSONSerialization.jsonObject(with: DataDeviceInfo, options: .mutableLeaves)
            let result = DataDeviceInfoJson as? [String: AnyObject] ?? nil
              deviceInfos = DeviceVO(data: result!)
//            DeviceInfos.append(DeviceInfo)
        } catch {
            
        }

        
//        for item in DeviceInfosArr {
//            do {
//                let DataDeviceInfo = try  JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
//                let DataDeviceInfoJson = try JSONSerialization.jsonObject(with: DataDeviceInfo, options: .mutableLeaves)
//                let result = DataDeviceInfoJson as? [String: AnyObject] ?? nil
//                let  DeviceInfo = DeviceVO(data: result!)
//                DeviceInfos.append(DeviceInfo)
//            } catch {
//
//            }
//
//        }
//
        for item in TrackingDatasArr {
            do {
                let DataTrackingData = try  JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                let DataTrackingDataJson = try JSONSerialization.jsonObject(with: DataTrackingData, options: .mutableLeaves)
                let result = DataTrackingDataJson as? [String: AnyObject] ?? nil
                let  TrackingData = TrackingDataVO(data: result!)
                //  tripnearbys.append(tripnearby)
                trackingDatas.append(TrackingData)
            } catch {
                
            }
            
        }

    }
    
    func toJsonSTring() -> [String: Any] {
        
        var parameters = [String: Any]()

        parameters["tracking-code"] = trackingCode
        parameters["package-id"] = PackageId
        parameters["request-id"] = RequestId
        parameters["device-info"] = deviceInfos
        parameters["tracking-data"] = trackingDatas

        return parameters
    }
}
//tracking-code
//package-id
//request-id
//device-info
//tracking-data
