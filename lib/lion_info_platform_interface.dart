import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lion_info_method_channel.dart';

abstract class LionInfoPlatform extends PlatformInterface {
  /// Constructs a LionInfoPlatform.
  LionInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static LionInfoPlatform _instance = MethodChannelLionInfo();

  /// The default instance of [LionInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelLionInfo].
  static LionInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LionInfoPlatform] when
  /// they register themselves.
  static set instance(LionInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
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
}
