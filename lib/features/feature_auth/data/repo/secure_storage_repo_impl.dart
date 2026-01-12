// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/main.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/pointycastle.dart';

class SecureStorageRepoImpl implements SecureStorageRepository {
  final FlutterSecureStorage secureStorage;
  final KeyDerivator keyDerivator;
  final AEADCipher aeadCipher;

  SecureStorageRepoImpl({
    required this.secureStorage,
    required this.keyDerivator,
    required this.aeadCipher,
  });

  // KEY MANAGEMENT
  static const String SALT_KEY = 'SALT_KEY';
  static const String HASHED_MASTER_KEY = 'HASHED_MASTER_KEY';
  static const String SESSION_KEY = 'SESSION_KEY';
  static const String ENCRYPTED_MASTER_KEY = 'ENCRYPTED_MASTER_KEY';

  @override
  Future<void> deleteControlSumString() async {
    try {
      await secureStorage.delete(key: HASHED_MASTER_KEY);
      logger.i('Control Sum String deleted from secure storage');
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_delete_hashed_master_key;
    }
  }

  @override
  Future<void> deleteSalt() async {
    try {
      await secureStorage.delete(key: SALT_KEY);
      logger.i('SALT deleted from secure storage');
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_delete_salt;
    }
  }

  @override
  Future<void> deleteSessionKey() async {
    try {
      await secureStorage.delete(key: SESSION_KEY);
      logger.i('Session Key deleted from secure storage');
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_delete_session_key;
    }
  }

  @override
  Future<String?> getHashedMasterKey() async {
    try {
      return await secureStorage.read(key: HASHED_MASTER_KEY);
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_get_hashed_master_key;
    }
  }

  @override
  Future<String?> getSalt() async {
    try {
      return await secureStorage.read(key: SALT_KEY);
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_get_salt;
    }
  }

  @override
  Future<String?> getSessionKey() async {
    try {
      return await secureStorage.read(key: SESSION_KEY);
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_get_session_key;
    }
  }

  @override
  Future<void> setHashedMasterKey(String hashedMasterKey) async {
    try {
      await secureStorage.write(key: HASHED_MASTER_KEY, value: hashedMasterKey);
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_set_hashed_master_key;
    }
  }

  @override
  Future<void> setSalt(String salt) async {
    try {
      await secureStorage.write(key: SALT_KEY, value: salt);
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_set_salt;
    }
  }

  @override
  Future<void> setSessionKey(String sessionKey) async {
    try {
      await secureStorage.write(key: SESSION_KEY, value: sessionKey);
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_set_session_key;
    }
  }

  @override
  Future<void> clearAllSecureData() {
    try {
      return secureStorage.deleteAll();
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_clear_all_secure_data;
    }
  }

  @override
  Future<String> generateSalt() {
    try {
      // For simplicity, using a timestamp as a salt. In production, use a more secure method.
      final salt = DateTime.now().millisecondsSinceEpoch.toString();
      return Future.value(salt);
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_generate_salt;
    }
  }

  @override
  Future<bool> isMasterKeyValid(String masterKey) async {
    try {
      final salt = await getSalt();
      final hashedMasterKey = await getHashedMasterKey();

      if (salt != null && hashedMasterKey != null) {
        final hashedMasterKeyNew = await generateHashedMasterKey(
          masterKey: masterKey,
          salt: salt,
        );

        logger.e('HASHED MASTER KEY NEW : $hashedMasterKeyNew');
        logger.e('HASHED MASTER KEY REAL : $hashedMasterKey');
        return hashedMasterKeyNew == hashedMasterKey;
      }

      return false;
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_check_validity_master_key;
    }
  }

  @override
  Future<void> deleteEncryptedMasterKey() async {
    try {
      await secureStorage.delete(key: ENCRYPTED_MASTER_KEY);
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_delete_encrypted_master_key;
    }
  }

  @override
  Future<String?> getEncryptedMasterKey() async {
    try {
      return await secureStorage.read(key: ENCRYPTED_MASTER_KEY);
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_get_encrypted_master_key;
    }
  }

  @override
  Future<void> setEncryptedMasterKey(String encryptedMasterKey) async {
    try {
      await secureStorage.write(
        key: ENCRYPTED_MASTER_KEY,
        value: encryptedMasterKey,
      );
    } catch (e) {
      logger.e(e);
       throw AppException.failed_to_set_encrypted_master_key;
    }
  }

