// ignore_for_file: camel_case_typesR, camel_case_types

import 'dart:async';

import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';

///
/// EVENT
///
abstract class PickedItemBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedItemBlocEvent_pickLogin extends PickedItemBlocEvent {
  final Login login;
  PickedItemBlocEvent_pickLogin({required this.login});
  @override
  List<Object?> get props => [login];
}

class PickedItemBlocEvent_pickCard extends PickedItemBlocEvent {
  final Card card;
  PickedItemBlocEvent_pickCard({required this.card});
  @override
  List<Object?> get props => [card];
}

class PickedItemBlocEvent_pickIdentity extends PickedItemBlocEvent {
  final Identity identity;
  PickedItemBlocEvent_pickIdentity({required this.identity});
  @override
  List<Object?> get props => [identity];
}

class PickedItemBlocEvent_moveCardToBin extends PickedItemBlocEvent {
  final Completer<void>? completer;
  PickedItemBlocEvent_moveCardToBin({this.completer});
}

class PickedItemBlocEvent_moveLoginToBin extends PickedItemBlocEvent {
  final Completer<void>? completer;
  PickedItemBlocEvent_moveLoginToBin({this.completer});
}

class PickedItemBlocEvent_moveIdentityToBin extends PickedItemBlocEvent {
  final Completer<void>? completer;
  PickedItemBlocEvent_moveIdentityToBin({this.completer});
}

class PickedItemBlocEvent_editLogin extends PickedItemBlocEvent {
  final Login updatedLogin;
  PickedItemBlocEvent_editLogin({required this.updatedLogin});
  @override
  List<Object?> get props => [updatedLogin];
}

class PickedItemBloc_Event_editCard extends PickedItemBlocEvent {
  final Card updatedCard;
  PickedItemBloc_Event_editCard({required this.updatedCard});
  @override
  List<Object?> get props => [updatedCard];
}

class PickedItemBloc_Event_editIdentity extends PickedItemBlocEvent {
  final Identity updatedIdentity;
  PickedItemBloc_Event_editIdentity({required this.updatedIdentity});
  @override
  List<Object?> get props => [updatedIdentity];
}

///
/// STATE
///
abstract class PickedItemBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedItemBlocState_init extends PickedItemBlocState {}

class PickedItemBlocState_loading extends PickedItemBlocState {}

class PickedItemBlocState_loaded extends PickedItemBlocState {
  final Login? login;
  final Card? card;
  final Identity? identity;
  PickedItemBlocState_loaded({this.login, this.card, this.identity});

  @override
  List<Object?> get props => [login, card, identity];
}

class PickedItemBlocState_error extends PickedItemBlocState {}

class PickedItemBlocState_success extends PickedItemBlocState {}

