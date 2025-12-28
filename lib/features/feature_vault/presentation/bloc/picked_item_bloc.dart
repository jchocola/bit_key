// ignore_for_file: camel_case_typesR

import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';

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
  List<Object?> get props => [login,card,identity];
}

class PickedItemBlocState_error extends PickedItemBlocState {}

class PickedItemBlocState_success extends PickedItemBlocState {}

///
/// BLOC
///
class PickedItemBloc extends Bloc<PickedItemBlocEvent, PickedItemBlocState> {
  PickedItemBloc() : super(PickedItemBlocState_init()) {
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
  }
}
