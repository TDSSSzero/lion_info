import Flutter
import UIKit
import Darwin

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
    case "getBuildId":
      result(getOSBuildId())
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  private func getOSBuildId() -> String {
    var size: size_t = 0
    // kern.osversion 返回类似 "21A559" 的构建号
    sysctlbyname("kern.osversion", nil, &size, nil, 0)
    var buffer = [CChar](repeating: 0, count: Int(size))
    let rc = sysctlbyname("kern.osversion", &buffer, &size, nil, 0)
    if rc == 0 {
      return String(cString: buffer)
    } else {
      // 兜底：返回完整系统版本字符串
      return ProcessInfo.processInfo.operatingSystemVersionString
    }
  }
}
