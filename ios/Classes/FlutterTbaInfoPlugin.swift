import Flutter
import UIKit
import MessageUI

public class FlutterTbaInfoPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_tba_info", binaryMessenger: registrar.messenger())
        let instance = FlutterTbaInfoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getDistinctId":
            result(getDistinctId())
        case "getScreenRes":
            result(getScreenRes())
        case "getNetworkType":
            result(getNetworkType().rawValue)
        case "getZoneOffset":
            result(getTimeZone())
        case "getGaid":
            result(NetworkHelper.netInfo())
        case "getAppVersion":
            result(getAppVersion())
        case "getOsVersion":
            result(getOSVersion())
        case "getLogId":
            result(generateLogId())
        case "getBrand":
            result("Apple")
        case "getBundleId":
            result(getBundleID())
        case "getManufacturer":
            result("Apple")
        case "getDeviceModel":
            result(getDeviceModel())
        case "getSystemLanguage":
            result(getSystemLanguage())
        case "getOsCountry":
            result(getDeviceCountry())
        case "getOperator":
            result("")
        case "getDefaultUserAgent":
            getUserAgent { ua in
                if let u = ua {
                    result(u)
                } else {
                    result("")
                }
            }
            result("test")
        case "getIdfa":
            result(getIDFA() ?? "")
        case "getIdfv":
            result(getIDFV() ?? "")
        case "jumpToEmail":
            if let arguments = call.arguments as? [String: Any],
               let mailAddress = arguments["address"] as? String {
                let r = sendEmail(address: mailAddress)
                result(r)
            } else {
                result(false)
            }
        case "getBuild":
            result(getSystemBuildVersion())
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension FlutterTbaInfoPlugin {
    func sendEmail(address: String) -> Bool{
let email = "mailto:\(address)"
        if let emailURL = URL(string: email) {
            UIApplication.shared.open(emailURL)
            return true
        }
        return false
    }
}
