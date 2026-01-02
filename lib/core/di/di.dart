// ignore_for_file: non_constant_identifier_names

import 'package:bit_key/features/feature_auth/data/repo/secure_storage_repo_impl.dart';
import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/features/feature_generate_pass/data/repositories/generator_repo_impl.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/generator_repo.dart';
import 'package:bit_key/features/feature_vault/data/repo/folder_repo_impl.dart';
import 'package:bit_key/features/feature_vault/data/repo/hive_db_repo_impl.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<GeneratorRepo>(GeneratorRepoImpl());

  final shared_prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<FolderRepository>(
    FolderRepoImpl(prefs: shared_prefs),
  );

  final dir = await getApplicationDocumentsDirectory();
  getIt.registerSingleton<LocalDbRepository>(HiveDbRepoImpl(pathDir: dir.path));

  final secureStorage = FlutterSecureStorage(
     aOptions: AndroidOptions(encryptedSharedPreferences:  true, keyCipherAlgorithm: KeyCipherAlgorithm.AES_GCM_NoPadding),
  );
  getIt.registerSingleton<SecureStorageRepository>(SecureStorageRepoImpl(secureStorage: secureStorage));

  logger.i('DI initialized');
}
