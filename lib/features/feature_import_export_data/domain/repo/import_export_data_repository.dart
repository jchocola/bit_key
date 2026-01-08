import 'dart:io';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';

abstract class ImportExportDataRepository {
  Future<String> convertDataToJsonString({
    required List<Login> logins,
    required List<Card> cards,
    required List<Identity> identities,
    required String masterKey,
    required List<String> folders,
  });

  Future<List<Login>> retrieveLoginsFromFile({required File file});
  Future<List<Card>> retrieveCardsFromFile({required File file});
  Future<List<Identity>> retrieveIdentitiesFromFile({required File file});
  Future<List<String>> retrieveFoldersFromFile({required File file});

  Future<File> generateFile();

  Future<void> exportJsonData({required String dataStr, required File file});

  Future<File?> pickeFile();
}