  @override
  Future<String> generateHashedMasterKey({
    required String masterKey,
    required String salt,
  }) async {
    try {
      // 1. Конвертируем строки в байты
      final passwordBytes = utf8.encode(masterKey);
      final saltBytes = utf8.encode(salt);

      // 3. Создаём параметры Argon2
      final params = Argon2Parameters(
        Argon2Parameters.ARGON2_id, // Тип: Argon2id (рекомендуется)
        saltBytes, // Соль
        desiredKeyLength: 32, // 32 байта = 256 бит для AES-256
        iterations: 3, // 3 итерации (~1 секунда на мобильном)
        memory: 1 << 16, // 65536 КБ = 64 МБ памяти
        // ИЛИ используйте явное значение:
        // memory: 65536,
        lanes: 1, // 1 поток для мобильных устройств
        version: Argon2Parameters.ARGON2_VERSION_13, // Актуальная версия
        // Опционально: добавляем секретный pepper
        // secret: _getDeviceSpecificKey(),
        // additional: utf8.encode('MyVaultApp'),
      );

      // 4. Инициализируем генератор
      keyDerivator.init(params);

      // 5. Создаём выходной буфер для ключа
      final output = Uint8List(params.desiredKeyLength);

      // 6. Генерируем ключ
      final generatedBytes = keyDerivator.process(
        Uint8List.fromList(passwordBytes),
      );

      // Копируем результат в output
      output.setAll(0, generatedBytes);

      // 7. Возвращаем в base64 для удобства хранения
      final base64Key = base64Encode(output);

      // 8. Очищаем чувствительные данные из памяти
      passwordBytes.fillRange(0, passwordBytes.length, 0);
      output.fillRange(0, output.length, 0);
      generatedBytes.fillRange(0, generatedBytes.length, 0);

      return base64Key;
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_generate_hashed_master_key;
    }
  }

  @override
  Future<String> generateSessionKey() async {
    try {
      // For simplicity, using a timestamp as a salt. In production, use a more secure method.
      final sessionKey = DateTime.now().millisecondsSinceEpoch.toString();
      return Future.value(sessionKey);
    } catch (e) {
      logger.e(e);
     throw AppException.failed_to_generate_session_key;
    }
  }

  @override
  Future<String> generateEncryptedMasterKey({
    required String masterKey,
    required String sessionKey,
  }) async {
    try {
      // 1. Конвертируем строки в байты
      final masterKeyBytes = utf8.encode(masterKey);
      // 2. Получаем 32-байтовый ключ для ChaCha20 из sessionKey
      // SessionKey может быть произвольной строкой, нужно привести к 32 байтам
      final sessionKeyBytes = _deriveChaCha20Key(sessionKey);

      // 3. Генерируем случайный nonce (НИКОГДА не повторяйте!)
      // Для ChaCha20-Poly1305 нужен 12-байтовый nonce (96 бит)
      final nonce = Uint8List(12);
      final random = Random.secure();
      for (var i = 0; i < nonce.length; i++) {
        nonce[i] = random.nextInt(256);
      }

      // 4. Дополнительные данные для аутентификации (не шифруются, но проверяются)
      // Добавляем метаданные для защиты от replay-атак
      final associatedData = utf8.encode(
        'master_key_encryption:${DateTime.now().toIso8601String()}',
      );

      // 6. Параметры для шифрования
      final params = AEADParameters<KeyParameter>(
        KeyParameter(sessionKeyBytes), // Сессионный ключ для шифрования
        128, // Размер тега аутентификации в битах (16 байт для Poly1305)
        nonce, // 12-байтовый nonce
        associatedData, // Дополнительные данные для аутентификации
      );

      // 7. Инициализируем для ШИФРОВАНИЯ (true)
      aeadCipher.init(true, params);

      // 8. Добавляем дополнительные данные в аутентификацию
      aeadCipher.processAADBytes(associatedData, 0, associatedData.length);

      // 9. Вычисляем размер выходного буфера
      // Для ChaCha20-Poly1305: ciphertext = plaintext, +16 байт для тега
      final outputSize = aeadCipher.getOutputSize(masterKeyBytes.length);
      final output = Uint8List(outputSize);

      // 10. Шифруем мастер-ключ
      var outOff = 0;
      outOff += aeadCipher.processBytes(
        Uint8List.fromList(masterKeyBytes),
        0,
        masterKeyBytes.length,
        output,
        outOff,
      );

      // 11. Завершаем шифрование (добавляет тег аутентификации)
      outOff += aeadCipher.doFinal(output, outOff);

      // 12. Разделяем результат: шифротекст + тег
      final ciphertextLength = outputSize - 16; // 16 байт = тег Poly1305
      final ciphertext = output.sublist(0, ciphertextLength);
      final authTag = output.sublist(ciphertextLength, outputSize);

      // 13. Создаём структуру для хранения
      final encryptedData = {
        'ciphertext': base64Encode(ciphertext),
        'authTag': base64Encode(authTag),
        'nonce': base64Encode(nonce),
        'associatedData': base64Encode(associatedData),
        'algorithm': 'ChaCha20-Poly1305',
        'timestamp': DateTime.now().toIso8601String(),
        'version': '1.0',
      };

      // 14. Конвертируем в JSON строку
      final result = jsonEncode(encryptedData);

      // 15. Очищаем чувствительные данные из памяти
      // _secureErase(masterKeyBytes);
      // _secureErase(sessionKeyBytes);
      // _secureErase(nonce);
      output.fillRange(0, output.length, 0);

      logger.i('Master key encrypted successfully with ChaCha20-Poly1305');

      return result;
    } catch (e) {
      logger.e(e);
       throw AppException.failed_to_generate_encrypted_master_key;
    }
  }

