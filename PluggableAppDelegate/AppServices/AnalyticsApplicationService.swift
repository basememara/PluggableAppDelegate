//
//  AnalyticsApplicationService.swift
//  PluggableAppDelegate
//
//  Created by Basem Emara on 2018-04-07.
//  Copyright © 2018 Basem Emara. All rights reserved.
//

import UIKit

final class AnalyticsApplicationService: ApplicationService {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // TODO: Example.. GAI.sharedInstance().tracker(...)
        return true
    }
}
