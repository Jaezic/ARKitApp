import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainViewController extends GetxController {
  Rx<int> num = 0.obs;
  Rx<String> platformVersionG = 'Unknown'.obs;

  @override
  void onInit() async {
    super.onInit();
    await initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await ArFlutterPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    platformVersionG.value = platformVersion;
  }
}
