import 'dart:convert';
import 'package:aes256cipher/aes256cipher.dart';
import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/main.dart';
import 'package:crypto/crypto.dart';

class Aes256EncryptionRepoImpl implements EncryptionRepository {
  @override
  Future<String> decrypt({
    required String encryptedStr,
    required String masterKey,
  }) async {
    try {
      final validKey = await convertKeyToValidForUse(masterKey: masterKey);
      logger.d('Valid Key  $validKey');
      final AES256Cipher aes256cipher = AES256Cipher(key: validKey);

      final decryptResult = await aes256cipher.decrypt(encryptedStr);
      logger.d('Decrypted Str :  $decryptResult');

      return decryptResult;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String> encrypt({
    required String str,
    required String masterKey,
  }) async {
    try {
      final validKey = await convertKeyToValidForUse(masterKey: masterKey);
      logger.d('Valid Key  $validKey');
      // ex.
      final AES256Cipher aes256cipher = AES256Cipher(key: validKey);

      final encryptedStr = await aes256cipher.encrypt(str);
      logger.d('EncryptedStr : $encryptedStr');

      return encryptedStr;
    } catch (e) {
      logger.e(e);
      throw AppException.failed_encrypt_str;
    }
  }

  @override
  Future<String> convertKeyToValidForUse({required String masterKey}) async {
    try {
      // 1. Получаем 32 байта через SHA-256
      final bytes = utf8.encode(masterKey);
      final hash = sha256.convert(bytes);

      // 2. Конвертируем в hex строку (64 символа)
      final hexString = hash.bytes
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join();

      // 3. Берем первые 32 символа (или все 64, если нужно)
      return hexString.substring(0, 32); // 32 шестнадцатеричных символа
    } catch (e) {
      logger.e(e);
      throw AppException.failedConvertKeyToValidForUse;
    }
  }
}
