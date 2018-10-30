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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //demo tracking location
        VTracking.shared().trackingEvent(eventType: kTrackLocation, params: [:])
        
    }


}

