//
//  AppDelegate.swift
//  Demo
//
//  Created by Babie Xcode on 10/30/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import UIKit
import VTAM
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        VTracking.shared().configure()
       // var mLocationManager: CLLocationManager?
        var mLastLocation: CLLocation?
//        let params : NSDictionary = ["lat": String(mLastLocation?.coordinate.latitude ?? 0),
//                                     "lng": String(mLastLocation?.coordinate.longitude ?? 0)]
//        VTracking.shared().trackingEvent(eventType: VEventType.kTrackLocation, params: params)
        VTracking.shared().trackingEvent(eventType: VEventType.kTrackAppInstall, params: [:])
        
        VTracking.shared().trackingEvent(eventType: VEventType.kTrackAppStart, params: [:])
        
        VTracking.shared().trackingEvent(eventType: VEventType.kTrackDeviceInfo , params: [:])
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        VTracking.shared().trackingEvent(eventType: VEventType.kTrackScreenClose, params: [:])
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        VTracking.shared().trackingEvent(eventType: VEventType.kTrackScreenOpen, params: [:])
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        print("bla2")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        VTracking.shared().trackingEvent(eventType: VEventType.kTrackAppClose, params: [:])
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

