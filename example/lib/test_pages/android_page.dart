import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lion_info/lion_info.dart';

class AndroidPage extends StatefulWidget {
  const AndroidPage({super.key});
  @override
  State<AndroidPage> createState() => _AndroidPageState();
}

class _AndroidPageState extends State<AndroidPage> {
  final _lion = LionInfo();
  @override
  Widget build(BuildContext context) {
    final actions = <Map<String, Future<dynamic> Function()>>[
      {"getDistinctId": () => _lion.getDistinctId()},
      {"getScreenRes": () => _lion.getScreenRes()},
      {"getNetworkType": () => _lion.getNetworkType()},
      {"getZoneOffset": () => _lion.getZoneOffset()},
      {"getGaid": () => _lion.getGaid()},
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
      {"getInstallReferrer": () async {
        final info = await _lion.getInstallReferrer();
        return info.toMap();
      }},
      {"getDeviceInfo": () => _lion.getDeviceInfo()},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Android 信息')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final item in actions)
                  ElevatedButton(
                    onPressed: () async {
                      final key = item.keys.first;
                      try {
                        final v = await item.values.first();
                        final s = v is Map ? jsonEncode(v) : v.toString();
                        debugPrint('$key => $s');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$key: $s')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$key: $e')),
                        );
                      }
                    },
                    child: Text(item.keys.first),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('获取所有信息中...'), duration: Duration(milliseconds: 800)),
                );
                try {
                  final keys = actions.map((e) => e.keys.first).toList();
                  final futures = actions.map((e) async {
                    final v = await e.values.first();
                    return v is Map ? v : {"value": v};
                  }).toList();
                  final results = await Future.wait(futures);
                  final map = <String, dynamic>{};
                  for (var i = 0; i < keys.length; i++) {
                    map[keys[i]] = results[i];
                  }
                  final s = jsonEncode(map);
                  debugPrint('all => $s');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(s), duration: const Duration(seconds: 5)),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('获取所有信息失败: $e')),
                  );
                }
              },
              child: const Text('获取所有信息'),
            ),
          ],
        ),
      ),
    );
  }
}
