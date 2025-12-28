import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';

abstract class LocalDbRepository {
  Future<void> init();

  ///
  /// CARD
  ///
  Future<void> saveCard({required Card card});
  Future<void> deleteCard({required Card card});
  Future<void> updateCard({required Card card});
  Future<List<Card>> getAllCard();
  Future<List<Card>> getCardsWithoutFolder();

  ///
  /// LOGIN
  ///
  Future<void> saveLogin({required Login login});
  Future<void> deleteLogin({required Login login});
  Future<void> updateLogin({required Login login});
  Future<List<Login>> getAllLogin();
  Future<List<Login>> getLoginsWithoutFolder();

  ///
  /// IDENTITY
  ///
  Future<void> saveIdentity({required Identity identity});
  Future<void> deleteIdentity({required Identity identtity});
  Future<void> updateIdentity({required Identity identity});
  Future<List<Identity>> getAllIdentity();
  Future<List<Identity>> getIdentiesWithoutFolder();
}
