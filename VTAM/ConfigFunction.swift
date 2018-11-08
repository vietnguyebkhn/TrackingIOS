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
            var mConfigFunction : ConfigFunction?

            var trackingCode = [String: AnyObject]()
            if let fileUrl = Bundle.main.url(forResource: "SDK-config", withExtension: "plist"),
                let data = try? Data(contentsOf: fileUrl) {
                if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! NSDictionary { // [String: Any] which ever it is
                   // print(result)
                    
                   // print(result["tracking_code"])
                    trackingCode["trackingCode"] = result["tracking_code"] as AnyObject
                    print(trackingCode)
                    mConfigFunction?.logToFile(key: VEventType.kTrackingConfig, params: result)
                    tempData.trackingCode = (result["tracking_code"] as AnyObject) as! String
                    
                    //                urlBase = result
                }
               
            }
            
//            VEventType
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
                eventData = EventDataVO(data: params! as! [String : AnyObject])
            } else {
                eventData = EventDataVO()
            }
            trackingData.eventDatas = eventData!
            //    trackingData.eventDatas.append(eventData!)

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
            trackingData.eventDatas = eventData!

//            trackingData.eventDatas.append(eventData!)
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
    let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    private func readDataFromFile(fileName: String) -> TrackingVO? {
        let file = DocURL.appendingPathComponent(fileName).appendingPathExtension("json")
        if FileManager.default.fileExists(atPath: file.path) == true {
            print("ton tai file \(file.path)")
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file.path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let trackingDataJson = jsonResult as? [String : AnyObject] {
                    // doc data tu json vao object
                    let trackingData = TrackingVO(data: trackingDataJson)
                    print("trackingData = \(trackingData.toJsonSTring1())")
                    return trackingData
                }
            } catch {
                // handle error
            }
        } else {
            makeFileName()
            let DocURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let file = DocURL.appendingPathComponent(mFileName).appendingPathExtension("json")
            do{
                let dataTrack = TrackingVO()
                let data = try JSONSerialization.data(withJSONObject: dataTrack.toJsonSTring1(), options: [])
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                try! data.write(to: file)
                if let trackingDataJson = jsonResult as? [String : AnyObject] {
                    // doc data tu json vao object
                    let trackingData = TrackingVO(data: trackingDataJson)
                    print("trackingData = \(trackingData.toJsonSTring1())")
                    return trackingData
                }
            }catch{
                print(error)
            }
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
            print("data ghi = \(data.toJsonSTring1())")
            print(documentDirectory.path)
            let data = try JSONSerialization.data(withJSONObject: data.toJsonSTring1(), options: [])
            try! data.write(to: fileURL)
            checkSizeLogFile(file: fileURL)
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
            //ghi du lieu moi vao file
            writeToFile(data: data!, fileName: mFileName)
        }
    }
    
    func HTTPsendRequest(request: URLRequest,
                         callback: @escaping (Error?, String?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if (err != nil) {
                callback(err,nil)
            } else {
                callback(nil, String(data: data!, encoding: String.Encoding.utf8))
            
            }
        }
        task.resume()
    }
    
    func HTTPPostJSON(url: String,  data: Data,
                      callback: @escaping (Error?, String?) -> Void) {
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
    //    request.addValue("application/json",forHTTPHeaderField: "Accept")
        request.httpBody = data
        HTTPsendRequest(request: request, callback: callback)
    }
    
    func sendDataToServer(){
        var data: TrackingVO?
        data = readDataFromFile(fileName: mFileName)
      // print(data?.toJsonSTring())
//        let DataTrackingData = try?  JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//        let DataTrackingDataJson = try? JSONSerialization.jsonObject(with: DataTrackingData!, options: .mutableLeaves)
//        let result = DataTrackingDataJson as? [String: AnyObject] ?? nil
        let session = URLSession.shared

      //  let jsonData = try? JSONSerialization.data(withJSONObject: data)
        let url = URL(string: "http://sdk.myitsol.com/log-event")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data?.toJsonSTring1(), options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    //True can phai zip, failed: van co the ghi dc
    func checkSizeLogFile(file: URL) {
        var logFileSize : UInt64 = 0
        let fm = FileManager.default
        do{
            let fileDic = try fm.attributesOfItem(atPath: file.path) as NSDictionary
            logFileSize += fileDic.fileSize()
            if logFileSize < 102400 {
                sendDataToServer()

            }else{
                print("Log file chua du size")
            }
        }catch{
            print(error)
        }
    }
    
    //ham xoa file
    func removeFile(file: URL) {
        do{
            try FileManager.default.removeItem(at: file)
        }catch{
            print("Khong xoa duoc")
        }
    }
    
    //Ham zip file
    func zipFile(file: URL)  {
            do {
                let zipFilePath = DocURL.appendingPathComponent("\(mFileName).zip")
                try Zip.zipFiles(paths: [file], zipFilePath: zipFilePath, password: nil, progress: { (progress) -> () in
                    print(progress)
                })
            }
            catch {
                print("Something went wrong")
            }
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
