// ignore_for_file: camel_case_types

import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
abstract class IdentitiesBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdentitiesBlocEvent_loadIdentities extends IdentitiesBlocEvent {}

///
/// STATE
///
abstract class IdentitiesBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdentitiesBlocState_init extends IdentitiesBlocState {}

class IdentitiesBlocState_loading extends IdentitiesBlocState {}

class IdentitiesBlocState_loaded extends IdentitiesBlocState {
  final List<Identity> identities;
  IdentitiesBlocState_loaded({required this.identities});

  @override
  List<Object?> get props => [identities];
}

class IdentitiesBlocState_error extends IdentitiesBlocState {}

class IdentitiesBlocState_success extends IdentitiesBlocState {}

///
/// BLOC
///
class IdentitiesBloc extends Bloc<IdentitiesBlocEvent, IdentitiesBlocState> {
  final LocalDbRepository localDbRepository;
  final EncryptionRepository encryptionRepository;
  final AuthBloc authBloc;
  IdentitiesBloc({
    required this.localDbRepository,
    required this.authBloc,
    required this.encryptionRepository,
  }) : super(IdentitiesBlocState_init()) {
    ///
    /// LOAD IDENTITIES
    ///
    on<IdentitiesBlocEvent_loadIdentities>((event, emit) async {
      final authBlocState = authBloc.state;

      if (authBlocState is AuthBlocAuthenticated) {
        try {
          logger.i('Load active identites');
          final list = await localDbRepository.getActiveIdentity();
          logger.i('Loaded identites : ${list.length}');

          final decryptedList = await encryptionRepository.decryptIdentityList(
            encryptedIdentities: list,
            masterKey: authBlocState.MASTER_KEY
          );

          emit(IdentitiesBlocState_loaded(identities: decryptedList));
        } catch (e) {
          logger.e(e);
        }
      }
    });
  }
}
