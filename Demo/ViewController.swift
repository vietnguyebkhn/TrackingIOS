//
//  ViewController.swift
//  Demo
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit
import VTAM

<<<<<<< HEAD
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
        
=======
class ViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
>>>>>>> 20ed9f47dfaf002c71e38c0944e6ebd7d3a82170
        //demo tracking location
        VTracking.shared().trackingEvent(eventType: kTrackLocation, params: [:])
        VTracking.shared().trackingEvent(eventType: kTrackDeviceInfo , params: [:])
    }
<<<<<<< HEAD
    
    


=======
>>>>>>> 20ed9f47dfaf002c71e38c0944e6ebd7d3a82170
}
