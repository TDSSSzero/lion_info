import Flutter
import UIKit

public class LionInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "lion_info", binaryMessenger: registrar.messenger())
    let instance = LionInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "goNotiSet":
      if let url = URL(string: UIApplication.openSettingsURLString) {
        DispatchQueue.main.async {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
      }
      result(nil)
    case "getInstallReferrer":
      // iOS 没有 Play Install Referrer，对齐返回一个空对象
      let info: [String: Any] = [
        "installReferrer": "",
        "referrerClickTimestampMilliseconds": 0,
        "referrerClickServerTimestampMilliseconds": 0,
        "installBeginTimestampMilliseconds": 0,
        "installBeginServerTimestampMilliseconds": 0,
        "installFirstSeconds": 0,
        "lastUpdateSeconds": 0,
        "googlePlayInstant": false
      ]
      result(info)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
