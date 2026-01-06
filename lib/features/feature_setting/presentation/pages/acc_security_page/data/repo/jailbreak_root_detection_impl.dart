import 'package:flutter/foundation.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

class JailbreakRootDetectionImpl {
  Future<bool> isNotTrust() async {
    if (kDebugMode) {
      return false;
    }
    return await JailbreakRootDetection.instance.isNotTrust;
  }
}
