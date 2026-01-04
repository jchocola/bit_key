// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  AuthBloc({required this.secureStorageRepository}) : super(AuthBlocInitial()) {
    ///
    /// LOAD SALT AND CONTROL SUM STRING
    ///
    on<AppBlocEvent_LoadSaltAndHashedMasterKey>((event, emit) async {
      try {
        final salt = await secureStorageRepository.getSalt();
        final controlSumStr = await secureStorageRepository
            .getHashedMasterKey();
        final sessionKey = await secureStorageRepository.generateSessionKey();

        logger.f('SALT: $salt');
        logger.f('CONTROL SUM STRING: $controlSumStr');
        logger.f('SESSION KEY : $sessionKey');

        if (salt == null || controlSumStr == null) {
          emit(AuthBlocFirstTimeUser());
          return;
        }
        emit(
          AuthBlocUnauthenticated(
            SALT: salt,
            HASHED_MASTER_KEY: controlSumStr,
            SESSION_KEY: sessionKey,
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
            SESSION_KEY: newSessionKey
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
      } catch (e) {
        logger.e(e);
        emit(AuthBlocFailure(exception: e as AppException?));
        add(AppBlocEvent_LoadSaltAndHashedMasterKey());
      }
    });
  }
}
