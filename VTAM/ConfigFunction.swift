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
//    params: NSDictionary
    func logToFile(params: NSDictionary) -> String{
        
        let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocURL.appendingPathComponent("demo").appendingPathExtension("js")
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
            try data.write(to: fileURL,options: [])
            
        }catch{
            print(error)
        }
        print(fileURL.path)
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
