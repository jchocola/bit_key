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
abstract class BinBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BinBlocEvent_load extends BinBlocEvent {}

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
  BinBloc({required this.localDbRepository}) : super(BinBlocState_init()) {
    ///
    /// LOAD
    ///
    on<BinBlocEvent_load>((event, emit) async {
      try {
        logger.d('Bin bloc load');
        final logins = await localDbRepository.getLoginsInBin();
        final cards = await localDbRepository.getCardsInBin();
        final identities = await localDbRepository.getIdentitiesInBin();
        final totalCount = logins.length + cards.length + identities.length;

        logger.i('Bin bloc loaded ${totalCount}');
        emit(
          BinBlocState_loaded(
            logins: logins,
            cards: cards,
            identities: identities,
            totalCount: totalCount,
          ),
        );
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
