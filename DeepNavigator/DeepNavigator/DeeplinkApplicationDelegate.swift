//
//  DeeplinkApplicationDelegate.swift
//  DeepNavigator
//
//  Created by Qutaibah Essa on 02/10/2019.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit
import UserNotifications

class DeeplinkApplicationDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: Any], let deeplink = userInfo["uri"] as? String, let url = URL(string: deeplink) {
            DeeplinkKit.center.parse(url: url, source: .launch)
        }
        return true
    }
        
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let deeplink = userInfo["uri"] as? String, let url = URL(string: deeplink) {
            DeeplinkKit.center.parse(url: url, source: .silentNotification)
        }
        completionHandler(UIBackgroundFetchResult.noData)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        DeeplinkKit.center.parse(url: url, source: .openUrl)
        return true
    }
}


extension DeeplinkApplicationDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let deeplink = userInfo["uri"] as? String, let url = URL(string: deeplink) {
            if DeeplinkKit.center.shouldDisplayInApp(url: url) {
                completionHandler([UNNotificationPresentationOptions.alert])
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let deeplink = userInfo["uri"] as? String, let url = URL(string: deeplink) {
            DeeplinkKit.center.parse(url: url, source: .inAppNotificationClick)
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        // not implemented, this one is for showing the user the notification settings
    }
}
