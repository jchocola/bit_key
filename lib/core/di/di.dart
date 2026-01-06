// ignore_for_file: non_constant_identifier_names

import 'package:bit_key/features/feature_auth/data/repo/local_auth_repo_impl.dart';
import 'package:bit_key/features/feature_auth/data/repo/secure_storage_repo_impl.dart';
import 'package:bit_key/features/feature_auth/domain/repo/local_auth_repository.dart';
import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/features/feature_generate_pass/data/repositories/generator_repo_impl.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/generator_repo.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/data/repo/app_security_repo_impl.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/data/repo/jailbreak_root_detection_impl.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/domain/repo/app_security_repository.dart';
import 'package:bit_key/features/feature_vault/data/repo/aes256_encryption_repo_impl.dart';
import 'package:bit_key/features/feature_vault/data/repo/folder_repo_impl.dart';
import 'package:bit_key/features/feature_vault/data/repo/hive_db_repo_impl.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<GeneratorRepo>(GeneratorRepoImpl());

  final shared_prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<FolderRepository>(
    FolderRepoImpl(prefs: shared_prefs),
  );

  getIt.registerSingleton<AppSecurityRepository>(
    AppSecurityRepoImpl(sharedPreferences: shared_prefs),
  );

  final dir = await getApplicationDocumentsDirectory();
  getIt.registerSingleton<LocalDbRepository>(HiveDbRepoImpl(pathDir: dir.path));

  final secureStorage = FlutterSecureStorage(
    // aOptions: AndroidOptions(
    //   keyCipherAlgorithm: KeyCipherAlgorithm.AES_GCM_NoPadding,
    // ),
  );

  final keyDerivator = KeyDerivator('argon2');
  final AEADCipher paddedBlockCipher = AEADCipher('ChaCha20-Poly1305');

  getIt.registerSingleton<SecureStorageRepository>(
    SecureStorageRepoImpl(
      secureStorage: secureStorage,
      keyDerivator: keyDerivator,
      aeadCipher: paddedBlockCipher,
    ),
  );

  getIt.registerSingleton<EncryptionRepository>(Aes256EncryptionRepoImpl());

  getIt.registerSingleton<LocalAuthRepository>(LocalAuthRepoImpl());

  getIt.registerSingleton<JailbreakRootDetectionImpl>(
    JailbreakRootDetectionImpl(),
  );

  logger.i('DI initialized');
}
