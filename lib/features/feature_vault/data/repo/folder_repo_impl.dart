import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/main.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FolderRepoImpl implements FolderRepository {
  final SharedPreferences prefs;

  FolderRepoImpl({required this.prefs});

  // keys
  static const FOLDER_KEY = 'FOLDER_LIST';

  @override
  Future<void> createNewFolder({required String folderName}) async {
    try {
      if (folderName.isEmpty) {
        throw AppException.item_name_cannot_be_empty;
      }

      final currentList = await getAllFolder();

      if (currentList.contains(folderName)) {
        logger.e('Folder already exist!');
        throw AppException.folder_already_exist;
      } else {
        currentList.add(folderName);
        await prefs.setStringList(FOLDER_KEY, currentList);
        logger.i('Added new folder');
      }
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_create_folder;
    }
  }

  @override
  Future<void> deleteFolder({required String folderName}) async {
    try {
      final currentList = await getAllFolder();

      if (!currentList.contains(folderName)) {
        throw AppException.folder_not_exist;
      } else {
        currentList.remove(folderName);
        await prefs.setStringList(FOLDER_KEY, currentList);
      }
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_delete_folder;
    }
  }

  @override
  Future<List<String>> getAllFolder() async {
    return prefs.getStringList(FOLDER_KEY) ?? [];
  }

  @override
  Future<void> addListFolder({required List<String> folderList}) async {
    try {
      for (var folder in folderList) {
        await createNewFolder(folderName: folder);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
