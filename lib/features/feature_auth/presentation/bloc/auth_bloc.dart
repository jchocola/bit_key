// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_auth/domain/repo/local_auth_repository.dart';
import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';

// EVENT
abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppBlocEvent_LoadSaltAndHashedMasterKey extends AuthBlocEvent {}

class AppBlocEvent_UserFirstimeRegister extends AuthBlocEvent {
  final String? MASTER_KEY;
  final String? CONFIRM_MASTER_KEY;
  AppBlocEvent_UserFirstimeRegister({
    required this.MASTER_KEY,
    required this.CONFIRM_MASTER_KEY,
  });
  @override
  List<Object?> get props => [MASTER_KEY, CONFIRM_MASTER_KEY];
}

class AppBlocEvent_UserUnlockVaultViaMasterKey extends AuthBlocEvent {
  final String? MASTER_KEY;
  AppBlocEvent_UserUnlockVaultViaMasterKey({required this.MASTER_KEY});
  @override
  List<Object?> get props => [MASTER_KEY];
}

class AuthBlocEvent_UserUnblockVaultViaLocalAuth extends AuthBlocEvent {}

class AuthBlocEvent_lockApp extends AuthBlocEvent {}

class AuthBlocEvent_DELETE_ALL_DATA extends AuthBlocEvent {
  final String masterKey;
  AuthBlocEvent_DELETE_ALL_DATA({required this.masterKey});
  @override
  List<Object?> get props => [masterKey];
}

// STATE
abstract class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocInitial extends AuthBlocState {}

class AuthBlocLoading extends AuthBlocState {}

class AuthBlocUnauthenticated extends AuthBlocState {
  final String SALT;
  final String HASHED_MASTER_KEY;
  final String SESSION_KEY;

  AuthBlocUnauthenticated({
    required this.SALT,
    required this.HASHED_MASTER_KEY,
    required this.SESSION_KEY,
  });
  @override
  List<Object?> get props => [SALT, HASHED_MASTER_KEY, SESSION_KEY];
}

class AuthBlocFirstTimeUser extends AuthBlocState {}

class AuthBlocAuthenticated extends AuthBlocState {
  final String MASTER_KEY;
  final String SESSION_KEY;
  final String ENCRYPTED_MASTER_KEY;

  AuthBlocAuthenticated({
    required this.MASTER_KEY,
    required this.SESSION_KEY,
    required this.ENCRYPTED_MASTER_KEY,
  });

  @override
  List<Object?> get props => [SESSION_KEY, ENCRYPTED_MASTER_KEY, MASTER_KEY];
}

class AuthBlocFailure extends AuthBlocState {
  final AppException? exception;
  AuthBlocFailure({this.exception});
  @override
  List<Object?> get props => [exception];
}

