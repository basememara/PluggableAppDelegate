//
//  NotificationApplicationService.swift
//  PluggableAppDelegate
//
//  Created by Basem Emara on 2018-04-07.
//  Copyright © 2018 Basem Emara. All rights reserved.
//

import UIKit
import UserNotifications

final class NotificationApplicationService: NSObject, ApplicationService {
    
    enum Category: String {
        case order
        case chat
        case offer
    }
    
    enum Action: String {
        case reply
        case share
    }
    
    let userNotification = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        
        // Listen to login and logout events for push notification registration
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

extension NotificationApplicationService {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        register(
            delegate: self,
            categories: [
                Category.order.rawValue: [
                    UNNotificationAction(
                        identifier: Action.share.rawValue,
                        title: NSLocalizedString("Share", comment: "Share title used for notification."),
                        options: [.foreground]
                    )
                ],
                Category.chat.rawValue: [
                    UNTextInputNotificationAction(
                        identifier: Action.reply.rawValue,
                        title: NSLocalizedString("Reply", comment: "Chat title used for notification."),
                        options: [],
                        textInputButtonTitle: NSLocalizedString("Send", comment: "Chat button used for notification."),
                        textInputPlaceholder: NSLocalizedString("Type your message", comment: "Reply button title used for chat notification.")
                    )
                ],
                Category.offer.rawValue: nil
            ],
            completion: { granted in
                granted
                    ? debugPrint("Authorization for notification succeeded.")
                    : debugPrint("Authorization for notification not given.")
        }
        )
        
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
}

private extension NotificationApplicationService {
    
    /// Registers your app’s notification types and the custom actions that they support.
    ///
    /// - Parameters:
    ///   - category: The category identifier.
    ///   - actions: The actions for the category.
    ///   - authorizations: The authorization options.
    ///   - completion: The callback to process with the granted flag provided.
    func register(
        delegate: UNUserNotificationCenterDelegate? = nil,
        categories: [String: [UNNotificationAction]?],
        authorizations: UNAuthorizationOptions? = [.alert, .badge, .sound],
        completion: ((Bool) -> Void)? = nil) {
        userNotification.delegate = delegate
        
        userNotification.getNotificationSettings { settings in
            let categorySet = Set(categories.map {
                UNNotificationCategory(
                    identifier: $0.key,
                    actions: $0.value ?? [],
                    intentIdentifiers: [],
                    options: .customDismissAction
                )
            })
            
            guard let authorizations = authorizations, settings.authorizationStatus == .notDetermined else {
                // Register category if applicable
                return self.userNotification.getNotificationCategories {
                    defer {
                        let granted = settings.authorizationStatus == .authorized
                        DispatchQueue.main.async { completion?(granted) }
                    }
                    
                    guard categorySet != $0 else { return }
                    self.userNotification.setNotificationCategories(categorySet)
                }
            }
            
            // Request permission before registering if applicable
            self.userNotification.requestAuthorization(options: authorizations) { granted, error in
                defer { DispatchQueue.main.async { completion?(granted) } }
                guard granted else { return }
                self.userNotification.setNotificationCategories(categorySet)
            }
        }
    }
}

extension NotificationApplicationService {
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
}

extension NotificationApplicationService {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // TODO: Register push notifications implementation
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("Failed to register for remote notifications: \(error)")
    }
}

extension NotificationApplicationService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        defer { completionHandler([.alert, .sound]) }
        
        // TODO: Handle notification implementation
        // guard let data = (notification.request.content.userInfo["aps"] as? [String: Any])?["data"] as? [String: Any] else { return }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // TODO: Handle push notification response
        /*
        guard let data = (response.notification.request.content
            .userInfo["aps"] as? [String: Any])?["data"] as? [String: Any]
            else { return completionHandler() }
        
        switch response.notification.request.content.categoryIdentifier {...}
         */
    }
}

private extension NotificationApplicationService {
    
    @objc func authenticationDidLogin(_ notification: NSNotification) {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    @objc func authenticationDidLogout(_ notification: NSNotification) {
        UIApplication.shared.unregisterForRemoteNotifications()
    }
}
