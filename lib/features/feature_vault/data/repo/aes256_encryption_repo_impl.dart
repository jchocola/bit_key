import 'dart:convert';
import 'package:aes256cipher/aes256cipher.dart';
import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_vault/data/model/card_model.dart';
import 'package:bit_key/features/feature_vault/data/model/identity_model.dart';
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
  }) async {
    try {
      final model = CardModel.fromEntity(encryptedCard);

      // encrypted data
      String? cardHolderName = model.cardHolderName;
      String? number = model.number;

      // dectypted data
      if (cardHolderName != null) {
        cardHolderName = await decrypt(
          encryptedStr: cardHolderName,
          masterKey: masterKey,
        );
      }

      if (number != null) {
        number = await decrypt(encryptedStr: number, masterKey: masterKey);
      }

      final decrypted = model.copyWith(
        cardHolderName: cardHolderName,
        number: number,
      );
      return decrypted.toEntity();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<Identity> decryptIdentity({
    required Identity encryptedIdentity,
    required String masterKey,
  }) async {
    try {
      final model = IdentityModel.fromEntity(encryptedIdentity);

      // encrypted data
      String? username = model.userName;
      String? company = model.company;
      String? nationalInsuranceNumber = model.nationalInsuranceNumber;
      String? passportName = model.passportName;
      String? licenseNumber = model.licenseNumber;
      String? email = model.email;
      String? phone = model.phone;
      String? address1 = model.address1;
      String? address2 = model.address2;
      String? address3 = model.address3;

      // decryption
      if (username != null) {
        username = await decrypt(encryptedStr: username, masterKey: masterKey);
      }

      if (company != null) {
        company = await decrypt(encryptedStr: company, masterKey: masterKey);
      }

      if (nationalInsuranceNumber != null) {
        nationalInsuranceNumber = await decrypt(
          encryptedStr: nationalInsuranceNumber,
          masterKey: masterKey,
        );
      }

      if (passportName != null) {
        passportName = await decrypt(
          encryptedStr: passportName,
          masterKey: masterKey,
        );
      }

      if (licenseNumber != null) {
        licenseNumber = await decrypt(
          encryptedStr: licenseNumber,
          masterKey: masterKey,
        );
      }
      if (email != null) {
        email = await decrypt(encryptedStr: email, masterKey: masterKey);
      }
      if (phone != null) {
        phone = await decrypt(encryptedStr: phone, masterKey: masterKey);
      }

      if (address1 != null) {
        address1 = await decrypt(encryptedStr: address1, masterKey: masterKey);
      }

      if (address2 != null) {
        address2 = await decrypt(encryptedStr: address2, masterKey: masterKey);
      }
      if (address3 != null) {
        address3 = await decrypt(encryptedStr: address3, masterKey: masterKey);
      }

      // decrypted model
      final decryptedModel = model.copyWith(
        userName: username,
        company: company,
        nationalInsuranceNumber: nationalInsuranceNumber,
        passportName: passportName,
        licenseNumber: licenseNumber,
        email: email,
        phone: phone,
        address1: address1,
        address2: address2,
        address3: address3,
      );

      return decryptedModel.toEntity();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<Login> decryptLogin({
    required Login encryptedLogin,
    required String masterKey,
  }) async {
    try {
      final model = LoginModel.fromEntity(encryptedLogin);

      // encrypted data
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

      final decryptedModel = model.copyWith(
        login: username,
        password: password,
        url: url,
      );

      return decryptedModel.toEntity();
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
      final model = CardModel.fromEntity(card);

      // real data
      String? cardHolder = model.cardHolderName;
      String? cardNumber = model.number;
      // TODO
      // ENCRYPT SEC NUMBER

      if (cardHolder != null) {
        cardHolder = await encrypt(str: cardHolder, masterKey: masterKey);
      }

      if (cardNumber != null) {
        cardNumber = await encrypt(str: cardNumber, masterKey: masterKey);
      }

      final encryptedModel = model.copyWith(
        cardHolderName: cardHolder,
        number: cardNumber,
      );

      return encryptedModel.toEntity();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<Identity> encryptIdentity({
    required Identity identity,
    required String masterKey,
  }) async {
    try {
      final model = IdentityModel.fromEntity(identity);

      // real data
      String? username = model.userName;
      String? company = model.company;
      String? nationalInsuranceNumber = model.nationalInsuranceNumber;
      String? passportName = model.passportName;
      String? licenseNumber = model.licenseNumber;
      String? email = model.email;
      String? phone = model.phone;
      String? address1 = model.address1;
      String? address2 = model.address2;
      String? address3 = model.address3;

      // encryption
      if (username != null) {
        username = await encrypt(str: username, masterKey: masterKey);
      }

      if (company != null) {
        company = await encrypt(str: company, masterKey: masterKey);
      }

      if (nationalInsuranceNumber != null) {
        nationalInsuranceNumber = await encrypt(
          str: nationalInsuranceNumber,
          masterKey: masterKey,
        );
      }

      if (passportName != null) {
        passportName = await encrypt(str: passportName, masterKey: masterKey);
      }

      if (licenseNumber != null) {
        licenseNumber = await encrypt(str: licenseNumber, masterKey: masterKey);
      }
      if (email != null) {
        email = await encrypt(str: email, masterKey: masterKey);
      }
      if (phone != null) {
        phone = await encrypt(str: phone, masterKey: masterKey);
      }

      if (address1 != null) {
        address1 = await encrypt(str: address1, masterKey: masterKey);
      }

      if (address2 != null) {
        address2 = await encrypt(str: address2, masterKey: masterKey);
      }
      if (address3 != null) {
        address3 = await encrypt(str: address3, masterKey: masterKey);
      }

      // encrypted model
      final encryptedModel = model.copyWith(
        userName: username,
        company: company,
        nationalInsuranceNumber: nationalInsuranceNumber,
        passportName: passportName,
        licenseNumber: licenseNumber,
        email: email,
        phone: phone,
        address1: address1,
        address2: address2,
        address3: address3,
      );

      return encryptedModel.toEntity();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
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

  @override
  Future<List<Card>> decryptCardList({
    required List<Card> encryptedCards,
    required String masterKey,
  }) async {
    try {
      List<Card> decryptedList = [];

      for (var e in encryptedCards) {
        final decrypted = await decryptCard(
          encryptedCard: e,
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

  @override
  Future<List<Identity>> decryptIdentityList({
    required List<Identity> encryptedIdentities,
    required String masterKey,
  }) async {
    try {
       List<Identity> decryptedList = [];

      for (var e in encryptedIdentities) {
        final decrypted = await decryptIdentity(
          encryptedIdentity: e,
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
