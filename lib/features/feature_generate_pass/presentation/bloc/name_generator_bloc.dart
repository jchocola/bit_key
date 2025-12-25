import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
abstract class NameGeneratorBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NameGeneratorBlocEvent_toogleIsMale extends NameGeneratorBlocEvent {}

class NameGeneratorBlocEvent_toogleFirstName extends NameGeneratorBlocEvent {}

class NameGeneratorBlocEvent_toogleLastName extends NameGeneratorBlocEvent {}

class NameGeneratorBlocEvent_toogleFullName extends NameGeneratorBlocEvent {}

///
/// STATE
///
abstract class NameGeneratorBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NameGeneratorBlocState_loaded extends NameGeneratorBlocState {
  final bool isMale;
  final bool firstName;
  final bool lastName;
  final bool fullName;
  final String zone;
  NameGeneratorBlocState_loaded({
    required this.isMale,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.zone,
  });

  @override
  List<Object?> get props => [isMale, firstName, lastName, fullName, zone];

  factory NameGeneratorBlocState_loaded.inital() =>
      NameGeneratorBlocState_loaded(
        isMale: true,
        firstName: false,
        lastName: false,
        fullName: true,
        zone: '',
      );

  NameGeneratorBlocState_loaded copyWith({
    bool? isMale,
    bool? firstName,
    bool? lastName,
    bool? fullName,
    String? zone,
  }) {
    return NameGeneratorBlocState_loaded(
      isMale: isMale ?? this.isMale,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      zone: zone ?? this.zone,
    );
  }
}

///
///BLOC
///
class NameGeneratorBloc
    extends Bloc<NameGeneratorBlocEvent, NameGeneratorBlocState> {
  NameGeneratorBloc() : super(NameGeneratorBlocState_loaded.inital()) {
    ///
    /// TOOGLE ISMALE
    ///
    on<NameGeneratorBlocEvent_toogleIsMale>((event, emit) {
      final currentState = state;

      if (currentState is NameGeneratorBlocState_loaded) {
        emit(currentState.copyWith(isMale: !currentState.isMale));
        logger.i('Changed isMale');
      }
    });

    ///
    /// TOOGLE FirstName
    ///
    on<NameGeneratorBlocEvent_toogleFirstName>((event, emit) {
      final currentState = state;

      if (currentState is NameGeneratorBlocState_loaded) {
        final nextValue = !currentState.firstName;

        if (nextValue == true) {
          emit(
            currentState.copyWith(
              firstName: nextValue,
              lastName: false,
              fullName: false,
            ),
          );
        } else {
          emit(currentState.copyWith(
            firstName: nextValue
          ));
        }
        logger.i('Changed firstname');
      }
    });


       ///
    /// TOOGLE Lastname
    ///
    on<NameGeneratorBlocEvent_toogleLastName>((event, emit) {
      final currentState = state;

      if (currentState is NameGeneratorBlocState_loaded) {
        final nextValue = !currentState.lastName;

        if (nextValue == true) {
          emit(
            currentState.copyWith(
              firstName: false,
              lastName: nextValue,
              fullName: false,
            ),
          );
        } else {
          emit(currentState.copyWith(
            lastName: nextValue
          ));
        }
        logger.i('Changed lastname');
      }
    });



       ///
    /// TOOGLE Full name
    ///
    on<NameGeneratorBlocEvent_toogleFullName>((event, emit) {
      final currentState = state;

      if (currentState is NameGeneratorBlocState_loaded) {
        final nextValue = !currentState.fullName;

        if (nextValue == true) {
          emit(
            currentState.copyWith(
              firstName: false,
              lastName: false,
              fullName: nextValue,
            ),
          );
        } else {
          emit(currentState.copyWith(
            fullName: nextValue,
            firstName: true
          ));
        }
        logger.i('Changed fulname');
      }
    }); 
  }
}
