//
//  ViewController.swift
//  PluggableAppDelegate
//
//  Created by Basem Emara on 2018-04-06.
//  Copyright © 2018 Basem Emara. All rights reserved.
//

import UIKit

class ViewController: PluggableController {

    override func services() -> [ControllerService] {
        return [
            ChatControllerService()
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

