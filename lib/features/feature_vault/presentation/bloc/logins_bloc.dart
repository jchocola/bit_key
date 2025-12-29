import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
// ignore_for_file: camel_case_types

abstract class LoginsBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginsBlocEvent_loadLogins extends LoginsBlocEvent {}

///
/// STATE
///
abstract class LoginsBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginsBlocState_init extends LoginsBlocState {}

class LoginsBlocState_loaded extends LoginsBlocState {
  final List<Login> logins;

  LoginsBlocState_loaded({required this.logins});

  @override
  List<Object?> get props => [logins];
}

class LoginsBlocState_error extends LoginsBlocState {}

class LoginsBlocState_success extends LoginsBlocState {}

///
/// BLOC
///
class LoginsBloc extends Bloc<LoginsBlocEvent, LoginsBlocState> {
  final LocalDbRepository localDbRepository;
  LoginsBloc({required this.localDbRepository})
    : super(LoginsBlocState_init()) {
    ///
    /// LOAD LOGINS
    ///
    on<LoginsBlocEvent_loadLogins>((event, emit) async {
      try {
        logger.d('Load Active login list');

        final loginList = await localDbRepository.getActiveLogin();
        logger.d('loaded login list : ${loginList.length}');

        emit(LoginsBlocState_loaded(logins: loginList));
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