//BLOC
class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SecureStorageRepository secureStorageRepository;
  final LocalAuthRepository localAuthRepository;
  final FolderRepository folderRepository;
  final LocalDbRepository localDbRepository;
  AuthBloc({
    required this.secureStorageRepository,
    required this.localAuthRepository,
    required this.folderRepository,
    required this.localDbRepository,
    re,
  }) : super(AuthBlocInitial()) {
    ///
    /// LOAD SALT AND CONTROL SUM STRING
    ///
    on<AppBlocEvent_LoadSaltAndHashedMasterKey>((event, emit) async {
      try {
        final salt = await secureStorageRepository.getSalt();
        final hashedMasterKey = await secureStorageRepository
            .getHashedMasterKey();
        final sessionKey = await secureStorageRepository.getSessionKey();

        logger.f('SALT: $salt');
        logger.f('Hashed master key: $hashedMasterKey');
        logger.f('SESSION KEY : $sessionKey');

        if (salt == null || hashedMasterKey == null) {
          emit(AuthBlocFirstTimeUser());
          return;
        }
        emit(
          AuthBlocUnauthenticated(
            SALT: salt,
            HASHED_MASTER_KEY: hashedMasterKey,
            SESSION_KEY: sessionKey ?? '',
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocFailure());
      }
    });

    ///
    /// USER FIRST TIME REGISTER
    ///
    on<AppBlocEvent_UserFirstimeRegister>((event, emit) async {
      try {
        emit(AuthBlocLoading());

        if (event.MASTER_KEY != event.CONFIRM_MASTER_KEY) {
          throw AppException.passwords_do_not_match;
        }

        final newSalt = await secureStorageRepository.generateSalt();
        final newHashedMasterKey = await secureStorageRepository
            .generateHashedMasterKey(
              masterKey: event.MASTER_KEY!,
              salt: newSalt,
            );
        final newSessionKey = await secureStorageRepository
            .generateSessionKey();

        logger.i('Generated SALT: $newSalt');
        logger.i('Generated HASHED MASTER KEY: $newHashedMasterKey');
        logger.i('Generated SessionKey $newSessionKey');

        await secureStorageRepository.setSalt(newSalt);
        await secureStorageRepository.setHashedMasterKey(newHashedMasterKey);
        await secureStorageRepository.setSessionKey(newSessionKey);

        logger.i('New SALT set: $newSalt');
        logger.i('New HASHED MASTER KEY: $newHashedMasterKey');

        emit(
          AuthBlocUnauthenticated(
            SALT: newSalt,
            HASHED_MASTER_KEY: newHashedMasterKey,
            SESSION_KEY: newSessionKey,
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocFailure(exception: e as AppException?));
        add(AppBlocEvent_LoadSaltAndHashedMasterKey());
      }
    });

    ///
    /// USER UNLOCK VAULT
    ///
    on<AppBlocEvent_UserUnlockVaultViaMasterKey>((event, emit) async {
      try {
        emit(AuthBlocLoading());

        final isValid = await secureStorageRepository.isMasterKeyValid(
          event.MASTER_KEY!,
        );

        if (!isValid) {
          throw AppException.invalid_master_password;
        }

        // For simplicity, using fixed strings as MASTER_KEY and SESSION_KEY.
        // In production, derive these securely from the master password.
        final masterKey = event.MASTER_KEY!;
        final sessionKey = await secureStorageRepository.generateSessionKey();
        final encryptedMasterKey = await secureStorageRepository
            .generateEncryptedMasterKey(
              masterKey: masterKey,
              sessionKey: sessionKey,
            );

        logger.f('MASTER KEY: $masterKey');
        logger.f('SESSION KEY: $sessionKey');
        logger.f('ENCRYPTED MASTER KEY: $encryptedMasterKey');

        emit(
          AuthBlocAuthenticated(
            MASTER_KEY: masterKey,
            SESSION_KEY: sessionKey,
            ENCRYPTED_MASTER_KEY: encryptedMasterKey,
          ),
        );

        // update session/ encrypted key
        await secureStorageRepository.setEncryptedMasterKey(encryptedMasterKey);
        await secureStorageRepository.setSessionKey(sessionKey);
      } catch (e) {
        logger.e(e);
        emit(AuthBlocFailure(exception: e as AppException?));
        add(AppBlocEvent_LoadSaltAndHashedMasterKey());
      }
    });

    ///
    /// UNLOCK VAULT VIA LOCAL AUTH
    ///
    on<AuthBlocEvent_UserUnblockVaultViaLocalAuth>((event, emit) async {
      try {
        final canAuth = await localAuthRepository.canAuthenticate();

        if (canAuth) {
          final result = await localAuthRepository.authenticate(
            reason: 'opEN',
            biometricOnly: false,
          );
          if (result) {
            logger.f('Logged successfull');

            final currentState = state;
            if (currentState is AuthBlocUnauthenticated) {
              final encryptedMasterKey = await secureStorageRepository
                  .getEncryptedMasterKey();

              logger.d('Encrypted key : $encryptedMasterKey');
              if (encryptedMasterKey != null) {
                final decryptedMasterKey = await secureStorageRepository
                    .decryptEncryptedMasterKey(
                      sessionKey: currentState.SESSION_KEY,
                      encryptedMasterKey: encryptedMasterKey,
                    );

                logger.d('Decrypted master key : ${decryptedMasterKey}');

                if (decryptedMasterKey != null) {
                  logger.d('User authenticated');

                  emit(
                    AuthBlocAuthenticated(
                      MASTER_KEY: decryptedMasterKey,
                      SESSION_KEY: currentState.SESSION_KEY,
                      ENCRYPTED_MASTER_KEY: currentState.HASHED_MASTER_KEY,
                    ),
                  );
                }
              }
            }
          }
        } else {
          logger.e('Cant auth');
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// lock app
    ///
    on<AuthBlocEvent_lockApp>((event, emit) {
      add(AppBlocEvent_LoadSaltAndHashedMasterKey());
    });

    ///
    /// DELETE ALL DATA
    ///
    on<AuthBlocEvent_DELETE_ALL_DATA>((event, emit) async {
      final currentState = state;
      if (currentState is AuthBlocAuthenticated) {
        try {
          // check master key
          if (event.masterKey != currentState.MASTER_KEY) {
            logger.e('Invalid master key');
            return;
          }

          logger.d('START DELETE ALL DATA');

          await localDbRepository.deleteAllCards();
          await localDbRepository.deleteAllLogins();
          await localDbRepository.deleteAllIdentities();

          await secureStorageRepository.deleteEncryptedMasterKey();
          await secureStorageRepository.deleteSessionKey();
          await secureStorageRepository.deleteControlSumString();
          await secureStorageRepository.deleteSalt();

          logger.d(
            'DELETED ALL DATA , KEYS, SESSION KEY , CONTROLL SUM , SALT',
          );

          add(AppBlocEvent_LoadSaltAndHashedMasterKey());
        } catch (e) {
          logger.e(e);
        }
      }
    });
  }
}
