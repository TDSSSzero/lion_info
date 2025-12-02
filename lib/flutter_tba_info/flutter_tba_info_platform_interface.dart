import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_tba_info_method_channel.dart';

abstract class FlutterTbaInfoPlatform extends PlatformInterface {
  /// Constructs a FlutterTbaInfoPlatform.
  FlutterTbaInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterTbaInfoPlatform _instance = MethodChannelFlutterTbaInfo();

  /// The default instance of [FlutterTbaInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterTbaInfo].
  static FlutterTbaInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterTbaInfoPlatform] when
  /// they register themselves.
  static set instance(FlutterTbaInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
  Future<String> getDistinctId()=>_instance.getDistinctId();
  Future<String> getScreenRes()=>_instance.getDistinctId();
  Future<String> getNetworkType()=>_instance.getDistinctId();
  Future<String> getZoneOffset()=>_instance.getDistinctId();
  Future<String> getGaid()=>_instance.getDistinctId();
  Future<String> getAppVersion()=>_instance.getDistinctId();
  Future<String> getOsVersion()=>_instance.getDistinctId();
  Future<String> getLogId()=>_instance.getDistinctId();
  Future<String> getBrand()=>_instance.getDistinctId();
  Future<String> getBundleId()=>_instance.getDistinctId();
  Future<String> getManufacturer()=>_instance.getDistinctId();
  Future<String> getDeviceModel()=>_instance.getDistinctId();
  Future<String> getAndroidId()=>_instance.getDistinctId();
  Future<String> getSystemLanguage()=>_instance.getDistinctId();
  Future<String> getOsCountry()=>_instance.getDistinctId();
  Future<String> getOperator()=>_instance.getDistinctId();
  Future<String> getDefaultUserAgent()=>_instance.getDefaultUserAgent();
  Future<String> getIdfa()=>_instance.getIdfa();
  Future<String> getIdfv()=>_instance.getIdfv();
  Future<void> jumpToEmail(String email)=>_instance.jumpToEmail(email);
  Future<String> getBuild()=>_instance.getBuild();
  Future<int> getFirstInstallTime()=>_instance.getFirstInstallTime();
  Future<int> getLastUpdateTime()=>_instance.getLastUpdateTime();
}
