// ignore_for_file: camel_case_types

import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class CreateLoginBlocState_error extends CreateLoginBlocState {}

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
        final authBlocState = authBloc.state;
        if (authBlocState is AuthBlocAuthenticated) {

          final encryptedLogin = await encryptionRepository.encryptLogin(
            login: event.login,
            masterKey: authBlocState.MASTER_KEY,
          );

          logger.f('Login : ${event.login.toString()}');
          logger.f('Encrypted Login : ${encryptedLogin.toString()}');

          await localDbRepository.saveLogin(login: encryptedLogin);
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
