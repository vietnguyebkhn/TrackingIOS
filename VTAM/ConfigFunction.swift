//
//  ConfigFunction.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class ConfigFunction {
    var urlBase = "https://vtam-sdk.viettel.com.vn"
    
    //ham get currenttime
    func getCurrentTime() ->  Date {
        return Date()
    }
    //Ham log ra file, tra ve duong dan file trong local cua may
    func logToFile(params: NSDictionary?) -> String {
//        let jsonObj = [
//            "tracking-code":"tracking-code đã cấu hình",
//            "package-id":"packageID/bundleID của ứng dụng",
//            "request-id":"id của request gửi lên",
//            "device-info":[
//                "property": "tên thuộc tính",
//                "value": "giá trị thuộc tính"
//            ],
//            "tracking-data":[
//                "event-type": "mã event",
//                "object-name": "tên object",
//                "event-time": "thời điểm phát sinh event (YYYYMMDDHH24MISS)",
//                "event-data":[
//                    "property": "tên thuộc tính",
//                    "value": "giá trị thuộc tính"
//                ]
//            ]
//            ] as [String : Any]
        let jsonObj = params
        
        let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocURL.appendingPathComponent("demo").appendingPathExtension("js")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
            try data.write(to: fileURL,options: [])
        }catch{
            print(error)
        }

        return fileURL.path
    }
    
    //Ham zip file
    func zipFile(filePath: String)  {
        
    }
    
    // tra ve duong dan trong local may
    func getZipFile() -> String {
        
        return ""
    }
    
    //Ham gui zipFile len server
    func sendFile(filePath: String) {
        
    }
    
}
