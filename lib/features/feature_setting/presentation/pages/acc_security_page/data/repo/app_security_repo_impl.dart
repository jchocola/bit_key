import 'package:bit_key/core/enum/clean_key_duration.dart';
import 'package:bit_key/core/enum/session_timout.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/domain/repo/app_security_repository.dart';
import 'package:bit_key/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSecurityRepoImpl implements AppSecurityRepository {
  final SharedPreferences sharedPreferences;

  AppSecurityRepoImpl({required this.sharedPreferences});

  ///
  /// KEYS
  ///
  static final String SESSION_KEY = 'SESSION_TIMEOUT';
  static final String CLEAN_KEY = 'CLEAN_KEY_DURATION';
  static final String ENABLE_SCREENSHOOT_KEY = 'ENABLE_SCREENSHOOT';
  static final String SHAKE_TO_LOCK_KEY = 'SHAKE_TO_LOCK';

  @override
  Future<void> changeCleanKeyDurationValue({
    required CLEAN_KEY_DURATION value,
  }) async {
    try {
      await sharedPreferences.setInt(CLEAN_KEY, value.hours);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> changeSessionTimeOutValue({
    required SESSION_TIMEOUT value,
  }) async {
    try {
      await sharedPreferences.setInt(SESSION_KEY, value.minutes);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<bool> getAllowScreenShootValue() async {
    try {
      return sharedPreferences.getBool(ENABLE_SCREENSHOOT_KEY) ?? false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  @override
  Future<CLEAN_KEY_DURATION> getCleanKeyDurationValue() async {
    try {
      final value = sharedPreferences.getInt(CLEAN_KEY) ?? 1;
      return CLEAN_KEY_DURATION.hour1.fromInt(intValue: value);
    } catch (e) {
      logger.e(e);
      return CLEAN_KEY_DURATION.hour1;
    }
  }

  @override
  Future<bool> getEnableShakeToLockValue() async {
    try {
      return sharedPreferences.getBool(SHAKE_TO_LOCK_KEY) ?? true;
    } catch (e) {
      logger.e(e);
      return true;
    }
  }

  @override
  Future<SESSION_TIMEOUT> getSessionTimeOutValue() async {
    try {
      final value = sharedPreferences.getInt(SESSION_KEY) ?? 2;

      return SESSION_TIMEOUT.min2.fromIntValue(value: value);
    } catch (e) {
      logger.e(e);
      return SESSION_TIMEOUT.min2;
    }
  }

  @override
  Future<void> toogleAllowScreenShootValue() async {
    try {
      // get current value
      final currentValue =
          sharedPreferences.getBool(ENABLE_SCREENSHOOT_KEY) ?? false;

      await sharedPreferences.setBool(ENABLE_SCREENSHOOT_KEY, !currentValue);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> toogleShakeToLockValue() async {
    try {
      final currentValue = sharedPreferences.getBool(SHAKE_TO_LOCK_KEY) ?? true;

      await sharedPreferences.setBool(SHAKE_TO_LOCK_KEY, !currentValue);
    } catch (e) {
      logger.e(e);
    }
  }
}
