// ignore_for_file: camel_case_types

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_login/bloc/create_login_bloc.dart';
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
  CreateCardBloc({required this.localDbRepository})
    : super(CreateCardBlocState_init()) {
    ///
    /// CREATE NEW CARD
    ///
    on<CreateCardBlocEvent_createCard>((event, emit) async {
      try {
        logger.d('Create new card');
        await localDbRepository.saveCard(card: event.card);
        logger.i('Created new card!');
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
