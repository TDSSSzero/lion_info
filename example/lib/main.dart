import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:lion_info/lion_info.dart';
import 'test_pages/android_page.dart';
import 'test_pages/ios_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _lionInfoPlugin = LionInfo();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _lionInfoPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion'),
              const SizedBox(height: 24),
              Builder(
                builder: (ctx) => Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          ctx,
                          MaterialPageRoute(builder: (_) => const AndroidPage()),
                        );
                      },
                      child: const Text('Android 页面'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          ctx,
                          MaterialPageRoute(builder: (_) => const IosPage()),
                        );
                      },
                      child: const Text('iOS 页面'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
