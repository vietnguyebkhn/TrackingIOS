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
    var mPathFile : URL?
    var mPathZip : URL?
    var mFileName = ""
    
    init() {
        let defaults = UserDefaults.standard
        mFileName = defaults.object(forKey: "fileName") as? String ?? ""
    }
    
    //ham get currenttime
    func getCurrentTime() ->  String {
        let date = Date()
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "points", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //Ham doc json tu file
    func readFromFile() -> TrackingVO {
        //read json from file
        
        var trackingData = TrackingVO(data: <#T##[String : AnyObject]#>)
        
        
        return trackingData
    }
    
    //Ham log ra file, tra ve duong dan file trong local cua may
    func logToFile(params: NSDictionary) -> String {
        //doc json tu file ra vo
        //lay data moi params append vao vo
        //ghi de vo vao file
        
        
        let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
       mPathZip = DocURL
        var file = DocURL.appendingPathComponent(mFileName).appendingPathExtension("js")
        
        //neu ten = rong hoac kich thuoc file vuot qua gioi han thi tao file moi
        if mFileName ==  "" || checkSizeLogFile() {
            makeFileName()
            file = DocURL.appendingPathComponent(mFileName).appendingPathExtension("js")
            mPathFile = file
            if checkSizeLogFile() {
                zipFile(password: "")
            }
        }
        
        if FileManager.default.fileExists(atPath: file.path) == false {
            do
            {
                let data = try JSONSerialization.data(withJSONObject: VEventType.jsonObj, options: [])
                try! data.write(to: file)
            }catch{
                print(error)
            }
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: VEventType.jsonObj, options: [])
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
    
    //True can phai zip, failed: van co the ghi dc
    func checkSizeLogFile() -> Bool {
        return true
    }
    
    //ham xoa file
    func removeFile() {
        
    }
    
    //Ham zip file
    func zipFile(password: String)  {
        
    }
    
    // tra ve duong dan trong local may
    func getZipFile() -> String {
        
        do {
            
        } catch{
            print(error)
        }
        return ""
    }
    
    //Ham gui zipFile len server
    func sendFile() {
       
    }
    
    func makeFileName() {
        // Lay timestamp -> chuyen thanh string
        let ticks = Int(Date().timeIntervalSince1970)
        mFileName = String(ticks)
        let defaults = UserDefaults.standard
        defaults.set(mFileName, forKey: "fileName")
    }
}
