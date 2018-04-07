//
//  BootApplicationService.swift
//  PluggableAppDelegate
//
//  Created by Basem Emara on 2018-04-07.
//  Copyright © 2018 Basem Emara. All rights reserved.
//

import UIKit

final class BootApplicationService: ApplicationService {
    
    private var window: UIWindow?
    
    init(with window: UIWindow?) {
        self.window = window
        
        // Listen to login and logout events for window management
        NotificationCenter.default.addObserver(self,
            selector: #selector(authenticationDidLogin(_:)),
            name: Notification.Name("MyAppAuthenticationDidLogin"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(authenticationDidLogout(_:)),
            name: Notification.Name("MyAppAuthenticationDidLogout"),
            object: nil
        )
    }
}

extension BootApplicationService {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        window?.rootViewController = isAuthorized
            ? UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            : UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
        
        return true
    }
    
    private var isAuthorized: Bool {
        // TODO: Determine from Keychain, UserDefault, etc if logged in
        return true
    }
}

private extension BootApplicationService {
    
    @objc func authenticationDidLogin(_ notification: NSNotification) {
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
    @objc func authenticationDidLogout(_ notification: NSNotification) {
        window?.rootViewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
    }
}
