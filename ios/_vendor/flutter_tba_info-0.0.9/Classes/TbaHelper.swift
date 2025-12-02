import Foundation
import UIKit
import SystemConfiguration
import WebKit
import AdSupport


enum NetworkType: String {
    case none = "none"
    case wifi = "wifi"
    case cellular = "cellular"
}

func getDistinctId() -> String {
    let userDefaults = UserDefaults.standard
    let distinctKey = "distinctid_native"
    
    if let distinctid = userDefaults.string(forKey: distinctKey) {
        return distinctid
    } else {
        let r = UUID().uuidString
        userDefaults.set(r, forKey: distinctKey)
        return r
    }
}

func getScreenRes() -> String {
    return "\(UIScreen.main.bounds.size.width) * \(UIScreen.main.bounds.size.height)"
}

func getNetworkType() -> NetworkType {
    var networkType: NetworkType = .none
    
    guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") else {
        return networkType
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if SCNetworkReachabilityGetFlags(reachability, &flags) {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let isCellular = flags.contains(.isWWAN)
        
        if isReachable && !needsConnection {
            if isCellular {
                networkType = .cellular
            } else {
                networkType = .wifi
            }
        }
    }
    
    return networkType
}

func getTimeZone() -> String {
    let currentTimeZone = TimeZone.current
    let timeZoneAbbreviation = currentTimeZone.abbreviation() ?? "Unknown"
    let timeZoneName = currentTimeZone.identifier
    
    return "\(timeZoneAbbreviation) (\(timeZoneName))"
}

func getAppVersion() -> String {
    if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
        return appVersion
    } else {
        return "Unknown"
    }
}

func getOSVersion() -> String {
    let osVersion = UIDevice.current.systemVersion
    return osVersion
}

func generateLogId() -> String {
    let logId = UUID().uuidString
    return logId
}


func getBundleID() -> String {
    if let bundleID = Bundle.main.bundleIdentifier {
        return bundleID
    } else {
        return "Unknown"
    }
}

func getDeviceModel() -> String {
    let deviceModel = UIDevice.current.model
    return deviceModel
}

func getSystemLanguage() -> String {
    let preferredLanguages = Locale.preferredLanguages
    guard let systemLanguage = preferredLanguages.first else {
        return "Unknown"
    }
    return systemLanguage
}

func getDeviceCountry() -> String {
    let countryCode = Locale.current.regionCode ?? "Unknown"
    return countryCode
}


func getUserAgent(completion: @escaping (String?) -> Void) {
    let webView = WKWebView(frame: .zero)
    webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
        if let userAgent = result as? String {
            completion(userAgent)
        } else {
            completion(nil)
        }
    }
}

func getIDFA() -> String? {
    let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    return idfa
}


func getIDFV() -> String? {
    let idfv = UIDevice.current.identifierForVendor?.uuidString
    return idfv
}

func getSystemBuildVersion() -> String {
    let systemVersion = UIDevice.current.systemVersion
    return "build/" + systemVersion
}
