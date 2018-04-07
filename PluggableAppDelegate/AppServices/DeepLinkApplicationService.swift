//
//  DeepLinkApplicationService.swift
//  PluggableAppDelegate
//
//  Created by Basem Emara on 2018-04-07.
//  Copyright © 2018 Basem Emara. All rights reserved.
//

import UIKit

final class DeepLinkApplicationService: ApplicationService {
    
}

extension DeepLinkApplicationService {
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        // Handle HTTP links only
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let webpageURL = userActivity.webpageURL else { return false }
        return route(from: webpageURL)
    }
}

private extension DeepLinkApplicationService {
    
    /**
     Navigates to the view by URL
     
     - parameter url: URL requested.
     
     - returns: True if the navigation was successful, otherwise false.
     */
    func route(from url: URL) -> Bool {
        // TODO: Route implementation
        return true
    }
}
