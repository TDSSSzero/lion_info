
import 'lion_info_platform_interface.dart';
import 'install_referrer_info.dart';

class LionInfo {
  Future<String?> getPlatformVersion() {
    return LionInfoPlatform.instance.getPlatformVersion();
  }
  
  Future<String> getDistinctId(){
    return LionInfoPlatform.instance.getDistinctId();
  }
  Future<String> getScreenRes(){
    return LionInfoPlatform.instance.getScreenRes();
  }
  Future<String> getNetworkType(){
    return LionInfoPlatform.instance.getNetworkType();
  }
  Future<String> getZoneOffset(){
    return LionInfoPlatform.instance.getZoneOffset();
  }
  Future<String> getGaid(){
    return LionInfoPlatform.instance.getGaid();
  }
  Future<String> getAppVersion(){
    return LionInfoPlatform.instance.getAppVersion();
  }
  Future<String> getOsVersion(){
    return LionInfoPlatform.instance.getOsVersion();
  }
  Future<String> getLogId(){
    return LionInfoPlatform.instance.getLogId();
  }
  Future<String> getBrand(){
    return LionInfoPlatform.instance.getBrand();
  }
  Future<String> getBundleId(){
    return LionInfoPlatform.instance.getBundleId();
  }
  Future<String> getManufacturer(){
    return LionInfoPlatform.instance.getManufacturer();
  }
  Future<String> getDeviceModel(){
    return LionInfoPlatform.instance.getDeviceModel();
  }
  Future<String> getAndroidId(){
    return LionInfoPlatform.instance.getAndroidId();
  }
  Future<String> getSystemLanguage(){
    return LionInfoPlatform.instance.getSystemLanguage();
  }
  Future<String> getOsCountry(){
    return LionInfoPlatform.instance.getOsCountry();
  }
  Future<String> getOperator(){
    return LionInfoPlatform.instance.getOperator();
  }
  Future<String> getDefaultUserAgent(){
    return LionInfoPlatform.instance.getDefaultUserAgent();
  }
  Future<void> goNotiSet(){
    return LionInfoPlatform.instance.goNotiSet();
  }
  Future<InstallReferrerInfo> getInstallReferrer(){
    return LionInfoPlatform.instance.getInstallReferrer();
  }
}
