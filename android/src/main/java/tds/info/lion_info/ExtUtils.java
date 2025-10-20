package tds.info.lion_info;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;
import android.os.Build;
import android.provider.Settings;
import android.telephony.TelephonyManager;
import android.util.DisplayMetrics;
import android.webkit.WebSettings;

import com.google.android.gms.ads.identifier.AdvertisingIdClient;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Locale;
import java.util.TimeZone;
import java.util.UUID;

public class ExtUtils {

    // 简单缓存，避免重复计算/调用带来性能开销
    private static volatile String sGaid;
    private static volatile String sUserAgent;

    public static String getDistinctId(Context context) {
        return encrypt(getAndroidId(context));
    }

    public static String encrypt(String raw) {
        String md5Str = raw;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(raw.getBytes());
            byte[] encryContext = md.digest();
            StringBuilder buf = new StringBuilder("");
            for (byte b : encryContext) {
                int i = b & 0xff;
                if (i < 16) {
                    buf.append("0");
                }
                buf.append(Integer.toHexString(i));
            }
            md5Str = buf.toString();
        } catch (Exception e) {
            // Keep original value on error
        }
        return md5Str;
    }

    // 返回更符合“分辨率”的信息：width x height @density
    public static String getScreenRes(Context context) {
        DisplayMetrics dm = context.getResources().getDisplayMetrics();
        int w = dm.widthPixels;
        int h = dm.heightPixels;
        float density = dm.density;
        return String.format(Locale.US, "%dx%d@%.2f", w, h, density);
    }

    // 兼容新旧 API 的网络类型获取
    @SuppressLint("MissingPermission")
    public static String getNetworkType(Context context) {
        try {
            ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
            if (cm == null) return "no";
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                // API 23+ 推荐写法
                android.net.Network active = cm.getActiveNetwork();
                if (active != null) {
                    NetworkCapabilities nc = cm.getNetworkCapabilities(active);
                    if (nc != null) {
                        if (nc.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) return "wifi";
                        if (nc.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) return "mobile";
                        if (nc.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) return "ethernet";
                    }
                }
            } else {
                // 旧设备兼容
                NetworkInfo info = cm.getActiveNetworkInfo();
                if (info != null && info.isConnected()) {
                    if (info.getType() == ConnectivityManager.TYPE_WIFI) return "wifi";
                    if (info.getType() == ConnectivityManager.TYPE_MOBILE) return "mobile";
                }
            }
        } catch (Exception e) {
            // Return "no" on any error
        }
        return "no";
    }

    // 包含夏令时的时区偏移，单位：小时（可能为小数）
    public static String getZoneOffset() {
        TimeZone tz = TimeZone.getDefault();
        double hours = tz.getOffset(System.currentTimeMillis()) / 3600000.0;
        return String.valueOf(hours);
    }

    // GAID 获取：检查限制开关 + 简单缓存；注意：该调用可能较慢，建议在后台线程执行
    public static String getGaid(Context context) {
        try {
            if (sGaid != null) return sGaid;
            AdvertisingIdClient.Info adInfo = AdvertisingIdClient.getAdvertisingIdInfo(context);
            if (adInfo != null && !adInfo.isLimitAdTrackingEnabled()) {
                sGaid = adInfo.getId();
                if (sGaid == null) sGaid = "";
            } else {
                sGaid = "";
            }
            return sGaid;
        } catch (Exception e) {
            return "";
        }
    }

    public static String getAppVersion(Context context) {
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
            return packageInfo.versionName != null ? packageInfo.versionName : "";
        } catch (Exception e) {
            return "";
        }
    }

    public static String getOsVersion() {
        return Build.VERSION.RELEASE;
    }

    public static String getLogId() {
        return UUID.randomUUID().toString();
    }

    public static String getBrand() {
        return Build.BRAND;
    }

    public static String getBundleId(Context context) {
        return context.getPackageName();
    }

    public static String getManufacturer() {
        return Build.MANUFACTURER;
    }

    public static String getDeviceModel() {
        return Build.MODEL;
    }

    public static String getAndroidId(Context context) {
        try {
            String id = Settings.Secure.getString(
                context.getContentResolver(),
                Settings.Secure.ANDROID_ID
            );
            if ("9774d56d682e549c".equals(id) || id == null) {
                return "";
            }
            return id;
        } catch (Exception e) {
            return "";
        }
    }

    public static String getSystemLanguage() {
        Locale defaultLocale = Locale.getDefault();
        return defaultLocale.getLanguage() + "_" + defaultLocale.getCountry();
    }

    public static String getOsCountry() {
        return Locale.getDefault().getCountry();
    }

    public static String getOperator(Context context) {
        try {
            TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            if (telephonyManager != null) {
                return telephonyManager.getNetworkOperator();
            }
        } catch (Exception e) {
            // Return empty string on error
        }
        return "";
    }

    public static String getDefaultUserAgent(Context context) {
        try {
            if (sUserAgent != null) return sUserAgent;
            sUserAgent = WebSettings.getDefaultUserAgent(context);
            return sUserAgent != null ? sUserAgent : "";
        } catch (Exception e) {
            String ua = System.getProperty("http.agent");
            sUserAgent = ua != null ? ua : "";
            return sUserAgent;
        }
    }
}