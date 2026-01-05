// ignore_for_file: camel_case_types

import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';

///
/// EVENT
///
abstract class FolderDetailBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FolderDetailBlocEvent_load extends FolderDetailBlocEvent {
  final String folderName;
  FolderDetailBlocEvent_load({required this.folderName});
  @override
  List<Object?> get props => [folderName];
}

///
/// STATE
///
abstract class FolderDetailBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FolderDetailBlocState_init extends FolderDetailBlocState {}

class FolderDetailBlocState_loading extends FolderDetailBlocState {}

class FolderDetailBlocState_loaded extends FolderDetailBlocState {
  final List<Login> logins;
  final List<Card> cards;
  final List<Identity> identities;
  FolderDetailBlocState_loaded({
    required this.logins,
    required this.cards,
    required this.identities,
  });

  @override
  List<Object?> get props => [logins, cards, identities];
}

class FolderDetailBlocState_error extends FolderDetailBlocState {}

class FolderDetailBlocState_success extends FolderDetailBlocState {}

///
/// BLOC
///
class FolderDetailBloc
    extends Bloc<FolderDetailBlocEvent, FolderDetailBlocState> {
  final LocalDbRepository localDbRepository;
  final EncryptionRepository encryptionRepository;
  final AuthBloc authBloc;
  FolderDetailBloc({
    required this.localDbRepository,
    required this.authBloc,
    required this.encryptionRepository,
  }) : super(FolderDetailBlocState_init()) {
    ///
    /// LOAD
    ///
    on<FolderDetailBlocEvent_load>((event, emit) async {
      try {
        logger.i('Folder detail load');

        // get encrypted data
        final logins = await localDbRepository.getLoginsWithFolderName(
          folderName: event.folderName,
        );
        final cards = await localDbRepository.getCardsWithFolderName(
          folderName: event.folderName,
        );
        final identities = await localDbRepository.getIdentitiesWithFolderName(
          folderName: event.folderName,
        );

        logger.i('Folder detail loaded');

        // decryption

        final authBlocState = authBloc.state;

        if (authBlocState is AuthBlocAuthenticated) {
          final decryptedLogins = await encryptionRepository.decryptLoginList(
            encryptedLogins: logins,
            masterKey: authBlocState.MASTER_KEY,
          );
          final dectyptedCards = await encryptionRepository.decryptCardList(
            encryptedCards: cards,
            masterKey: authBlocState.MASTER_KEY,
          );
          final dectyptedIdentities = await encryptionRepository
              .decryptIdentityList(
                encryptedIdentities: identities,
                masterKey: authBlocState.MASTER_KEY,
              );

             emit(
            FolderDetailBlocState_loaded(
              logins: decryptedLogins,
              cards: dectyptedCards,
              identities: dectyptedIdentities,
            ),
          );  
        } else {
          emit(
            FolderDetailBlocState_loaded(
              logins: logins,
              cards: cards,
              identities: identities,
            ),
          );
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
