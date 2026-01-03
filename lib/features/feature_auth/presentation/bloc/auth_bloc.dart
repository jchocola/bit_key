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

class AppBlocEvent_LoadSaltAndControlSum extends AuthBlocEvent {}

class AppBlocEvent_UserFirstimeRegister extends AuthBlocEvent {
  final String? USER_MASTER_PASSWORD;
  final String? CONFIRM_MASTER_PASSWORD;
  AppBlocEvent_UserFirstimeRegister({
    required this.USER_MASTER_PASSWORD,
    required this.CONFIRM_MASTER_PASSWORD,
  });
  @override
  List<Object?> get props => [USER_MASTER_PASSWORD, CONFIRM_MASTER_PASSWORD];
}

class AppBlocEvent_UserUnlockVault extends AuthBlocEvent {
  final String? USER_MASTER_PASSWORD;
  AppBlocEvent_UserUnlockVault({
    required this.USER_MASTER_PASSWORD,
  });
  @override
  List<Object?> get props => [USER_MASTER_PASSWORD];
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
  final String CONTROL_SUM_STRING;

  AuthBlocUnauthenticated({
    required this.SALT,
    required this.CONTROL_SUM_STRING,
  });
  @override
  List<Object?> get props => [SALT, CONTROL_SUM_STRING];
}

class AuthBlocFirstTimeUser extends AuthBlocState {}

class AuthBlocAuthenticated extends AuthBlocState {
  final String MASTER_KEY;
  final String SESSION_KEY;
  final String USER_MASTER_PASSWORD;

  AuthBlocAuthenticated({
    required this.MASTER_KEY,
    required this.SESSION_KEY,
    required this.USER_MASTER_PASSWORD,
  });

  @override
  List<Object?> get props => [SESSION_KEY, USER_MASTER_PASSWORD, MASTER_KEY];
}

class AuthBlocFailure extends AuthBlocState {
  final AppException? exception;
  AuthBlocFailure({this.exception});
  @override
  List<Object?> get props => [
    exception,
  ];
}

//BLOC
class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SecureStorageRepository secureStorageRepository;
  AuthBloc({required this.secureStorageRepository}) : super(AuthBlocInitial()) {
    ///
    /// LOAD SALT AND CONTROL SUM STRING
    ///
    on<AppBlocEvent_LoadSaltAndControlSum>((event, emit) async {
      try {
        final salt = await secureStorageRepository.getSalt();
        final controlSumStr = await secureStorageRepository
            .getControlSumString();

        logger.f('SALT: $salt');
        logger.f('CONTROL SUM STRING: $controlSumStr');

        if (salt == null || controlSumStr == null) {
          emit(AuthBlocFirstTimeUser());
          return;
        }
        emit(
          AuthBlocUnauthenticated(
            SALT: salt,
            CONTROL_SUM_STRING: controlSumStr,
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

        if (event.USER_MASTER_PASSWORD != event.CONFIRM_MASTER_PASSWORD) {
          throw AppException.passwords_do_not_match;
        }

        final newSalt = await secureStorageRepository.generateSalt();
        final controlSumString =
            'control_sum_${event.USER_MASTER_PASSWORD}_$newSalt';

        logger.i('Generated SALT: $newSalt');
        logger.i('Generated CONTROL SUM STRING: $controlSumString');    

        await secureStorageRepository.setSalt(newSalt);
        await secureStorageRepository.setControlSumString(controlSumString);

        logger.i('New SALT set: $newSalt');
        logger.i('New CONTROL SUM STRING set: $controlSumString');

        emit(
          AuthBlocUnauthenticated(
            SALT: newSalt,
            CONTROL_SUM_STRING: controlSumString,
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocFailure(exception: e as AppException?));
        add(AppBlocEvent_LoadSaltAndControlSum());
      }
    });


    ///
    /// USER UNLOCK VAULT
    ///  
    on<AppBlocEvent_UserUnlockVault>((event, emit) async {
      try {
        emit(AuthBlocLoading());

        final isValid = await secureStorageRepository
            .isMasterPasswordValid(event.USER_MASTER_PASSWORD!);

        if (!isValid) {
          throw AppException.invalid_master_password;
        }

        // For simplicity, using fixed strings as MASTER_KEY and SESSION_KEY.
        // In production, derive these securely from the master password.
        final masterKey = 'MASTER_KEY_DERIVED_FROM_${event.USER_MASTER_PASSWORD}';
        final sessionKey = 'SESSION_KEY_DERIVED_FROM_${event.USER_MASTER_PASSWORD}';

        emit(
          AuthBlocAuthenticated(
            MASTER_KEY: masterKey,
            SESSION_KEY: sessionKey,
            USER_MASTER_PASSWORD: event.USER_MASTER_PASSWORD!,
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocFailure(exception: e as AppException?));
        add(AppBlocEvent_LoadSaltAndControlSum());
      }
    });
  }
}
