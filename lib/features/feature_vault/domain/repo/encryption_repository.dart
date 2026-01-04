import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';

abstract class EncryptionRepository {
  ///
  /// main logic
  ///
  Future<String> encrypt({required String str, required String masterKey});

  Future<String> decrypt({
    required String encryptedStr,
    required String masterKey,
  });

  Future<String> convertKeyToValidForUse({required String masterKey});

  ///
  /// login
  ///
  Future<Login> encryptLogin({required Login login, required String masterKey});
  Future<Login> decryptLogin({
    required Login encryptedLogin,
    required String masterKey,
  });
  Future<List<Login>> decryptLoginList({
    required List<Login> encryptedLogins,
    required String masterKey,
  });

  ///
  /// card
  ///
  Future<Card> encryptCard({required Card card, required String masterKey});
  Future<Card> decryptCard({
    required Card encryptedCard,
    required String masterKey,
  });

  ///
  /// identity
  ///
  Future<Identity> encryptIdentity({
    required Identity identity,
    required String masterKey,
  });
  Future<Identity> decryptIdentity({
    required Identity encryptedIdentity,
    required String masterKey,
  });
}
