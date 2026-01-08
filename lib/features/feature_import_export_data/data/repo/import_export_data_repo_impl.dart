// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:bit_key/features/feature_import_export_data/domain/repo/import_export_data_repository.dart';
import 'package:bit_key/features/feature_vault/data/model/card_model.dart';
import 'package:bit_key/features/feature_vault/data/model/identity_model.dart';
import 'package:bit_key/features/feature_vault/data/model/login_model.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImportExportDataRepoImpl implements ImportExportDataRepository {
  ///
  /// KEYS
  ///
  final String _master_key = 'master_key';
  final String _logins = 'logins';
  final String _cards = 'cards';
  final String _identites = 'identities';
  final String _folders = 'folders';
  final String _metadata = 'metadata';

  @override
  Future<String> convertDataToJsonString({
    required List<Login> logins,
    required List<Card> cards,
    required List<Identity> identities,
    required List<String> folders,

    required String masterKey,
  }) async {
    try {
      Map<String, dynamic> pattern = {
        _metadata: {
          'created_at': DateTime.now().toIso8601String(),
          'record_counts': {
            'logins': logins.length,
            'cards': cards.length,
            'identities': identities.length,
            'folders': folders.length,
          },
        },
        _master_key: masterKey,
        _logins: await _convertLoginsToJson(logins),
        _cards: await _convertCardsToJson(cards),
        _identites: await _convertIdentitiesToJson(identities),
        _folders: _convertFoldersToJson(folders),
      };

      // 5. Конвертируем в строку
      return jsonEncode(pattern);
    } catch (e) {
      logger.e(e);
      throw Exception();
    }
  }

  @override
  Future<void> exportJsonData({
    required String dataStr,
    required File file,
  }) async {
    try {
      // Write the file, sync operation is fine for small amounts of data
      await file.writeAsString(dataStr);
      logger.d('Data exported ${file.path}');
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<File> generateFile() async {
    try {
      final directory = await getExternalStorageDirectory();

      final downloadsDir = Directory('${directory!.path}');

      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      // This is the path to the local directory for the app.
      final path = downloadsDir.path;
      final createdAt = DateTime.now().toIso8601String();
      logger.d('Generated File :$path');
      return File('$path/bitkey_backup_$createdAt.json');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<Card>> retrieveCardsFromFile({required File file}) async {
    try {
      final extractedFile = await file.readAsString();
      logger.f(extractedFile);

      // 2. Парсим JSON
      final Map<String, dynamic> decodedFile;
      try {
        decodedFile = jsonDecode(extractedFile) as Map<String, dynamic>;
      } catch (e) {
        logger.e('Invalid JSON format: $e');
        throw FormatException('File is not valid JSON');
      }

      return [];
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<Identity>> retrieveIdentitiesFromFile({required File file}) {
    // TODO: implement retrieveIdentitiesFromFile
    throw UnimplementedError();
  }

  @override
  Future<List<Login>> retrieveLoginsFromFile({required File file}) {
    // TODO: implement retrieveLoginsFromFile
    throw UnimplementedError();
  }

  // Конвертация логинов
  Future<List<Map<String, dynamic>>> _convertLoginsToJson(
    List<Login> logins,
  ) async {
    return logins.map((login) {
      return LoginModel.fromEntity(login).toMap();
    }).toList();
  }

  // Конвертация карт
  Future<List<Map<String, dynamic>>> _convertCardsToJson(
    List<Card> cards,
  ) async {
    return cards.map((card) {
      return CardModel.fromEntity(card).toMap();
    }).toList();
  }

  // Конвертация идентичностей
  Future<List<Map<String, dynamic>>> _convertIdentitiesToJson(
    List<Identity> identities,
  ) async {
    return identities.map((identity) {
      return IdentityModel.fromEntity(identity).toMap();
    }).toList();
  }

  // Конвертация папок
  List<Map<String, dynamic>> _convertFoldersToJson(List<String> folders) {
    return folders.asMap().entries.map((entry) {
      return {'name': entry.value};
    }).toList();
  }

  @override
  Future<File?> pickeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['json'],
      type: FileType.custom
    );
    try {
      if (result != null) {
        File file = File(result.files.first.path!);
        return file;
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
