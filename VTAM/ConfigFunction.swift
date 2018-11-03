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
    func getCurrentTime() ->  String {
        let date = Date()
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    //Ham log ra file, tra ve duong dan file trong local cua may
    func logToFile(params: NSDictionary) -> String{
        let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let file = DocURL.appendingPathComponent("demo2").appendingPathExtension("js")
        
        if FileManager.default.fileExists(atPath: file.path) == false{
            do
            {
                let data = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
                try! data.write(to: file)
            }catch{
                print(error)
            }
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
            let fileHandle = try FileHandle(forWritingTo: file)
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
            fileHandle.closeFile()
            print("pathfile = \(DocURL.path)")
        }catch{
            print(error)
        }
       
//        do {
//            let data = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
//            let fileHandle = try FileHandle(forWritingTo: file)
//            fileHandle.seekToEndOfFile()
//            fileHandle.write(data)
//            fileHandle.closeFile()
//        }catch{
//            print(error)
//        }
        return DocURL.path
    }
    
    //Ham zip file
    func zipFile(filePath: String)  {
        
    }
    
    // tra ve duong dan trong local may
    func getZipFile() -> String {
        
        do {
            
        }catch{
            print(error)
        }
        return ""
    }
    
    //Ham gui zipFile len server
    func sendFile(filePath: String) {
       
    }
    
}