///
/// BLOC
///
class PickedItemBloc extends Bloc<PickedItemBlocEvent, PickedItemBlocState> {
  final LocalDbRepository localDbRepository;
  final AuthBloc authBloc;
  final EncryptionRepository encryptionRepository;
  PickedItemBloc({
    required this.localDbRepository,
    required this.authBloc,
    required this.encryptionRepository,
  }) : super(PickedItemBlocState_init()) {
    ///
    /// PICK LOGIN
    ///
    on<PickedItemBlocEvent_pickLogin>((event, emit) {
      logger.d('Pick Login ${event.login.toString()}');
      emit(PickedItemBlocState_loaded(login: event.login));
    });

    ///
    /// PICK CARD
    ///
    on<PickedItemBlocEvent_pickCard>((event, emit) {
      logger.d('Pick Card ${event.card.toString()}');
      emit(PickedItemBlocState_loaded(card: event.card));
    });

    ///
    /// PICK IDENTITY
    ///
    on<PickedItemBlocEvent_pickIdentity>((event, emit) {
      logger.d('Pick Identity ${event.identity.toString()}');
      emit(PickedItemBlocState_loaded(identity: event.identity));
    });

    ///
    /// MOVE CARD TO BIN
    ///
    on<PickedItemBlocEvent_moveCardToBin>((event, emit) async {
      try {
        logger.d('Move card to bin');
        final currentState = state;
        if (currentState is PickedItemBlocState_loaded) {
          if (currentState.card != null) {
            await localDbRepository
                .moveCardToBin(card: currentState.card!)
                .then((_) {
                  logger.f('Moved card to bin!!!!');
                  event.completer?.complete();
                });

            // (analytic) track event MOVE_CARD_TO_BIN
            unawaited(
              getIt<AnalyticsFacadeRepoImpl>().trackEvent(
                AnalyticEvent.MOVE_CARD_TO_BIN.name,
              ),
            );
          } else {
            logger.e('Card empty');
          }
        } else {
          logger.e('Some error');
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// MOVE LOGIN TO BIN
    ///
    on<PickedItemBlocEvent_moveLoginToBin>((event, emit) async {
      try {
        logger.d('Move login to bin');
        final currentState = state;
        if (currentState is PickedItemBlocState_loaded) {
          if (currentState.login != null) {
            await localDbRepository
                .moveLoginToBin(login: currentState.login!)
                .then((_) {
                  logger.f('Moved login to bin!!!!');
                  event.completer?.complete();
                });

            // (analytic) track event MOVE_LOGIN_TO_BIN
            unawaited(
              getIt<AnalyticsFacadeRepoImpl>().trackEvent(
                AnalyticEvent.MOVE_LOGIN_TO_BIN.name,
              ),
            );
          } else {
            logger.e('Login empty');
          }
        } else {
          logger.e('Some error');
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// MOVE IDENTITY TO BIN
    ///
    on<PickedItemBlocEvent_moveIdentityToBin>((event, emit) async {
      try {
        logger.d('Move identity to bin');
        final currentState = state;
        if (currentState is PickedItemBlocState_loaded) {
          if (currentState.identity != null) {
            await localDbRepository
                .moveIdentityToBin(identity: currentState.identity!)
                .then((_) {
                  logger.f('Moved identity to bin!!!!');
                  event.completer?.complete();
                });

            // (analytic) track event MOVE_IDENTITY_TO_BIN
            unawaited(
              getIt<AnalyticsFacadeRepoImpl>().trackEvent(
                AnalyticEvent.MOVE_IDENTITY_TO_BIN.name,
              ),
            );
          } else {
            logger.e('Identity empty');
          }
        } else {
          logger.e('Some error');
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// EDIT LOGIN
    ///
    on<PickedItemBlocEvent_editLogin>((event, emit) async {
      logger.i('Edit Login');
      try {
        final authBlocState = authBloc.state;
        if (authBlocState is AuthBlocAuthenticated) {
          final encryptedLogin = await encryptionRepository.encryptLogin(
            login: event.updatedLogin,
            masterKey: authBlocState.MASTER_KEY,
          );

          logger.f('Login : ${event.updatedLogin.toString()}');
          logger.f('Encrypted Login : ${encryptedLogin.toString()}');

          await localDbRepository.updateLogin(login: encryptedLogin);

          // (analytic) track event EDIT_LOGIN
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.EDIT_LOGIN.name,
            ),
          );
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// EDIT CARDS
    ///
    on<PickedItemBloc_Event_editCard>((event, emit) async {
      logger.i('Edit Card');
      try {
        final authBlocState = authBloc.state;
        if (authBlocState is AuthBlocAuthenticated) {
          final encryptedCard = await encryptionRepository.encryptCard(
            card: event.updatedCard,
            masterKey: authBlocState.MASTER_KEY,
          );

          logger.f('Card : ${event.updatedCard.toString()}');
          logger.f('Encrypted card : ${encryptedCard.toString()}');

          await localDbRepository.updateCard(card: encryptedCard);

          // (analytic) track event EDIT_CARD
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.EDIT_CARD.name,
            ),
          );
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// EDIT IDENTITY
    ///
    on<PickedItemBloc_Event_editIdentity>((event, emit) async {
      logger.i('Edit Identity');
      try {
        final authBlocState = authBloc.state;
        if (authBlocState is AuthBlocAuthenticated) {
          final encryptedIdentity = await encryptionRepository.encryptIdentity(
            identity: event.updatedIdentity,
            masterKey: authBlocState.MASTER_KEY,
          );

          logger.f('Identity : ${event.updatedIdentity.toString()}');
          logger.f('Encrypted card : ${encryptedIdentity.toString()}');

          await localDbRepository.updateIdentity(identity: encryptedIdentity);

          // (analytic) track event EDIT_IDENTITY
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.EDIT_IDENTITY.name,
            ),
          );
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
