import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lion_info_method_channel.dart';
import 'install_referrer_info.dart';

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

  Future<String> getDistinctId(){
    throw UnimplementedError('getDistinctId() has not been implemented.');
  }
  Future<String> getScreenRes(){
    throw UnimplementedError('getScreenRes() has not been implemented.');
  }
  Future<String> getNetworkType(){
    throw UnimplementedError('getNetworkType() has not been implemented.');
  }
  Future<String> getZoneOffset(){
    throw UnimplementedError('getZoneOffset() has not been implemented.');
  }
  Future<String> getGaid(){
    throw UnimplementedError('getGaid() has not been implemented.');
  }
  Future<String> getAppVersion(){
    throw UnimplementedError('getAppVersion() has not been implemented.');
  }
  Future<String> getOsVersion(){
    throw UnimplementedError('getOsVersion() has not been implemented.');
  }
  Future<String> getLogId(){
    throw UnimplementedError('getLogId() has not been implemented.');
  }
  Future<String> getBrand(){
    throw UnimplementedError('getBrand() has not been implemented.');
  }
  Future<String> getBundleId(){
    throw UnimplementedError('getBundleId() has not been implemented.');
  }
  Future<String> getManufacturer(){
    throw UnimplementedError('getManufacturer() has not been implemented.');
  }
  Future<String> getDeviceModel(){
    throw UnimplementedError('getDeviceModel() has not been implemented.');
  }
  Future<String> getAndroidId(){
    throw UnimplementedError('getAndroidId() has not been implemented.');
  }
  Future<String> getSystemLanguage(){
    throw UnimplementedError('getSystemLanguage() has not been implemented.');
  }
  Future<String> getOsCountry(){
    throw UnimplementedError('getOsCountry() has not been implemented.');
  }
  Future<String> getOperator(){
    throw UnimplementedError('getOperator() has not been implemented.');
  }
  Future<String> getDefaultUserAgent(){
    throw UnimplementedError('getDefaultUserAgent() has not been implemented.');
  }
  Future<void> goNotiSet(){
    throw UnimplementedError('goNotiSet() has not been implemented.');
  }
  Future<InstallReferrerInfo> getInstallReferrer(){
    throw UnimplementedError('getInstallReferrer() has not been implemented.');
  }
  Future<String> getBuildId(){
    throw UnimplementedError('getBuildId() has not been implemented.');
  }
}
