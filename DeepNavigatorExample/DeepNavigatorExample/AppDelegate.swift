//
//  AppDelegate.swift
//  DeepNavigatorExample
//
//  Created by Qutaibah Essa on 23/01/2020.
//  Copyright © 2020 HungerStation. All rights reserved.
//

import UIKit
import DeepNavigator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var delegates: [UIApplicationDelegate] = [DeeplinkKit.applicationDelegate]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        for delegate in delegates {
            let _ = delegate.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }

            
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        for delegate in delegates {
            delegate.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        for delegate in delegates {
            let _ = delegate.application?(app, open: url, options: options)
        }
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        for delegate in delegates {
            let _ = delegate.application?(application, continue: userActivity, restorationHandler: restorationHandler)
        }
        return false
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print(shortcutItem.type)
    }
}

