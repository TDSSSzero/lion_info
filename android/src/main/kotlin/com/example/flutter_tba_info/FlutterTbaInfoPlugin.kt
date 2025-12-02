package com.example.flutter_tba_info

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Build.VERSION_CODES.P
import android.telephony.TelephonyManager
import android.util.Log
import android.webkit.WebSettings
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import org.json.JSONObject

/** FlutterTbaInfoPlugin */
class FlutterTbaInfoPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var mApplicationContext:Context
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_tba_info")
    channel.setMethodCallHandler(this)
    mApplicationContext=flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getDistinctId" -> result.success(getDistinctId(mApplicationContext))
      "getScreenRes" -> result.success(getScreenRes(mApplicationContext))
      "getNetworkType" -> result.success(getNetworkType(mApplicationContext))
      "getZoneOffset" -> result.success(getZoneOffset())
      "getGaid" -> GlobalScope.launch { result.success(getGaid(mApplicationContext)) }
      "getAppVersion" -> result.success(getAppVersion(mApplicationContext))
      "getOsVersion" -> result.success(getOsVersion())
      "getLogId" -> result.success(getLogId())
      "getBrand" -> result.success(getBrand())
      "getBundleId" -> result.success(getBundleId(mApplicationContext))
      "getManufacturer" -> result.success(getManufacturer())
      "getDeviceModel" -> result.success(getDeviceModel())
      "getAndroidId" -> result.success(getAndroidId(mApplicationContext))
      "getSystemLanguage" -> result.success(getSystemLanguage())
      "getOsCountry" -> result.success(getOsCountry())
      "getOperator" -> result.success(getOperator(mApplicationContext))
      "getDefaultUserAgent" -> result.success(WebSettings.getDefaultUserAgent(mApplicationContext))
      "jumpToEmail" -> {
        call.arguments?.let {
          runCatching {
            val intent = Intent(Intent.ACTION_SENDTO)
            intent.data = Uri.parse("mailto:")
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            intent.putExtra(Intent.EXTRA_EMAIL, JSONObject(it.toString()).optString("address"))
            mApplicationContext.startActivity(intent)
          }
        }
      }
      "getBuild" -> result.success("build/${Build.VERSION.RELEASE}")
      "getFirstInstallTime" -> result.success(getFirstInstallTime())
      "getLastUpdateTime" -> result.success(getLastUpdateTime())
    }
  }

  private fun getFirstInstallTime():Long{
    try {
      val packageInfo = mApplicationContext.packageManager.getPackageInfo(mApplicationContext.packageName, 0)
      return packageInfo.firstInstallTime
    }catch (e:Exception){

    }
    return System.currentTimeMillis()
  }

  private fun getLastUpdateTime():Long{
    try {
      val packageInfo = mApplicationContext.packageManager.getPackageInfo(mApplicationContext.packageName, 0)
      return packageInfo.lastUpdateTime
    }catch (e:Exception){

    }
    return System.currentTimeMillis()
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
