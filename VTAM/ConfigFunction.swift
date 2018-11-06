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
    
    private func readJson(fileName: URL) -> [String:AnyObject]{
        do {
            if let file : URL = fileName {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String : AnyObject] {
                    // json is a dictionary
                    print(object)
                    return object
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
        return [String:AnyObject]()
    }
   
    private func fillData(key: String, params: NSDictionary?, data: TrackingVO) -> TrackingVO {
        let tempData = data
        switch key {
        case VEventType.kTrackingConfig:
            tempData.trackingCode = params?.value(forKey: VEventType.kTrackingCode) as! String
            break
        case VEventType.kTrackDeviceInfo:
            tempData.deviceInfos = DeviceVO(data: params as! [String : AnyObject])
            break
        case VEventType.kTrackLocation:
            let trackingData = TrackingDataVO()
            trackingData.eventType = VEventType.kTrackLocation
            trackingData.eventTime = getCurrentTime()
            //lay event
            let eventData = EventDataVO()
            eventData.data = params ?? [:]
            trackingData.eventDatas.append(eventData)
            tempData.trackingDatas.append(trackingData)
            break
        default:
            print("params = \(params)")
            break
        }
        
//        let keys = params!.allKeys
//
//
//        for key in keys {
//            print("key = \(key)")
//            let key = key as! String
//            switch key {
//            case VEventType.kTrackingCode:
////                tempData.trackingCode = params.value(forKey: VEventType.kTrackingCode) as! String
//                break
//            case VEventType.kTrackDeviceInfo:
//                tempData.deviceInfos = DeviceVO(data: params as! [String : AnyObject])
//
//                break
//
//            default:
//                break
//            }
//        }
        
        return tempData
    }
    
    //Ham log ra file, tra ve duong dan file trong local cua may
    let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    func logToFile(key: String, params: NSDictionary?) {
        //neu chua co file
        
//        if (true) {
//            //neu co
//            dataffomFile = //doc tu json
//            trackingData = TrackingVO(data: dataffomFile)
//
//        } else {
//            //
//            trackingData = TrackingVO()
//        }
//
//        //ghifile
//        trackingData?.toJsonSTring()
       
        let file = DocURL.appendingPathComponent(mFileName).appendingPathExtension("js")
        //doc json tu file ra VO
//        readJson(fileName: mFileName)
        if FileManager.default.fileExists(atPath: file.path) == false {
            var trackingData = TrackingVO()
            do
            {
                let data = try JSONSerialization.data(withJSONObject: trackingData.toJsonSTring(), options: [])
                try! data.write(to: file)
            }catch{
                print(error)
            }
        } else {
            var dataFromFile = [String:AnyObject]()
            dataFromFile = readJson(fileName: file)
            let trackingData = TrackingVO(data: dataFromFile)
            do
            {
                let data = try JSONSerialization.data(withJSONObject: trackingData.toJsonSTring(), options: [])
                try! data.write(to: file)
                print(DocURL.path)
            }catch{
                print(error)
            }
            
//            //ghi de vao file da co
//            do {
//                let data = try JSONSerialization.data(withJSONObject: trackingData.toJsonSTring(), options: [])
//                let fileHandle = try FileHandle(forWritingTo: file)
//                fileHandle.write(data)
//                fileHandle.closeFile()
//                print(trackingData.toJsonSTring())
//                print("pathfile = \(DocURL.path)")
//            } catch {
//                print(error)
//            }
        }
        
        
//        return
        //lay data moi params append vao vo
        //ghi de vo vao file
        
        
//        let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//       mPathZip = DocURL
//        var file = DocURL.appendingPathComponent(mFileName).appendingPathExtension("js")
//
//        //neu ten = rong hoac kich thuoc file vuot qua gioi han thi tao file moi
//        if mFileName ==  "" || checkSizeLogFile() {
//            makeFileName()
//            file = DocURL.appendingPathComponent(mFileName).appendingPathExtension("js")
//            mPathFile = file
//            if checkSizeLogFile() {
//                zipFile(password: "")
//            }
//        }
//
//        if FileManager.default.fileExists(atPath: file.path) == false {
//            do
//            {
//                let data = try JSONSerialization.data(withJSONObject: VEventType.jsonObj, options: [])
//                try! data.write(to: file)
//            }catch{
//                print(error)
//            }
//        }
//        do {
//            let data = try JSONSerialization.data(withJSONObject: VEventType.jsonObj, options: [])
//            let fileHandle = try FileHandle(forWritingTo: file)
//            fileHandle.seekToEndOfFile()
//            fileHandle.write(data)
//            fileHandle.closeFile()
//            print("pathfile = \(DocURL.path)")
//        }catch{
//            print(error)
//        }
//
//        do {
//            let data = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
//            let fileHandle = try FileHandle(forWritingTo: file)
//            fileHandle.seekToEndOfFile()
//            fileHandle.write(data)
//            fileHandle.closeFile()
//        }catch{
//            print(error)
//        }
        
//        return DocURL.path
    }
    
    //True can phai zip, failed: van co the ghi dc
    func checkSizeLogFile() -> Bool {
        return false
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
