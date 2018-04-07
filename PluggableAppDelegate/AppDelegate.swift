//
//  AppDelegate.swift
//  PluggableAppDelegate
//
//  Created by Basem Emara on 2018-04-06.
//  Copyright © 2018 Basem Emara. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {

    override func services() -> [ApplicationService] {
        return [
            ErrorApplicationService(),
            LoggerApplicationService(),
            AnalyticsApplicationService(),
            BootApplicationService(with: window),
            ShortcutApplicationService(),
            NotificationApplicationService(),
            ThemeApplicationService()
        ]
    }
}

extension AppDelegate {
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        ShortcutApplicationService()
            .application(application, performActionFor: shortcutItem, completionHandler: completionHandler)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        return DeepLinkApplicationService()
            .application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
}
