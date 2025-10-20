package tds.info.lion_info;

import android.content.Context;
import android.os.AsyncTask;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** LionInfoPlugin */
public class LionInfoPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context applicationContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "lion_info");
    channel.setMethodCallHandler(this);
    applicationContext = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch(call.method){
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "getDistinctId":
        result.success(ExtUtils.getDistinctId(applicationContext));
        break;
      case "getScreenRes":
        result.success(ExtUtils.getScreenRes(applicationContext));
        break;
      case "getNetworkType":
        result.success(ExtUtils.getNetworkType(applicationContext));
        break;
      case "getZoneOffset":
        result.success(ExtUtils.getZoneOffset());
        break;
      case "getGaid":
        // GAID requires background thread
        AsyncTask.execute(new Runnable() {
          @Override
          public void run() {
            result.success(ExtUtils.getGaid(applicationContext));
          }
        });
        break;
      case "getAppVersion":
        result.success(ExtUtils.getAppVersion(applicationContext));
        break;
      case "getOsVersion":
        result.success(ExtUtils.getOsVersion());
        break;
      case "getLogId":
        result.success(ExtUtils.getLogId());
        break;
      case "getBrand":
        result.success(ExtUtils.getBrand());
        break;
      case "getBundleId":
        result.success(ExtUtils.getBundleId(applicationContext));
        break;
      case "getManufacturer":
        result.success(ExtUtils.getManufacturer());
        break;
      case "getDeviceModel":
        result.success(ExtUtils.getDeviceModel());
        break;
      case "getAndroidId":
        result.success(ExtUtils.getAndroidId(applicationContext));
        break;
      case "getSystemLanguage":
        result.success(ExtUtils.getSystemLanguage());
        break;
      case "getOsCountry":
        result.success(ExtUtils.getOsCountry());
        break;
      case "getOperator":
        result.success(ExtUtils.getOperator(applicationContext));
        break;
      case "getDefaultUserAgent":
        result.success(ExtUtils.getDefaultUserAgent(applicationContext));
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
