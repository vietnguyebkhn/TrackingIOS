//
//  ViewController.swift
//  Demo
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit
import VTAM

class ViewController: UIViewController {
    
    var index = 0
    var mPersonalInforViewController: PersonalInforViewController?
    
    @objc func btnClick(_ sender:UIButton) {
        view.endEditing(true)
        self.revealViewController().revealToggle(sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let myBtn : UIButton = UIButton()
        myBtn.setImage(UIImage(named: "menu"), for: .normal)
        myBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        myBtn.addTarget(self, action:  #selector(self.btnClick(_:)) , for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: myBtn), animated: true)
        VTracking.shared().trackingEvent(eventType: kTrackLocation, params: [:])
        VTracking.shared().trackingEvent(eventType: kTrackDeviceInfo , params: [:])
        
    }
}
