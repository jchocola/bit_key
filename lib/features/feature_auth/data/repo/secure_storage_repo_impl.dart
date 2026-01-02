// ignore_for_file: constant_identifier_names

import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as security;

class SecureStorageRepoImpl implements SecureStorageRepository {
  final FlutterSecureStorage secureStorage;

  SecureStorageRepoImpl({required this.secureStorage});

  // KEY MANAGEMENT
  static const String SALT_KEY = 'SALT_KEY';
  static const String CONTROL_SUM_STRING_KEY = 'CONTROL_SUM_STRING_KEY';
  static const String SESSION_KEY = 'SESSION_KEY';

  @override
  Future<void> deleteControlSumString() async {
    try {
      await secureStorage.delete(key: CONTROL_SUM_STRING_KEY);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> deleteSalt() async {
    try {
      await secureStorage.delete(key: SALT_KEY);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> deleteSessionKey() {
    try {
      return secureStorage.delete(key: SESSION_KEY);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String?> getControlSumString() async {
    try {
      return await secureStorage.read(key: CONTROL_SUM_STRING_KEY);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String?> getSalt() async {
    try {
      return await secureStorage.read(key: SALT_KEY);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String?> getSessionKey() async {
    try {
      return await secureStorage.read(key: SESSION_KEY);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> setControlSumString(String controlSumString) async {
    try {
      await secureStorage.write(
        key: CONTROL_SUM_STRING_KEY,
        value: controlSumString,
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> setSalt(String salt) async {
    try {
      await secureStorage.write(key: SALT_KEY, value: salt);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> setSessionKey(String sessionKey) async {
    try {
      await secureStorage.write(key: SESSION_KEY, value: sessionKey);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> clearAllSecureData() {
    try {
      return secureStorage.deleteAll();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }


  @override
  Future<String> generateSalt() {
    // TODO: implement generateSalt
    throw UnimplementedError();
  }

 
}
