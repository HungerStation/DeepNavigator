//
//  Deeplink.swift
//  DeepNavigator
//
//  Created by Qutaibah Essa on 15/09/2019.
//  Copyright © 2019 com. All rights reserved.
//

import Foundation

public protocol Deeplink {
    var pattern: String { get }
    var allowMultipleObservers: Bool { get }
    var inAppDisplayable: Bool { get }
    var allowedSources: [DeeplinkSource] { get }
}

public extension Deeplink {
    var allowedSources: [DeeplinkSource] {
        return DeeplinkSource.allCases
    }
}

