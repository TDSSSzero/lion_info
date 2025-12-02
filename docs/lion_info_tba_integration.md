# lion_info 与 flutter_tba_info 集成说明

## 模块关系与差异
- lion_info：当前插件的统一设备信息入口，暴露 `MethodChannel('lion_info')`，Dart 层提供 `LionInfo` 封装与 `getDeviceInfo` 聚合接口。Android 侧主要逻辑在 Java `ExtUtils`；iOS 侧使用 Swift/ObjC 的辅助方法。
- flutter_tba_info（tbainfo）：集成的第三方/目标模块，独立的 `MethodChannel('flutter_tba_info')`，Android 使用 Kotlin，iOS 使用 Swift，提供 GAID、安装时间、IDFA/IDFV 等接口。
- 差异要点：
  - 通道名称不同：`lion_info` vs `flutter_tba_info`
  - 平台实现语言不同：lion_info Android（Java）/ iOS（Swift+ObjC）；flutter_tba_info Android（Kotlin）/ iOS（Swift）
  - 能力补充：flutter_tba_info 在 Android 侧补充首次安装/最后更新时间等，在 iOS 侧提供 IDFA/IDFV、邮件跳转等能力。

## 集成方式与调用链
- Android 集成桥接：在 `LionInfoPlugin` 的引擎绑定时，主动注册 `FlutterTbaInfoPlugin`，让两个通道并存。
  - 注册入口：`android/src/main/java/tds/info/lion_info/LionInfoPlugin.java:39`、`android/src/main/java/tds/info/lion_info/LionInfoPlugin.java:42`、`android/src/main/java/tds/info/lion_info/LionInfoPlugin.java:43`
  - 解绑同步：`android/src/main/java/tds/info/lion_info/LionInfoPlugin.java:191`–`android/src/main/java/tds/info/lion_info/LionInfoPlugin.java:195`
- iOS 集成桥接：在 `LionInfoPlugin.register` 中直接调用 `FlutterTbaInfoPlugin.register(with:)`，两个通道并存。
  - 注册入口：`ios/Classes/LionInfoPlugin.swift:6`–`ios/Classes/LionInfoPlugin.swift:10`
- Dart 层再导出与封装：
  - 再导出 tba API：`lib/lion_info.dart:5`（export 'flutter_tba_info/flutter_tba_info.dart'）
  - 统一封装聚合方法：`lib/lion_info.dart:72`–`lib/lion_info.dart:99` 的 `getDeviceInfo`

## API 使用与映射
- lion_info 通用方法（Dart 调用 → 平台实现）：
  - 例如 `LionInfo().getDistinctId()` → Android：`ExtUtils.getDistinctId`；iOS：`getDistinctId()`（Swift）
  - 安装来源信息：Android 侧 `getInstallReferrer` 通过 Play Install Referrer SDK 返回 `InstallReferrerInfo`（Java实现，通道 `lion_info`），参见 `LionInfoPlugin.java:129`–`LionInfoPlugin.java:177`。
- flutter_tba_info 追加方法：
  - Android：`FlutterTbaInfoPlatform.instance.getFirstInstallTime()`、`getLastUpdateTime()` 等（Kotlin），通道 `flutter_tba_info`
  - iOS：`FlutterTbaInfo.instance.getIdfa()`、`getIdfv()`、`getBuild()`、`jumpToEmail(...)`（Swift）
- Dart 再导出示例：
  - 直接使用 tba API：`FlutterTbaInfo.instance.getDistinctId()`（通过 `export` 使其可从 `package:lion_info/lion_info.dart` 被导入）
  - 统一入口：`LionInfo().getDeviceInfo()` 聚合多项信息，统一返回 `Map<String,dynamic>`。

## 典型调用流程
1. 应用导入：`import 'package:lion_info/lion_info.dart';`
2. 统一调用：`final map = await LionInfo().getDeviceInfo();`
3. tba API 调用（可选）：`final idfa = await FlutterTbaInfo.instance.getIdfa();`
4. Android 侧：引擎附加时同时注册 `lion_info` 与 `flutter_tba_info` 两条通道，互不影响（见 `LionInfoPlugin.java:39`–`43`）。
5. iOS 侧：插件注册时调用 `FlutterTbaInfoPlugin.register(with:)`，两条通道同时可用（见 `LionInfoPlugin.swift:9`）。

## 平台差异与兼容
- Android：
  - `getGaid` 在 lion_info 中使用后台线程执行，保证通道不阻塞，见 `LionInfoPlugin.java:64`–`LionInfoPlugin.java:71`。
  - 安装来源 `getInstallReferrer` 提供点击/安装时间、版本等，见 `LionInfoPlugin.java:129`–`LionInfoPlugin.java:177`。
  - 通过 Kotlin 插件启用，已在 `android/build.gradle` 引入 Kotlin 插件与 stdlib，保证 `FlutterTbaInfoPlugin.kt` 参与编译。
- iOS：
  - lion_info 的 `getAndroidId` 在 iOS 返回空字符串，见 `LionInfoPlugin.swift:41`。
  - tba 侧提供 `getIdfa`、`getIdfv` 等 Apple 平台专属接口。

## 示例入口与页面
- 示例主入口：`example/lib/main.dart`，提供导航到 Android/iOS 测试页按钮。
- Android 测试页：`example/lib/test_pages/android_page.dart`，每个方法独立按钮、SnackBar 显示结果，并支持“获取所有信息”。
- iOS 测试页：`example/lib/test_pages/ios_page.dart`，Cupertino 风格按钮与对话框展示结果，并支持“获取所有信息”。

## 设计原则与保留
- 完全保留 flutter_tba_info 的原始结构与实现：源代码镜像在 `lib/flutter_tba_info/`、`android/src/main/kotlin/com/example/flutter_tba_info/`、`ios/Classes/`，并在 `_vendor` 目录保留完整工程快照。
- 不修改原有方法签名与行为：lion_info 只做桥接注册与 Dart 封装，再导出以便复用。
- 保证跨平台兼容：两个通道并存，统一入口不影响原通道使用。

## 常见问题
- 为什么 `export '...' as tba` 报错：Dart 的 `export` 不支持 `as` 前缀，别名仅用于 `import`。当前通过纯 `export` 直接透出 tba 的 API。
- Navigator 报错的修复：示例工程中导航按钮包裹了 `Builder` 使用其 `ctx`，确保上下文包含 `Navigator`。

