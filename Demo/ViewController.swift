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
        if let location = locations.last {
            mLocationManager?.requestAlwaysAuthorization()
            print("New location is \(location)")
            VTracking.shared().trackingEvent(eventType: kTrackLocation, params: ["location": location])
        }
    }
}
