import 'package:bit_key/core/enum/clean_key_duration.dart';
import 'package:bit_key/core/enum/session_timout.dart';

abstract class AppSecurityRepository {
  ///
  /// shake to lock
  ///
  Future<bool> getEnableShakeToLockValue();
  Future<void> toogleShakeToLockValue();

  ///
  /// screen shoot
  ///
  Future<bool> getAllowScreenShootValue();
  Future<void> toogleAllowScreenShootValue();

  ///
  /// clean key duration
  ///
  Future<CLEAN_KEY_DURATION> getCleanKeyDurationValue();
  Future<void> changeCleanKeyDurationValue({required CLEAN_KEY_DURATION value});

  ///
  /// session time out
  ///
  Future<SESSION_TIMEOUT> getSessionTimeOutValue();
  Future<void> changeSessionTimeOutValue({required SESSION_TIMEOUT value});
}
