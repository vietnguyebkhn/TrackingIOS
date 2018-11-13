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
    var mTimer: Timer?
    var TIME_TO_CALL_SERVER : Double = 5
    
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
    
   var CountError = 0
    @objc func callToServer() {
        let file = DocURL.appendingPathComponent(mFileName).appendingPathExtension("json")
        print("gui len server: \(file)")
        
        if file.path != "" && checkSizeLogFile(file: file) {
            //goi ham gui data len sever o day
            if CountError != 3 {
            sendDataToServer { [weak self](data, response, error) in
                guard let strongself = self else {
                    return
                }
                if error != nil {
                    strongself.CountError += 1
                    print("CountError: \(strongself.CountError)")
                } else {
                    strongself.CountError = 0
                  }
                }
            } else {
                print("3000s sau se gui lai data len server")
                self.CountError = 0
                self.mTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.sendDataToServer(completed:)), userInfo: nil, repeats: true)
                mTimer?.invalidate()
            }
        }
    }
    

    //Ham dinh ky goi len server
    func makeTimeToCallServer() {
        if mTimer == nil {
            self.mTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.callToServer), userInfo: nil, repeats: true)
        }
    }
    
    private func fillData(key: String, params: NSDictionary?, data: TrackingVO) -> TrackingVO {
        let tempData = data
        let trackingData = TrackingDataVO()
        switch key {
        case VEventType.kTrackingConfig:
            var mConfigFunction : ConfigFunction?

            var trackingCode = [String: AnyObject]()
            if let fileUrl = Bundle.main.url(forResource: "SDK-config", withExtension: "plist"),
                let data = try? Data(contentsOf: fileUrl) {
                if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! NSDictionary {
                    trackingCode["trackingCode"] = result["tracking_code"] as AnyObject
                    mConfigFunction?.logToFile(key: VEventType.kTrackingConfig, params: result)
                    tempData.trackingCode = (result["tracking_code"] as AnyObject) as! String
                    
                }
               
            }
            tempData.PackageId = "viettel.sdk.tracking"
            tempData.sentDatetime = getCurrentTime()
            break
        case VEventType.kTrackDeviceInfo:
            tempData.deviceInfos = DeviceVO(data: params as! [String : AnyObject])
            break
        case VEventType.kTrackLocation:
            
            trackingData.objectName = ""
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
            tempData.trackingDatas.append(trackingData)
            break
        case VEventType.kTrackEventButtonClick:
            
            trackingData.objectName = ""
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
            
            tempData.trackingDatas.append(trackingData)
            break
        case VEventType.kTrackScreenOpen:
            
            trackingData.objectName = ""
            trackingData.eventType = VEventType.kTrackScreenOpen
            trackingData.eventTime = getCurrentTime()
            
            var eventData : EventDataVO?
            if params != nil {
                eventData = EventDataVO(data: params as! [String : AnyObject] )
            }else{
                eventData = EventDataVO()
            }
            trackingData.eventDatas = eventData!
            
            tempData.trackingDatas.append(trackingData)
            break
        case VEventType.kTrackScreenClose:
            
            trackingData.objectName = ""
            trackingData.eventType = VEventType.kTrackScreenClose
            trackingData.eventTime = getCurrentTime()
            
            var eventData : EventDataVO?
            if params != nil {
                eventData = EventDataVO(data: params as! [String : AnyObject] )
            }else{
                eventData = EventDataVO()
            }
            trackingData.eventDatas = eventData!
            
            tempData.trackingDatas.append(trackingData)
            break
        case VEventType.kTrackAppInstall:
            trackingData.objectName = ""
            trackingData.eventType = VEventType.kTrackAppInstall
            trackingData.eventTime = getCurrentTime()
            
            var eventData : EventDataVO?
            if params != nil {
                eventData = EventDataVO(data: params as! [String : AnyObject] )
            }else{
                eventData = EventDataVO()
            }
            trackingData.eventDatas = eventData!
            
            tempData.trackingDatas.append(trackingData)
            break
        case VEventType.kTrackAppStart:
            trackingData.objectName = ""
            trackingData.eventType = VEventType.kTrackAppStart
            trackingData.eventTime = getCurrentTime()
            
            var eventData : EventDataVO?
            if params != nil {
                eventData = EventDataVO(data: params as! [String : AnyObject] )
            }else{
                eventData = EventDataVO()
            }
            trackingData.eventDatas = eventData!
            
            tempData.trackingDatas.append(trackingData)
            break
        case VEventType.kTrackAppClose:
            trackingData.objectName = ""
            trackingData.eventType = VEventType.kTrackAppClose
            trackingData.eventTime = getCurrentTime()
            
            var eventData : EventDataVO?
            if params != nil {
                eventData = EventDataVO(data: params as! [String : AnyObject] )
            }else{
                eventData = EventDataVO()
            }
            trackingData.eventDatas = eventData!
            
            tempData.trackingDatas.append(trackingData)
            break
        default:
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
                 //  DataInterval()
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
//           DataInterval()
//            checkSizeLogFile(file: fileURL)
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
        }else{
            writeToFile(data: data!, fileName: mFileName)
        }
    }
    
    @objc func sendDataToServer(completed: @escaping(_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void){
        
        var data: TrackingVO?
        data = readDataFromFile(fileName: mFileName)
        let session = URLSession.shared
       // var err: Error?

        let url = URL(string: "http://sdk.myitsol.com/log-event")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data?.toJsonSTring1(), options: .prettyPrinted)
        } catch let error {
            completed(nil, nil, error)
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                completed(nil, nil, error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    completed(data, response, nil)
                    print(json)
                    self.makeTimeToCallServer()

                    // handle json...
                }
                
            } catch let error {
                completed(nil, nil, error)
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
    
    func checkSizeLogFile(file: URL) -> Bool {
        var logFileSize : UInt64 = 0
        let fm = FileManager.default
        do{
            let fileDic = try fm.attributesOfItem(atPath: file.path) as NSDictionary
            logFileSize += fileDic.fileSize()
            if logFileSize >= 102400 {
              // DataInterval()
                return true
            }else {                
                print("Log file chua du size")
                return false
            }
        }catch{
            print(error)
        }
        
        return false
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
