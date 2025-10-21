package tds.info.lion_info;

import android.content.Context;
import android.os.AsyncTask;
import android.content.Intent;
import android.net.Uri;
import android.provider.Settings;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;

import androidx.annotation.NonNull;

import com.android.installreferrer.api.InstallReferrerClient;
import com.android.installreferrer.api.InstallReferrerStateListener;
import com.android.installreferrer.api.ReferrerDetails;

import java.util.HashMap;
import java.util.Map;

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
      case "goNotiSet": {
        Intent intent = new Intent();
        try {
          if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            intent.setAction(Settings.ACTION_APP_NOTIFICATION_SETTINGS);
            intent.putExtra(Settings.EXTRA_APP_PACKAGE, applicationContext.getPackageName());
          } else if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            intent.setAction("android.settings.APP_NOTIFICATION_SETTINGS");
            intent.putExtra("app_package", applicationContext.getPackageName());
            intent.putExtra("app_uid", applicationContext.getApplicationInfo().uid);
          }
          intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
          applicationContext.startActivity(intent);
        } catch (Exception e) {
          Intent fallbackIntent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
          Uri uri = Uri.fromParts("package", applicationContext.getPackageName(), null);
          fallbackIntent.setData(uri);
          fallbackIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
          applicationContext.startActivity(fallbackIntent);
        }
        result.success(null);
        break;
      }
      case "getInstallReferrer": {
        InstallReferrerClient referrerClient = InstallReferrerClient.newBuilder(applicationContext).build();
        referrerClient.startConnection(new InstallReferrerStateListener() {
          @Override
          public void onInstallReferrerSetupFinished(int responseCode) {
            switch (responseCode) {
              case InstallReferrerClient.InstallReferrerResponse.OK:
                try {
                  ReferrerDetails response = referrerClient.getInstallReferrer();
                  PackageInfo packageInfo = applicationContext.getPackageManager().getPackageInfo(applicationContext.getPackageName(), 0);
                  long firstInstallMs = packageInfo.firstInstallTime;
                  long lastUpdateMs = packageInfo.lastUpdateTime;
                  Map<String, Object> info = new HashMap<>();
                  info.put("installReferrer", response.getInstallReferrer());
                  info.put("referrerClickTimestampMilliseconds", response.getReferrerClickTimestampSeconds() * 1000L);
                  info.put("referrerClickServerTimestampMilliseconds", response.getReferrerClickTimestampServerSeconds() * 1000L);
                  info.put("installBeginTimestampMilliseconds", response.getInstallBeginTimestampSeconds() * 1000L);
                  info.put("installBeginServerTimestampMilliseconds", response.getInstallBeginTimestampServerSeconds() * 1000L);
                  info.put("installFirstSeconds", firstInstallMs / 1000L);
                  info.put("lastUpdateSeconds", lastUpdateMs / 1000L);
                  info.put("googlePlayInstant", response.getGooglePlayInstantParam());
                  result.success(info);
                } catch (Exception e) {
                  result.error("getInstallReferrer_error", e.getMessage(), null);
                } finally {
                  referrerClient.endConnection();
                }
                break;
              case InstallReferrerClient.InstallReferrerResponse.FEATURE_NOT_SUPPORTED:
                // API not available on the current Play Store app.
                referrerClient.endConnection();
                result.success(new HashMap<String, Object>());
                break;
              case InstallReferrerClient.InstallReferrerResponse.SERVICE_UNAVAILABLE:
                // Connection couldn't be established.
                referrerClient.endConnection();
                result.success(new HashMap<String, Object>());
                break;
            }
          }

          @Override
          public void onInstallReferrerServiceDisconnected() {
            // Try to restart the connection on the next request to Google Play by calling the startConnection() method.
          }
        });
        break;
      }
      case "getBuildId":
        result.success(ExtUtils.getBuildId());
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
