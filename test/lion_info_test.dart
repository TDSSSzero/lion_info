// import 'package:flutter_test/flutter_test.dart';
// import 'package:lion_info/lion_info.dart';
// import 'package:lion_info/lion_info_platform_interface.dart';
// import 'package:lion_info/lion_info_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockLionInfoPlatform
//     with MockPlatformInterfaceMixin
//     implements LionInfoPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final LionInfoPlatform initialPlatform = LionInfoPlatform.instance;

//   test('$MethodChannelLionInfo is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelLionInfo>());
//   });

//   test('getPlatformVersion', () async {
//     LionInfo lionInfoPlugin = LionInfo();
//     MockLionInfoPlatform fakePlatform = MockLionInfoPlatform();
//     LionInfoPlatform.instance = fakePlatform;

//     expect(await lionInfoPlugin.getPlatformVersion(), '42');
//   });
// }
