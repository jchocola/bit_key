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
// ignore_for_file: camel_case_types

abstract class SearchBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchBlocEvent_startSearch extends SearchBlocEvent {
  final String query;
  SearchBlocEvent_startSearch({required this.query});

  @override
  List<Object?> get props => [query];
}

///
/// STATE
///
abstract class SearchBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchBlocState_initial extends SearchBlocState {}

class SearchBlocState_searching extends SearchBlocState {
  final List<Login> logins;
  final List<Card> cards;
  final List<Identity> identities;
  final int totalResults;
  SearchBlocState_searching({
    required this.logins,
    required this.cards,
    required this.identities,
    required this.totalResults,
  });
  @override
  List<Object?> get props => [logins, cards, identities, totalResults];
}

///
/// BLOC
///
class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final LocalDbRepository localDbRepository;
  SearchBloc({required this.localDbRepository})
    : super(SearchBlocState_initial()) {
    ///
    /// EVENT HANDLERS
    ///
    on<SearchBlocEvent_startSearch>((event, emit) async {

      logger.d('Event: SearchBlocEvent_startSearch with query: ${event.query}');
      if (event.query.isEmpty) {
        emit(SearchBlocState_initial());
        return;
      }

      final logins = await localDbRepository.searchLogins(event.query);
      final cards = await localDbRepository.searchCards(event.query);
      final identities = await localDbRepository.searchIdentities(event.query);

      emit(SearchBlocState_searching(
        logins: logins,
        cards: cards,
        identities: identities,
        totalResults: logins.length + cards.length + identities.length,
      ));
    });
  }
}
