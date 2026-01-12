// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';

///
/// EVENT
///
abstract class CreateIdentityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateIdentityEvent_createIdentity extends CreateIdentityEvent {
  final Identity identity;
  CreateIdentityEvent_createIdentity({required this.identity});
  @override
  List<Object?> get props => [identity];
}

///
/// STATE
///
abstract class CreateIdentityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateIdentityState_init extends CreateIdentityState {}

class CreateIdentityState_error extends CreateIdentityState {
  final Object error;
  CreateIdentityState_error({required this.error});
  @override
  List<Object?> get props => [error];
}

class CreateIdentityState_success extends CreateIdentityState {}

///
/// BLOC
///
class CreateIdentityBloc
    extends Bloc<CreateIdentityEvent, CreateIdentityState> {
  final LocalDbRepository localDbRepository;
  final AuthBloc authBloc;
  final EncryptionRepository encryptionRepository;

  CreateIdentityBloc({
    required this.localDbRepository,
    required this.authBloc,
    required this.encryptionRepository,
  }) : super(CreateIdentityState_init()) {
    ///
    /// CREATE IDENITY
    ///
    on<CreateIdentityEvent_createIdentity>((event, emit) async {
      final authBlocState = authBloc.state;

      if (authBlocState is AuthBlocAuthenticated) {
        try {
          if (event.identity.itemName.isEmpty) {
            throw AppException.empty_item_name;
          }

          final encryptedIdentity = await encryptionRepository.encryptIdentity(
            identity: event.identity,
            masterKey: authBlocState.MASTER_KEY,
          );

          logger.f(event.identity.toString());
          logger.f('encrypted identity: ${encryptedIdentity.toString()}');

          await localDbRepository.saveIdentity(identity: encryptedIdentity);

          // (analytic) track event CREATE_IDENTITY
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.CREATE_IDENTITY.name,
            ),
          );
        } catch (e) {
          logger.e(e);

          emit(CreateIdentityState_error(error: e));
          emit(CreateIdentityState_init());
        }
      }
    });
  }
}
