// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
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
abstract class BinBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BinBlocEvent_load extends BinBlocEvent {}

class BinBlocEvent_deleteAllFromBin extends BinBlocEvent {
  final Completer<void>? completer;
  BinBlocEvent_deleteAllFromBin({this.completer});
}

class BinBlocEvent_restoreItem extends BinBlocEvent {
  final Object item;
  final Completer<void>? completer;
  BinBlocEvent_restoreItem({required this.item, this.completer});

  @override
  List<Object?> get props => [item, completer];
}

class BinBlocEvent_deletePermantlyItem extends BinBlocEvent {
  final Object item;
  final Completer<void>? completer;
  BinBlocEvent_deletePermantlyItem({required this.item, this.completer});

  @override
  List<Object?> get props => [item, completer];
}

///
/// STATE
///
abstract class BinBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BinBlocState_init extends BinBlocState {}

class BinBlocState_loading extends BinBlocState {}

class BinBlocState_loaded extends BinBlocState {
  final List<Login> logins;
  final List<Card> cards;
  final List<Identity> identities;
  final int totalCount;
  BinBlocState_loaded({
    required this.logins,
    required this.cards,
    required this.identities,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [logins, cards, identities, totalCount];
}

class BinBlocState_error extends BinBlocState {}

class BinBlocState_success extends BinBlocState {}

///
/// BLOC
///
class BinBloc extends Bloc<BinBlocEvent, BinBlocState> {
  final LocalDbRepository localDbRepository;
  final EncryptionRepository encryptionRepository;
  final AuthBloc authBloc;
  BinBloc({
    required this.localDbRepository,
    required this.authBloc,
    required this.encryptionRepository,
  }) : super(BinBlocState_init()) {
    ///
    /// LOAD
    ///
    on<BinBlocEvent_load>((event, emit) async {
      try {
        // encrypted data
        logger.d('Bin bloc load');
        final logins = await localDbRepository.getLoginsInBin();
        final cards = await localDbRepository.getCardsInBin();
        final identities = await localDbRepository.getIdentitiesInBin();
        final totalCount = logins.length + cards.length + identities.length;

        logger.i('Bin bloc loaded ${totalCount}');

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
            BinBlocState_loaded(
              logins: decryptedLogins,
              cards: dectyptedCards,
              identities: dectyptedIdentities,
              totalCount: totalCount,
            ),
          );
        } else {
          emit(
            BinBlocState_loaded(
              logins: logins,
              cards: cards,
              identities: identities,
              totalCount: totalCount,
            ),
          );
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// DELETE ALL FROM BIN
    ///
    on<BinBlocEvent_deleteAllFromBin>((event, emit) async {
      try {
        logger.d('Bin bloc delete all from bin');
        await localDbRepository.deleteAllLoginsFromBin();
        await localDbRepository.deleteAllCardsFromBin();
        await localDbRepository.deleteAllIdentitiesFromBin();
        event.completer?.complete();
        logger.f('Bin bloc deleted all from bin');

        // (analytic) track event CLEAR_BIN
        unawaited(
          getIt<AnalyticsFacadeRepoImpl>().trackEvent(
            AnalyticEvent.CLEAR_BIN.name,
          ),
        );

        add(BinBlocEvent_load());
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// RESTORE ITEM
    ///
    on<BinBlocEvent_restoreItem>((event, emit) async {
      try {
        logger.d('Bin bloc restore item');
        final item = event.item;
        if (item is Login) {
          await localDbRepository.restoreLoginFromBin(login: item);

          // (analytic) track event RESTORE_LOGIN
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.RESTORE_LOGIN.name,
            ),
          );
        } else if (item is Card) {
          await localDbRepository.restoreCardFromBin(card: item);
          // (analytic) track event RESTORE_CARD
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.RESTORE_CARD.name,
            ),
          );
        } else if (item is Identity) {
          await localDbRepository.restoreIdentityFromBin(identity: item);
          // (analytic) track event RESTORE_IDENTITY
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.RESTORE_IDENTITY.name,
            ),
          );
        }
        logger.f('Bin bloc restored item');
        event.completer?.complete();
        add(BinBlocEvent_load());
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// DELETE PERMANENTLY ITEM
    ///
    on<BinBlocEvent_deletePermantlyItem>((event, emit) async {
      try {
        logger.d('Bin bloc delete permantly item');
        final item = event.item;
        if (item is Login) {
          await localDbRepository.deleteLogin(login: item);
          // (analytic) track event DELETE_LOGIN
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.DELETE_LOGIN.name,
            ),
          );
        } else if (item is Card) {
          await localDbRepository.deleteCard(card: item);
          // (analytic) track event DELETE_CARD
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.DELETE_CARD.name,
            ),
          );
        } else if (item is Identity) {
          await localDbRepository.deleteIdentity(identtity: item);
          // (analytic) track event DELETE_IDENTITY
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.DELETE_IDENTITY.name,
            ),
          );
        }
        logger.f('Bin bloc deleted permantly item');
        event.completer?.complete();
        add(BinBlocEvent_load());
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
