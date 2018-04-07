//
//  ChatControllerService.swift
//  PluggableAppDelegate
//
//  Created by Basem Emara on 2018-04-07.
//  Copyright © 2018 Basem Emara. All rights reserved.
//

import UIKit

class ChatControllerService: ControllerService {
    
    func viewDidLoad(_ controller: UIViewController) {
        debugPrint("ChatControllerService.viewDidLoad")
        // TODO: Example.. chatWorker.subscribe()
    }
}

extension ChatControllerService {
    
    func viewWillAppear(_ controller: UIViewController) {
        debugPrint("ChatControllerService.viewWillAppear")
    }
    
    func viewWillDisappear(_ controller: UIViewController) {
        debugPrint("ChatControllerService.viewWillDisappear")
    }
}
