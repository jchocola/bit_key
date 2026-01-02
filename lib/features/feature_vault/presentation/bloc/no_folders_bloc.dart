// ignore_for_file: camel_case_types

import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';

///
/// EVENT
///
abstract class NoFoldersBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoFoldersBlocEvent_load extends NoFoldersBlocEvent {}

///
/// STATE
///
abstract class NoFoldersBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoFoldersBlocState_init extends NoFoldersBlocState {}

class NoFoldersBlocState_loading extends NoFoldersBlocState {}

class NoFoldersBlocState_loaded extends NoFoldersBlocState {
  final List<Login> loginsWihtoutFolder;
  final List<Card> cardsWithoutFolder;
  final List<Identity> identitiesWithoutFolder;
  final int total;

  NoFoldersBlocState_loaded({
    required this.loginsWihtoutFolder,
    required this.cardsWithoutFolder,
    required this.identitiesWithoutFolder,
    required this.total,
  });

  @override
  List<Object?> get props => [
    loginsWihtoutFolder,
    cardsWithoutFolder,
    identitiesWithoutFolder,
    total,
  ];
}

class NoFoldersBlocState_error extends NoFoldersBlocState {}

class NoFoldersBlocState_success extends NoFoldersBlocState {}

///
/// NO FOLDERS
///
class NoFoldersBloc extends Bloc<NoFoldersBlocEvent, NoFoldersBlocState> {
  final LocalDbRepository localDbRepository;

  NoFoldersBloc({required this.localDbRepository})
    : super(NoFoldersBlocState_init()) {
    ///
    /// LOAD
    ///
    on<NoFoldersBlocEvent_load>((event, emit) async {
      try {
        logger.d('No folders bloc event load:');
        final logins = await localDbRepository.getActiveLoginsWithoutFolder();
        final cards = await localDbRepository.getActiveCardsWithoutFolder();
        final identities = await localDbRepository.getActiveIdentiesWithoutFolder();



        final total = logins.length + cards.length + identities.length;
        emit(
          NoFoldersBlocState_loaded(
            loginsWihtoutFolder: logins,
            cardsWithoutFolder: cards,
            identitiesWithoutFolder: identities,
            total: total
          ),
        );
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
