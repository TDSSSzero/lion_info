import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'flutter_tba_info_platform_interface.dart';

/// An implementation of [FlutterTbaInfoPlatform] that uses method channels.
class MethodChannelFlutterTbaInfo extends FlutterTbaInfoPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_tba_info');


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
    if(Platform.isIOS){
      return "";
    }
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
  Future<String> getIdfa()async{
    if(Platform.isAndroid){
      return "";
    }
    return await methodChannel.invokeMethod("getIdfa");
  }

  @override
  Future<String> getIdfv()async{
    if(Platform.isAndroid){
      return "";
    }
    return await methodChannel.invokeMethod("getIdfv");
  }

  @override
  Future<void> jumpToEmail(String email) async{
    await methodChannel.invokeMethod("jumpToEmail",{"address":email});
  }

  @override
  Future<String> getBuild()async{
    return await methodChannel.invokeMethod("getBuild");
  }

  @override
  Future<int> getFirstInstallTime()async{
    return await methodChannel.invokeMethod("getFirstInstallTime");
  }
  @override
  Future<int> getLastUpdateTime()async{
    return await methodChannel.invokeMethod("getLastUpdateTime");
  }
}
