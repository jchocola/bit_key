// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
abstract class CreateCardBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateCardBlocEvent_createCard extends CreateCardBlocEvent {
  final Card card;
  CreateCardBlocEvent_createCard({required this.card});

  @override
  List<Object?> get props => [card];
}

///
/// STATE
///
abstract class CreateCardBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateCardBlocState_init extends CreateCardBlocState {}

class CreateCardBlocState_error extends CreateCardBlocState {}

class CreateCardBlocState_success extends CreateCardBlocState {}

///
/// BLOC
///
class CreateCardBloc extends Bloc<CreateCardBlocEvent, CreateCardBlocState> {
  final LocalDbRepository localDbRepository;
  final EncryptionRepository encryptionRepository;
  final AuthBloc authBloc;
  CreateCardBloc({
    required this.localDbRepository,
    required this.authBloc,
    required this.encryptionRepository,
  }) : super(CreateCardBlocState_init()) {
    ///
    /// CREATE NEW CARD
    ///
    on<CreateCardBlocEvent_createCard>((event, emit) async {
      final authBlocState = authBloc.state;

      if (authBlocState is AuthBlocAuthenticated) {
        try {
          logger.d('Create new card');

          final encryptedCard = await encryptionRepository.encryptCard(
            card: event.card,
            masterKey: authBlocState.MASTER_KEY,
          );

          logger.f(event.card.toString());
          logger.f('Encrypted card : ${encryptedCard.toString()}');

          await localDbRepository.saveCard(card: encryptedCard);
          logger.i('Created new card!');

          // (analytic) track event CREATE_CARD
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>() .trackEvent(AnalyticEvent.CREATE_CARD.name),
          );
          
        } catch (e) {
          logger.e(e);
        }
      }
    });
  }
}
