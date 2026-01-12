// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';

///
/// EVENT
///
abstract class CreateLoginBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateLoginBlocEvent_createLogin extends CreateLoginBlocEvent {
  final Login login;
  CreateLoginBlocEvent_createLogin({required this.login});
}

///
/// STATE
///
abstract class CreateLoginBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateLoginBlocState_init extends CreateLoginBlocState {}

class CreateLoginBlocState_error extends CreateLoginBlocState {
  final Object error;
  CreateLoginBlocState_error({required this.error});
  @override
  List<Object?> get props => [error];
}

class CreateLoginBlocState_success extends CreateLoginBlocState {}

///
/// BLOC
///
class CreateLoginBloc extends Bloc<CreateLoginBlocEvent, CreateLoginBlocState> {
  final LocalDbRepository localDbRepository;
  final EncryptionRepository encryptionRepository;
  final AuthBloc authBloc;
  CreateLoginBloc({
    required this.localDbRepository,
    required this.encryptionRepository,
    required this.authBloc,
  }) : super(CreateLoginBlocState_init()) {
    ///
    /// CREATE LOGIN
    ///
    on<CreateLoginBlocEvent_createLogin>((event, emit) async {
      try {
        if (event.login.itemName.isEmpty) {
          throw AppException.empty_item_name;
        }

        final authBlocState = authBloc.state;
        if (authBlocState is AuthBlocAuthenticated) {
          final encryptedLogin = await encryptionRepository.encryptLogin(
            login: event.login,
            masterKey: authBlocState.MASTER_KEY,
          );

          logger.f('Login : ${event.login.toString()}');
          logger.f('Encrypted Login : ${encryptedLogin.toString()}');

          await localDbRepository.saveLogin(login: encryptedLogin);

          //(analytic) track event CREATE_LOGIN
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.CREATE_LOGIN.name,
            ),
          );
        }
      } catch (e) {
        logger.e(e);
        //rethrow;
        emit(CreateLoginBlocState_error(error: e));
        emit(CreateLoginBlocState_init());
      }
    });
  }
}
