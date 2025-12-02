import 'dart:io';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';

import 'flutter_tba_info_platform_interface.dart';

class FlutterTbaInfo {

  static final FlutterTbaInfo _instance = FlutterTbaInfo();

  static FlutterTbaInfo get instance => _instance;

  Future<String> getDistinctId(){
    return FlutterTbaInfoPlatform.instance.getDistinctId();
  }
  Future<String> getScreenRes(){
    return FlutterTbaInfoPlatform.instance.getScreenRes();
  }
  Future<String> getNetworkType(){
    return FlutterTbaInfoPlatform.instance.getNetworkType();
  }
  Future<String> getZoneOffset(){
    return FlutterTbaInfoPlatform.instance.getZoneOffset();
  }
  Future<String> getGaid(){
    return FlutterTbaInfoPlatform.instance.getGaid();
  }
  Future<String> getAppVersion(){
    return FlutterTbaInfoPlatform.instance.getAppVersion();
  }
  Future<String> getOsVersion(){
    return FlutterTbaInfoPlatform.instance.getOsVersion();
  }
  Future<String> getLogId(){
    return FlutterTbaInfoPlatform.instance.getLogId();
  }
  Future<String> getBrand(){
    return FlutterTbaInfoPlatform.instance.getBrand();
  }
  Future<String> getBundleId(){
    return FlutterTbaInfoPlatform.instance.getBundleId();
  }
  Future<String> getManufacturer(){
    return FlutterTbaInfoPlatform.instance.getManufacturer();
  }
  Future<String> getDeviceModel(){
    return FlutterTbaInfoPlatform.instance.getDeviceModel();
  }
  Future<String> getAndroidId(){
    return FlutterTbaInfoPlatform.instance.getAndroidId();
  }
  Future<String> getSystemLanguage(){
    return FlutterTbaInfoPlatform.instance.getSystemLanguage();
  }
  Future<String> getOsCountry(){
    return FlutterTbaInfoPlatform.instance.getOsCountry();
  }
  Future<String> getOperator(){
    return FlutterTbaInfoPlatform.instance.getOperator();
  }
  Future<String> getDefaultUserAgent(){
    return FlutterTbaInfoPlatform.instance.getDefaultUserAgent();
  }
  Future<String> getIdfa(){
    return FlutterTbaInfoPlatform.instance.getIdfa();
  }
  Future<String> getIdfv(){
    return FlutterTbaInfoPlatform.instance.getIdfv();
  }
  Future<void> jumpToEmail(String email){
    return FlutterTbaInfoPlatform.instance.jumpToEmail(email);
  }
  Future<String> getBuild(){
    return FlutterTbaInfoPlatform.instance.getBuild();
  }

  Future<Map> getReferrerMap()async{
    var build = await getBuild();
    var userAgent=await getDefaultUserAgent();
    if(Platform.isIOS){
      var nowTime = DateTime.now().millisecondsSinceEpoch;
      var map={
        "build":build,
        "referrer_click_timestamp_seconds":nowTime,
        "install_begin_timestamp_seconds":nowTime,
        "google_play_instant":false,
        "user_agent":userAgent,
        "install_version":"",
        "last_update_seconds":nowTime,
        "install_first_seconds":nowTime,
        "referrer_url":"",
        "install_begin_timestamp_server_seconds":nowTime,
        "referrer_click_timestamp_server_seconds":nowTime,
      };
      return map;
    }else{
      var referrerDetails = await AndroidPlayInstallReferrer.installReferrer;
      var firstInstallTime = await FlutterTbaInfoPlatform.instance.getFirstInstallTime();
      var lastUpdateTime = await FlutterTbaInfoPlatform.instance.getLastUpdateTime();
      var map={
        "build":build,
        "referrer_click_timestamp_seconds":referrerDetails.referrerClickTimestampSeconds,
        "install_begin_timestamp_seconds":referrerDetails.installBeginTimestampSeconds,
        "google_play_instant":referrerDetails.googlePlayInstantParam,
        "user_agent":userAgent,
        "install_version":referrerDetails.installVersion??"",
        "last_update_seconds":lastUpdateTime,
        "install_first_seconds":firstInstallTime,
        "referrer_url":referrerDetails.installReferrer??"",
        "install_begin_timestamp_server_seconds":referrerDetails.installBeginTimestampServerSeconds,
        "referrer_click_timestamp_server_seconds":referrerDetails.referrerClickTimestampServerSeconds,
      };
      return map;
    }
  }
}
