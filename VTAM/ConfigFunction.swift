//
//  ConfigFunction.swift
//  VTAM
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation
import Zip

class ConfigFunction {
    var urlBase = "https://vtam-sdk.viettel.com.vn"
    var mPathFile : URL?
    var mPathZip : URL?
    var mFileName = ""
    
    init() {
        let defaults = UserDefaults.standard
        mFileName = defaults.object(forKey: "fileName") as? String ?? ""
        mPathFile = defaults.object(forKey: "pathFile") as? URL ?? nil
    }
    
    //ham get currenttime
    func getCurrentTime() ->  String {
        let date = Date()
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
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
            
            var eventData : EventDataVO?
            if params != nil {
                eventData = EventDataVO(data: params as! [String: AnyObject])
            }
            else {
                eventData = EventDataVO()
            }
            trackingData.eventDatas.append(eventData!)
         //   print(eventData?.toJsonString())
            tempData.trackingDatas.append(trackingData)
            break
        case VEventType.kTrackEventButtonClick:
            let trackingData = TrackingDataVO()
            trackingData.eventType = VEventType.kTrackEventButtonClick
            trackingData.eventTime = getCurrentTime()
            //lay event
            
            var eventData : EventDataVO?
            if params != nil {
                eventData = EventDataVO(data: params as! [String: AnyObject])
            }
            else {
                eventData = EventDataVO()
            }
            trackingData.eventDatas.append(eventData!)
            //   print(eventData?.toJsonString())
            tempData.trackingDatas.append(trackingData)
            break
        default:
            print("params = \(String(describing: params))")
            break
        }
        
        return tempData
    }
    
    //ham doc json tu file
    private func readDataFromFile(fileName: String) -> TrackingVO? {
        let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let file = DocURL.appendingPathComponent(fileName).appendingPathExtension("json")
        if FileManager.default.fileExists(atPath: file.path) {
            print("ton tai file \(file.path)")
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file.path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let trackingDataJson = jsonResult as? [String : AnyObject] {
                    // doc data tu json vao obbject
                    let trackingData = TrackingVO(data: trackingDataJson)
                    print("trackingData = \(trackingData.toJsonSTring())")
                    return trackingData
                }
            } catch {
                // handle error
            }
        } else {
            print("khong ton tai file nay")
        }
        return nil
    }
    
    //ham ghi json to file
    private func writeToFile(data: TrackingVO, fileName: String) {
        if fileName.count == 0 {
            return
        }
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName).appendingPathExtension("json")
            print("data ghi = \(data.toJsonSTring())")
            print(documentDirectory.path)
            let data = try JSONSerialization.data(withJSONObject: data.toJsonSTring(), options: [])
            
            try! data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    //Ham log ra file, tra ve duong dan file trong local cua may
    func logToFile(key: String, params: NSDictionary?) {
        var data : TrackingVO?
        if mFileName.count == 0 {
            //neu chua co file thi tao file moi
            makeFileName()
            data = TrackingVO()
        } else {
            //neu da co file thi doc data tu file vao vo
            data = readDataFromFile(fileName: mFileName)
        }
       
        if data != nil {
            //apend vao data
            data = fillData(key: key, params: params, data: data!)
        }
        
        //ghi du lieu moi vao file
        writeToFile(data: data!, fileName: mFileName)
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
//        do {
//
//        } catch {
//            print(error)
//        }
        return ""
    }
    
    //Ham gui zipFile len server
    func sendFile() {
       
    }
    
    private func makeFileName() {
        // Lay timestamp -> chuyen thanh string
        let ticks = Int(Date().timeIntervalSince1970)
        mFileName = String(ticks)
        let defaults = UserDefaults.standard
        defaults.set(mFileName, forKey: "fileName")
        
        let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let file = DocURL.appendingPathComponent(mFileName).appendingPathExtension("json")
        mPathFile = file
        defaults.set(mPathFile, forKey: "pathFile")
    }
}
