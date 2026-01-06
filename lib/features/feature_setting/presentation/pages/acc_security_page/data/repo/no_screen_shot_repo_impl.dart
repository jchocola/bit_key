import 'package:bit_key/main.dart';
import 'package:no_screenshot/no_screenshot.dart';

class NoScreenShotRepoImpl {
  final _noScreenshot = NoScreenshot.instance;

  Future<void> enableScreenshot() async {
  bool result = await _noScreenshot.screenshotOn();
  logger.d('Enable Screenshot: $result');
}

  Future<void> disableScreenshot() async {
  bool result = await _noScreenshot.screenshotOff();
  logger.d('Screenshot Off: $result');
}
}