  @override
  Future<String?> decryptEncryptedMasterKey({
    required String sessionKey,
    required String encryptedMasterKey,
  }) async {
    try {
      final data = jsonDecode(encryptedMasterKey) as Map<String, dynamic>;

      // 2. Декодируем base64
      final ciphertext = base64Decode(data['ciphertext'] as String);
      final authTag = base64Decode(data['authTag'] as String);
      final nonce = base64Decode(data['nonce'] as String);
      final associatedData = base64Decode(data['associatedData'] as String);

      // 3. Получаем 32-байтовый ключ из sessionKey
      // Если sessionKey уже 32 байта - используем как есть
      // Если строка - конвертируем через SHA-256
      Uint8List keyBytes;
      if (sessionKey.length == 44 && sessionKey.endsWith('==')) {
        // Возможно это base64 32 байта
        keyBytes = base64Decode(sessionKey);
      } else {
        // Конвертируем строку в 32 байта через SHA-256
        final hash = sha256.convert(utf8.encode(sessionKey));
        keyBytes = Uint8List.fromList(hash.bytes);
      }

      // 4. Проверяем размеры
      print('''
🔧 Попытка расшифрования:
├─ ciphertext: ${ciphertext.length} байт
├─ authTag: ${authTag.length} байт
├─ nonce: ${nonce.length} байт
├─ key: ${keyBytes.length} байт
└─ associatedData: ${utf8.decode(associatedData)}
''');

      // 6. Параметры для шифрования
      final params = AEADParameters<KeyParameter>(
        KeyParameter(keyBytes), // Сессионный ключ для шифрования
        128, // Размер тега аутентификации в битах (16 байт для Poly1305)
        nonce, // 12-байтовый nonce
        associatedData, // Дополнительные данные для аутентификации
      );

      // 6. Инициализируем для РАСШИФРОВАНИЯ
      aeadCipher.init(false, params);

      // 7. Добавляем associated data
      aeadCipher.processAADBytes(associatedData, 0, associatedData.length);

      // 8. Объединяем ciphertext и authTag
      final inputWithTag = Uint8List(ciphertext.length + authTag.length)
        ..setAll(0, ciphertext)
        ..setAll(ciphertext.length, authTag);

      // 9. Расшифровываем
      final outputSize = aeadCipher.getOutputSize(inputWithTag.length);
      final output = Uint8List(outputSize);

      var outOff = aeadCipher.processBytes(
        inputWithTag,
        0,
        inputWithTag.length,
        output,
        0,
      );

      outOff += aeadCipher.doFinal(output, outOff);

      // 10. Получаем результат
      final decryptedBytes = output.sublist(0, outOff);
      final masterKey = utf8.decode(decryptedBytes);

      print('✅ Успешно расшифровано!');
      print('   Master key: "$masterKey"');
      print('   Длина: ${masterKey.length} символов');

      return masterKey;
    } catch (e) {
      logger.e(e);
     // return null;
      throw AppException.failed_to_decrypt_encrypted_master_key;
    }
  }
}

// Генерация 32-байтового ключа для ChaCha20 из произвольной строки
Uint8List _deriveChaCha20Key(String input) {
  // Вариант 1: Просто через SHA-256 (рекомендуется)
  // SHA-256 всегда даёт 32 байта
  final bytes = utf8.encode(input);
  final hash = sha256.convert(bytes);
  return Uint8List.fromList(hash.bytes);
}
