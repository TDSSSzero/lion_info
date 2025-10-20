import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lion_info_platform_interface.dart';
import 'install_referrer_info.dart';

/// An implementation of [LionInfoPlatform] that uses method channels.
class MethodChannelLionInfo extends LionInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lion_info');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  @override
  Future<String> getDistinctId()async{
    return await methodChannel.invokeMethod("getDistinctId");
  }
  @override
  Future<String> getScreenRes()async{
    return await methodChannel.invokeMethod("getScreenRes");
  }
  @override
  Future<String> getNetworkType()async{
    return await methodChannel.invokeMethod("getNetworkType");
  }
  @override
  Future<String> getZoneOffset()async{
    return await methodChannel.invokeMethod("getZoneOffset");
  }
  @override
  Future<String> getGaid()async{
    return await methodChannel.invokeMethod("getGaid");
  }
  @override
  Future<String> getAppVersion()async{
    return await methodChannel.invokeMethod("getAppVersion");
  }
  @override
  Future<String> getOsVersion()async{
    return await methodChannel.invokeMethod("getOsVersion");
  }
  @override
  Future<String> getLogId()async{
    return await methodChannel.invokeMethod("getLogId");
  }
  @override
  Future<String> getBrand()async{
    return await methodChannel.invokeMethod("getBrand");
  }
  @override
  Future<String> getBundleId()async{
    return await methodChannel.invokeMethod("getBundleId");
  }
  @override
  Future<String> getManufacturer()async{
    return await methodChannel.invokeMethod("getManufacturer");
  }
  @override
  Future<String> getDeviceModel()async{
    return await methodChannel.invokeMethod("getDeviceModel");
  }
  @override
  Future<String> getAndroidId()async{
    return await methodChannel.invokeMethod("getAndroidId");
  }
  @override
  Future<String> getSystemLanguage()async{
    return await methodChannel.invokeMethod("getSystemLanguage");
  }
  @override
  Future<String> getOsCountry()async{
    return await methodChannel.invokeMethod("getOsCountry");
  }
  @override
  Future<String> getOperator()async{
    return await methodChannel.invokeMethod("getOperator");
  }
  @override
  Future<String> getDefaultUserAgent()async{
    return await methodChannel.invokeMethod("getDefaultUserAgent");
  }
  @override
  Future<void> goNotiSet() async {
    await methodChannel.invokeMethod("goNotiSet");
  }
  @override
  Future<InstallReferrerInfo> getInstallReferrer() async {
    final map = await methodChannel.invokeMethod("getInstallReferrer");
    return InstallReferrerInfo.fromMap(map);
  }
}
