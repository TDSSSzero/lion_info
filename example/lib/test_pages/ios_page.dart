import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:lion_info/lion_info.dart';

class IosPage extends StatefulWidget {
  const IosPage({super.key});
  @override
  State<IosPage> createState() => _IosPageState();
}

class _IosPageState extends State<IosPage> {
  final _lion = LionInfo();
  @override
  Widget build(BuildContext context) {
    final actions = <Map<String, Future<dynamic> Function()>>[
      {"getDistinctId": () => _lion.getDistinctId()},
      {"getScreenRes": () => _lion.getScreenRes()},
      {"getNetworkType": () => _lion.getNetworkType()},
      {"getZoneOffset": () => _lion.getZoneOffset()},
      {"getAppVersion": () => _lion.getAppVersion()},
      {"getOsVersion": () => _lion.getOsVersion()},
      {"getLogId": () => _lion.getLogId()},
      {"getBrand": () => _lion.getBrand()},
      {"getBundleId": () => _lion.getBundleId()},
      {"getManufacturer": () => _lion.getManufacturer()},
      {"getDeviceModel": () => _lion.getDeviceModel()},
      {"getAndroidId": () => _lion.getAndroidId()},
      {"getSystemLanguage": () => _lion.getSystemLanguage()},
      {"getOsCountry": () => _lion.getOsCountry()},
      {"getOperator": () => _lion.getOperator()},
      {"getDefaultUserAgent": () => _lion.getDefaultUserAgent()},
      {"getBuildId": () => _lion.getBuildId()},
      {"getDeviceInfo": () => _lion.getDeviceInfo()},
      {"getIdfa": () async { return await FlutterTbaInfo.instance.getIdfa(); }},
      {"getIdfv": () async { return await FlutterTbaInfo.instance.getIdfv(); }},
      {"getBuild": () async { return await FlutterTbaInfo.instance.getBuild(); }},
      {"jumpToEmail": () async { await FlutterTbaInfo.instance.jumpToEmail("test@example.com"); return "ok"; }},
    ];
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('iOS 信息')),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final item in actions)
                  CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    onPressed: () async {
                      final key = item.keys.first;
                      try {
                        final v = await item.values.first();
                        final s = v is Map ? jsonEncode(v) : v.toString();
                        showCupertinoDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                            title: Text(key),
                            content: Text(s),
                            actions: [
                              CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
                            ],
                          ),
                        );
                      } catch (e) {
                        showCupertinoDialog(
                          context: context,
                          builder: (_) => const CupertinoAlertDialog(title: Text('错误'), content: Text('获取失败')),
                        );
                      }
                    },
                    child: Text(item.keys.first),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            CupertinoButton(
              color: CupertinoColors.activeGreen,
              onPressed: () async {
                try {
                  final keys = actions.map((e) => e.keys.first).toList();
                  final futures = actions.map((e) async {
                    final v = await e.values.first();
                    return v is Map ? v : {"value": v};
                  }).toList();
                  final results = await Future.wait(futures);
                  final map = <String, dynamic>{};
                  for (var i = 0; i < keys.length; i++) { map[keys[i]] = results[i]; }
                  final s = jsonEncode(map);
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const Text('全部信息'),
                      content: Text(s),
                      actions: [CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
                    ),
                  );
                } catch (_) {}
              },
              child: const Text('获取所有信息'),
            ),
          ],
        ),
      ),
    );
  }
}
