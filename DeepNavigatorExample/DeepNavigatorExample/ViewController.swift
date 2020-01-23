//
//  ViewController.swift
//  DeepNavigatorExample
//
//  Created by Qutaibah Essa on 23/01/2020.
//  Copyright © 2020 HungerStation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DeeplinkKit.center.addObserver(deeplink: DeeplinkA()) { (deeplink, params) in
            print(params)
        }
        
        DeeplinkKit.center.addObserver(deeplink: Deeplinks.aDeeplink) { (deeplink, params) in
            print(params)
        }

        DeeplinkKit.center.activate()
    }
}

struct DeeplinkA: Deeplink {
    var pattern: String {
        return "order/:id/?s=:query"
    }
    
    var allowMultipleObservers: Bool {
        return true
    }
    
    var inAppDisplayable: Bool {
        return true
    }
}

enum Deeplinks: Deeplink {
    case aDeeplink
    
    var pattern: String {
        return "order/:id/?s=:query"
    }
    
    var allowMultipleObservers: Bool {
        return false
    }
    
    var inAppDisplayable: Bool {
        return true
    }
}

