// ignore_for_file: camel_case_types

import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';

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

class CreateIdentityState_error extends CreateIdentityState {}

class CreateIdentityState_success extends CreateIdentityState {}

///
/// BLOC
///
class CreateIdentityBloc
    extends Bloc<CreateIdentityEvent, CreateIdentityState> {
  final LocalDbRepository localDbRepository;
  CreateIdentityBloc({required this.localDbRepository})
    : super(CreateIdentityState_init()) {
    ///
    /// CREATE IDENITY
    ///
    on<CreateIdentityEvent_createIdentity>((event, emit) async {
      try {
        await localDbRepository.saveIdentity(identity: event.identity);
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
