//
//  DeeplinkObserver.swift
//  RouterTest
//
//  Created by Qutaibah Essa on 15/09/2019.
//  Copyright © 2019 com. All rights reserved.
//

import Foundation

class DeeplinkObserver {
    var deeplink: Deeplink
    var action: (_ deeplink: Deeplink,_ params: [String: String]) -> Void
    
    init(deeplink: Deeplink, action: @escaping (_ deeplink: Deeplink,_ params: [String: String]) -> Void) {
        self.deeplink = deeplink
        self.action = action
    }
}

