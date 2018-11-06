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
    var RequestId = ""
    var  deviceInfos = DeviceVO()
    var trackingDatas = [TrackingDataVO]()
    
    init() {}
    
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
        
<<<<<<< HEAD
//            do{
//                let DataEventData = try JSONSerialization.data(withJSONObject: TrackingDatasArr, options: .prettyPrinted)
//                let DataEventDataJson = try JSONSerialization.jsonObject(with: DataEventData, options: .mutableLeaves)
//                let result = DataEventDataJson as? [String:AnyObject] ?? nil
//                let trackingData = TrackingDataVO(data: result!)
//                trackingDatas.append(trackingData)
//            }catch{
//
//            }
            do {
                let DataDeviceInfo = try  JSONSerialization.data(withJSONObject: deviceInfosArr, options: .prettyPrinted)
                let DataDeviceInfoJson = try JSONSerialization.jsonObject(with: DataDeviceInfo, options: .mutableLeaves)
                let result = DataDeviceInfoJson as? [String: AnyObject] ?? nil
                deviceInfos = DeviceVO(data: result!)
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
=======
        do {
            let DataDeviceInfo = try  JSONSerialization.data(withJSONObject: deviceInfosArr, options: .prettyPrinted)
            let DataDeviceInfoJson = try JSONSerialization.jsonObject(with: DataDeviceInfo, options: .mutableLeaves)
            let result = DataDeviceInfoJson as? [String: AnyObject] ?? nil
              deviceInfos = DeviceVO(data: result!)
        } catch {
            
        }
>>>>>>> 52b891c4c98290794152db18c43c94aaa32a3648
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
    
    func toJsonSTring() -> [String: Any] {
        var parameters = [String: Any]()
        parameters["tracking-code"] = trackingCode
        parameters["package-id"] = PackageId
        parameters["request-id"] = RequestId
        parameters["device-info"] = deviceInfos.toJsonString()
        
        var trackingDataJson = [[String : Any]]()
        trackingDatas.forEach { (obj) in
            trackingDataJson.append(obj.toJsonString())
        }        
        parameters["tracking-data"] = trackingDataJson

        return parameters
    }
}
//tracking-code
//package-id
//request-id
//device-info
//tracking-data
