//
//  ViewController.swift
//  Demo
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit
import VTAM
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mCheckLocationButton: UIButton!
    var mLocationManager: CLLocationManager?
    var mLastLocation: CLLocation?
    
    var index = 0
    var mPersonalInforViewController: PersonalInforViewController?
    
    @objc func btnClick(_ sender:UIButton) {
        view.endEditing(true)
        self.revealViewController().revealToggle(sender)
    }
    
    
    @IBAction func mCheckLocationTouched(_ sender: Any) {
        mLocationManager?.requestWhenInUseAuthorization()
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mLocationManager = CLLocationManager()
        mLocationManager?.delegate = self
        mLocationManager?.startUpdatingLocation()
        
        let myBtn : UIButton = UIButton()
        myBtn.setImage(UIImage(named: "menu"), for: .normal)
        myBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        myBtn.addTarget(self, action:  #selector(self.btnClick(_:)) , for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: myBtn), animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
           // VTracking.shared().trackingEvent(eventType: kTrackLocation, params: [:])

        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = mLastLocation, let newLocation = locations.last {
            if (lastLocation.distance(from: newLocation) < manager.distanceFilter) {
                return
            }
        }
        
        print("locations \(locations)")
        mLastLocation =  locations.last
        let params : NSDictionary = ["latitude": String(mLastLocation?.coordinate.latitude ?? 0),
                                     "longitude": String(mLastLocation?.coordinate.longitude ?? 0)]
        VTracking.shared().trackingEvent(eventType: VEventType.kTrackLocation, params: params)
        mLocationManager?.stopUpdatingLocation()
    }
}
