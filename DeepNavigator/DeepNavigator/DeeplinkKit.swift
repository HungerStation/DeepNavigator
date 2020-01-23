//
//  DeeplinkKit.swift
//  DeepNavigator
//
//  Created by Qutaibah Essa on 02/10/2019.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

public class DeeplinkKit {
    static var scheme: String = "router://"
    public static var center: DeeplinkKit = DeeplinkKit()
    public static var applicationDelegate: UIApplicationDelegate = DeeplinkApplicationDelegate()
    
    private init() {}
    
    private var pending: (url: URL, source: DeeplinkSource)?
    
    private var handlers: [DeeplinkObserver] = []
    
    public func addObserver(deeplink: Deeplink, action: @escaping (_ deeplink: Deeplink,_ params: [String: String]) -> Void) {
        if !deeplink.allowMultipleObservers {
            handlers.removeAll(where: { $0.deeplink.pattern == deeplink.pattern })
        }
        handlers.append(DeeplinkObserver(deeplink: deeplink, action: action))
    }
    
    func parse(url: URL, source: DeeplinkSource) {
        guard UIApplication.shared.applicationState == .active else {
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { [weak self] (notification) in
                self?.parse(url: url, source: source)
            }
            return
        }
        pending = (url: url, source: source)
        for handler in handlers {
            if let params = url.params(for: [handler.deeplink.pattern]) {
                if handler.deeplink.allowedSources.contains(source) {
                    handler.action(handler.deeplink, params)
                    pending = nil
                }
            }
        }
    }
    
    func shouldDisplayInApp(url: URL) -> Bool {
        for handler in handlers {
            if url.params(for: handler.deeplink.pattern) != nil {
                return handler.deeplink.inAppDisplayable
            }
        }
        return true
    }
    
    public func activate() {
        if let pending = pending {
            parse(url: pending.url, source: pending.source)
        }
        pending = nil
    }
}

fileprivate extension URL {
    
    func params(for patterns: String...) -> [String: String]? {
        return params(for: patterns)
    }
    
    func params(for patterns: [String]) -> [String: String]? {
        var params: [String: String]?
        setLoop: for pattern in patterns {
            params = [:]
            let path = self.pathComponents
            let query = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems?.asKeyValue
            
            let pattern = URL(string: DeeplinkKit.scheme + pattern)!
            let patternPath = pattern.pathComponents
            let patternQuery = URLComponents(url: pattern, resolvingAgainstBaseURL: false)?.queryItems?.asKeyValue
            
            guard self.host == pattern.host,
                patternPath.count == path.count,
                patternQuery?.keys.count == query?.keys.count else {
                    params = nil
                    continue setLoop
            }
            for index in 0..<path.count {
                var component = patternPath[index]
                if component.starts(with: ":"), let i = component.firstIndex(of: ":") {
                    component.remove(at: i)
                    params?[component] = path[index]
                    continue
                }
                if path[index] != component {
                    params = nil
                    continue setLoop
                }
            }
            if let patternQuery = patternQuery, let urlQuery = query {
                for (key, value) in urlQuery {
                    if var component = patternQuery[key] as? String, component.starts(with: ":") == true, let i = component.firstIndex(of: ":") {
                        component.remove(at: i)
                        params?[component] = value
                        continue
                    }
                    if patternQuery[key] != value {
                        params = nil
                        continue setLoop
                    }
                }
            }
            return params
        }
        return params
    }
}

fileprivate extension Array where Element == URLQueryItem {
    var asKeyValue: [String: String?] {
        var params = [String: String?]()
        for item in self {
            params[item.name] = item.value
        }
        return params
    }
}

