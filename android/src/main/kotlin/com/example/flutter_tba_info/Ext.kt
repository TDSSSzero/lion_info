package com.example.flutter_tba_info

import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.os.Build
import android.provider.Settings
import android.telephony.TelephonyManager
import android.util.DisplayMetrics
import android.view.WindowManager
import com.google.android.gms.ads.identifier.AdvertisingIdClient
import java.security.MessageDigest
import java.util.*

fun getDistinctId(context: Context)= encrypt(getAndroidId(context))

fun encrypt(raw: String): String {
    var md5Str = raw
    runCatching {
        val md = MessageDigest.getInstance("MD5")
        md.update(raw.toByteArray())
        val encryContext = md.digest()
        var i: Int
        val buf = StringBuffer("")
        for (offset in encryContext.indices) {
            i = encryContext[offset].toInt()
            if (i < 0) {
                i += 256
            }
            if (i < 16) {
                buf.append("0")
            }
            buf.append(Integer.toHexString(i))
        }
        md5Str = buf.toString()
    }
    return md5Str
}

fun getScreenRes(context: Context):String{
    val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
    val displayMetrics = DisplayMetrics()
    windowManager.defaultDisplay.getMetrics(displayMetrics)
    return displayMetrics.density.toString()
}

@SuppressLint("MissingPermission")
fun getNetworkType(context: Context):String{
    runCatching {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetworkInfo = connectivityManager.activeNetworkInfo
        if (activeNetworkInfo != null && activeNetworkInfo.isConnected) {
            if (activeNetworkInfo.type == ConnectivityManager.TYPE_WIFI) {
                return "wifi"
            } else if (activeNetworkInfo.type == ConnectivityManager.TYPE_MOBILE) {
                return "mobile"
            }
        } else {
            return "no"
        }
        return "no"
    }
    return "no"
}

fun getZoneOffset()= (TimeZone.getDefault().rawOffset/3600/1000).toString()

fun getGaid(context: Context)=try {
    AdvertisingIdClient.getAdvertisingIdInfo(context).id
}catch (e:Exception){
    ""
}

fun getAppVersion(context: Context)=context.packageManager.getPackageInfo(context.packageName, PackageManager.GET_META_DATA).versionName

fun getOsVersion()= Build.VERSION.RELEASE

fun getLogId()= UUID.randomUUID().toString()

fun getBrand()= android.os.Build.BRAND

fun getBundleId(context: Context)=context.packageName

fun getManufacturer()= Build.MANUFACTURER

fun getDeviceModel()= Build.MODEL

fun getAndroidId(context: Context): String {
    runCatching {
        val id: String = Settings.Secure.getString(
            context.getContentResolver(),
            Settings.Secure.ANDROID_ID
        )
        return if ("9774d56d682e549c" == id) "" else id ?: ""
    }
    return ""
}

fun getSystemLanguage():String{
    val default = Locale.getDefault()
    return "${default.language}_${default.country}"
}

fun getOsCountry()= Locale.getDefault().country

fun getOperator(context: Context):String{
    runCatching {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        return telephonyManager.networkOperator
    }
    return ""
}