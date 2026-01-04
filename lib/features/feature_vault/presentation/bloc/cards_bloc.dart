// ignore_for_file: camel_case_types

import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';

///
/// EVENT
///
abstract class CardsBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CardsBlocEvent_loadCards extends CardsBlocEvent {}

///
/// STATE
///
abstract class CardsBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CardsBlocState_init extends CardsBlocState {}

class CardsBlocState_loading extends CardsBlocState {}

class CardsBlocState_loaded extends CardsBlocState {
  final List<Card> cards;
  CardsBlocState_loaded({required this.cards});

  @override
  List<Object?> get props => [cards];
}

class CardsBlocState_error extends CardsBlocState {}

class CardsBlocState_success extends CardsBlocState {}

///
/// BLOC
///
class CardsBloc extends Bloc<CardsBlocEvent, CardsBlocState> {
  final LocalDbRepository localDbRepository;
  final EncryptionRepository encryptionRepository;
  final AuthBloc authBloc;
  CardsBloc({
    required this.localDbRepository,
    required this.authBloc,
    required this.encryptionRepository,
  }) : super(CardsBlocState_init()) {
    ///
    /// LOAD CARDS
    ///
    on<CardsBlocEvent_loadCards>((event, emit) async {
      final authBlocState = authBloc.state;

      if (authBlocState is AuthBlocAuthenticated) {
        try {
          logger.d('Load active cards');
          final cards = await localDbRepository.getActiveCard();
          logger.d('Cards: ${cards.length}');

          final decryptedList = await encryptionRepository.decryptCardList(
            encryptedCards: cards,
            masterKey: authBlocState.MASTER_KEY,
          );

          emit(CardsBlocState_loaded(cards: decryptedList));
        } catch (e) {
          logger.e(e);
        }
      }
    });
  }
}
