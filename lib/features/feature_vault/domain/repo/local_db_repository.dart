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
  Future<List<Card>> getActiveCard();
  Future<List<Card>> getCardsWithoutFolder();
  Future<List<Card>> getActiveCardsWithoutFolder();
  Future<List<Card>> getCardsWithFolderName({required String folderName});
  Future<void> moveCardToBin({required Card card});
  Future<void> restoreCardFromBin({required Card card});
  Future<List<Card>> getCardsInBin();
  Future<int> getCardIndexInBox({required Card card});
  Future<void> deleteAllCardsFromBin();
  Future<List<Card>> searchCards(String query);
  Future<void> deleteAllCards();

  ///
  /// LOGIN
  ///
  Future<void> saveLogin({required Login login});
  Future<void> deleteLogin({required Login login});
  Future<void> updateLogin({required Login login});
  Future<List<Login>> getAllLogin();
  Future<List<Login>> getActiveLogin();
  Future<List<Login>> getLoginsWithoutFolder();
  Future<List<Login>> getActiveLoginsWithoutFolder();
  Future<List<Login>> getLoginsWithFolderName({required String folderName});
  Future<void> moveLoginToBin({required Login login});
  Future<void> restoreLoginFromBin({required Login login});
  Future<List<Login>> getLoginsInBin();
  Future<int> getLoginIndexInBox({required Login login});
  Future<void> deleteAllLoginsFromBin();
  Future<List<Login>> searchLogins(String query);
  Future<void> deleteAllLogins();

  ///
  /// IDENTITY
  ///
  Future<void> saveIdentity({required Identity identity});
  Future<void> deleteIdentity({required Identity identtity});
  Future<void> updateIdentity({required Identity identity});
  Future<List<Identity>> getAllIdentity();
  Future<List<Identity>> getActiveIdentity();
  Future<List<Identity>> getIdentiesWithoutFolder();
  Future<List<Identity>> getActiveIdentiesWithoutFolder();
  Future<List<Identity>> getIdentitiesWithFolderName({
    required String folderName,
  });
  Future<void> moveIdentityToBin({required Identity identity});
  Future<void> restoreIdentityFromBin({required Identity identity});
  Future<List<Identity>> getIdentitiesInBin();
  Future<int> getIdentityIndexInBox({required Identity identity});
  Future<void> deleteAllIdentitiesFromBin();
  Future<List<Identity>> searchIdentities(String query);
  Future<void> deleteAllIdentities();
}
