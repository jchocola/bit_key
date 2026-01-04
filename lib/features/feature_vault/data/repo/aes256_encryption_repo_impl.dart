import 'dart:convert';
import 'package:aes256cipher/aes256cipher.dart';
import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_vault/data/model/card_model.dart';
import 'package:bit_key/features/feature_vault/data/model/login_model.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
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

  @override
  Future<Card> decryptCard({
    required Card encryptedCard,
    required String masterKey,
  }) {
    // TODO: implement decryptCard
    throw UnimplementedError();
  }

  @override
  Future<Identity> decryptIdentity({
    required Identity encryptedIdentity,
    required String masterKey,
  }) {
    // TODO: implement decryptIdentity
    throw UnimplementedError();
  }

  @override
  Future<Login> decryptLogin({
    required Login encryptedLogin,
    required String masterKey,
  }) async {
    try {
      final model = LoginModel.fromEntity(encryptedLogin);

      // real data
      String? username = model.login;
      String? password = model.password;
      String? url = model.url;

      // decryption
      if (username != null) {
        username = await decrypt(encryptedStr: username, masterKey: masterKey);
      }
      if (password != null) {
        password = await decrypt(encryptedStr: password, masterKey: masterKey);
      }
      if (url != null) {
        url = await decrypt(encryptedStr: url, masterKey: masterKey);
      }

      final encryptedModel = model.copyWith(
        login: username,
        password: password,
        url: url,
      );

      return encryptedModel.toEntity();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<Card> encryptCard({
    required Card card,
    required String masterKey,
  }) async {
    try {
      // final CardModel model = CardModel.fromEntity(card);
      throw UnimplementedError();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<Identity> encryptIdentity({
    required Identity identity,
    required String masterKey,
  }) {
    // TODO: implement encryptIdentity
    throw UnimplementedError();
  }

  @override
  Future<Login> encryptLogin({
    required Login login,
    required String masterKey,
  }) async {
    try {
      // model
      final model = LoginModel.fromEntity(login);

      // real data
      String? username = model.login;
      String? password = model.password;
      String? url = model.url;

      // encryption
      if (username != null) {
        username = await encrypt(str: username, masterKey: masterKey);
      }
      if (password != null) {
        password = await encrypt(str: password, masterKey: masterKey);
      }
      if (url != null) {
        url = await encrypt(str: url, masterKey: masterKey);
      }

      final encryptedModel = model.copyWith(
        login: username,
        password: password,
        url: url,
      );

      return encryptedModel.toEntity();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<Login>> decryptLoginList({
    required List<Login> encryptedLogins,
    required String masterKey,
  }) async {
    try {
      List<Login> decryptedList = [];

      for (var e in encryptedLogins) {
        final decrypted = await decryptLogin(
          encryptedLogin: e,
          masterKey: masterKey,
        );
        decryptedList.add(decrypted);
      }
      return decryptedList;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
