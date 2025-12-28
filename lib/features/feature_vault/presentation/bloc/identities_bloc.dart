// ignore_for_file: camel_case_types

import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
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
  IdentitiesBloc({required this.localDbRepository})
    : super(IdentitiesBlocState_init()) {
    ///
    /// LOAD IDENTITIES
    ///
    on<IdentitiesBlocEvent_loadIdentities>((event, emit) async {
      try {
        logger.i('Load identites');
        final list = await localDbRepository.getAllIdentity();
        logger.i('Loaded identites : ${list.length}');
        emit(IdentitiesBlocState_loaded(identities: list));
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
