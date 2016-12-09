//
//  AppDelegate.swift
//  DemoFlow
//
//  Created by Raptis, Nicholas on 10/13/16.
//  Copyright © 2016 Darkswarm LLC. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /*
    open override var shouldAutorotate : Bool {
        if (visibleViewController as? BounceViewController) != nil {
            //print("NC.shouldAutorotate(false)")
            return false
        }
        return true
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if let vc = visibleViewController {
            //let supported = vc.supportedInterfaceOrientations
            //print("Supported Orientations = \(supported)")
            return vc.supportedInterfaceOrientations
        }
        
        var mask = UIInterfaceOrientationMask(rawValue: 0)
        mask = mask.union(.portrait)
        mask = mask.union(.portraitUpsideDown)
        mask = mask.union(.landscapeLeft)
        mask = mask.union(.landscapeRight)
        return mask
    }
    */
    
}

@UIApplicationMain
class AppDelegate: AppDelegateBase {
    static let root = RootViewController()
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if super.application(application, didFinishLaunchingWithOptions: launchOptions) {
            initialize(withRoot: AppDelegate.root)
            return true
        }
        return false
    }
    
    override func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        super.applicationDidEnterBackground(application)
    }
    
    override func applicationWillEnterForeground(_ application: UIApplication) {
        super.applicationWillEnterForeground(application)
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        super.applicationDidBecomeActive(application)
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        super.applicationWillTerminate(application)
    }
    
}

