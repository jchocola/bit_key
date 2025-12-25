// ignore_for_file: camel_case_types

import 'dart:math';

import 'package:bit_key/features/feature_generate_pass/data/model/password_strength.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/pass_generator_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/main.dart';

///
/// EVENT
///
abstract class PassGeneratorBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PassGeneratorBlocEvent_changeLength extends PassGeneratorBlocEvent {
  final double value;
  PassGeneratorBlocEvent_changeLength({required this.value});

  @override
  List<Object?> get props => [value];
}

class PassGeneratorBlocEvent_tooglePassUpper extends PassGeneratorBlocEvent {}

class PassGeneratorBlocEvent_tooglePassLower extends PassGeneratorBlocEvent {}

class PassGeneratorBlocEvent_tooglePassDigit extends PassGeneratorBlocEvent {}

class PassGeneratorBlocEvent_tooglePassSpecial extends PassGeneratorBlocEvent {}

class PassGeneratorBlocEvent_removeNumberDigit extends PassGeneratorBlocEvent {}

class PassGeneratorBlocEvent_addNumberDigit extends PassGeneratorBlocEvent {}

class PassGeneratorBlocEvent_removeNumberSpecial
    extends PassGeneratorBlocEvent {}

class PassGeneratorBlocEvent_addNumberSpecial extends PassGeneratorBlocEvent {}

class PassGeneratorBlocEvent_generatePass extends PassGeneratorBlocEvent {}

class PassGeneratorBlocEvent_changePageViewIndex
    extends PassGeneratorBlocEvent {
  final int index;
  PassGeneratorBlocEvent_changePageViewIndex({required this.index});

  @override
  List<Object?> get props => [index];
}

///
/// STATE
///
abstract class PassGeneratorBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PassGeneratorBlocState_state extends PassGeneratorBlocState {
  // VARIABLES
  final int length; // min 2 , max 256
  final bool passUpper;
  final bool passLower;
  final bool passDigit;
  final bool passSpecialSymbol;
  final int minDigit;
  final int minSpecialSymbol;
  final String generatedPass;
  final PasswordStrength? passwordStrength;

  final int pageviewIndex;

  PassGeneratorBlocState_state({
    required this.length,
    required this.passUpper,
    required this.passLower,
    required this.passDigit,
    required this.passSpecialSymbol,
    required this.minDigit,
    required this.minSpecialSymbol,
    required this.generatedPass,
    this.passwordStrength,
    required this.pageviewIndex,
  });

  factory PassGeneratorBlocState_state.initial() =>
      PassGeneratorBlocState_state(
        pageviewIndex: 0,
        length: 10,
        passUpper: true,
        passLower: true,
        passDigit: true,
        passSpecialSymbol: false,
        minDigit: 0,
        minSpecialSymbol: 0,
        generatedPass: '',
      );

  @override
  List<Object?> get props => [
    length,
    passUpper,
    passLower,
    passDigit,
    passSpecialSymbol,
    minDigit,
    minSpecialSymbol,
    generatedPass,
    passwordStrength,
    pageviewIndex,
  ];

  PassGeneratorBlocState_state copyWith({
    int? length,
    bool? passUpper,
    bool? passLower,
    bool? passDigit,
    bool? passSpecialSymbol,
    int? minDigit,
    int? minSpecialSymbol,
    String? generatedPass,
    PasswordStrength? passwordStrength,
    int? pageviewIndex,
  }) {
    return PassGeneratorBlocState_state(
      pageviewIndex: pageviewIndex ?? this.pageviewIndex,
      length: length ?? this.length,
      passUpper: passUpper ?? this.passUpper,
      passLower: passLower ?? this.passLower,
      passDigit: passDigit ?? this.passDigit,
      passSpecialSymbol: passSpecialSymbol ?? this.passSpecialSymbol,
      minDigit: minDigit ?? this.minDigit,
      minSpecialSymbol: minSpecialSymbol ?? this.minSpecialSymbol,
      generatedPass: generatedPass ?? this.generatedPass,
      passwordStrength: passwordStrength ?? this.passwordStrength,
    );
  }
}

///
/// BLOC
///
class PassGeneratorBloc
    extends Bloc<PassGeneratorBlocEvent, PassGeneratorBlocState> {
  final PassGeneratorRepo passGeneratorRepo;

  PassGeneratorBloc({required this.passGeneratorRepo})
    : super(PassGeneratorBlocState_state.initial()) {
    ///
    /// CHANGE LENGTH
    ///
    on<PassGeneratorBlocEvent_changeLength>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i(event.value);
        emit(currentState.copyWith(length: event.value.toInt()));
      }
      _checkParameter();
      add(PassGeneratorBlocEvent_generatePass());
    });

    ///
    /// TOOGLE PASS UPPER
    ///
    on<PassGeneratorBlocEvent_tooglePassUpper>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i(!currentState.passUpper);
        emit(currentState.copyWith(passUpper: !currentState.passUpper));
      }
      _checkParameter();
      add(PassGeneratorBlocEvent_generatePass());
    });

    ///
    /// TOOGLE PASS LOWER
    ///
    on<PassGeneratorBlocEvent_tooglePassLower>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i(!currentState.passLower);
        emit(currentState.copyWith(passLower: !currentState.passLower));
      }
      _checkParameter();
      add(PassGeneratorBlocEvent_generatePass());
    });

    ///
    /// TOOGLE PASS DIGIT
    ///
    on<PassGeneratorBlocEvent_tooglePassDigit>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i(!currentState.passDigit);
        emit(currentState.copyWith(passDigit: !currentState.passDigit));
      }
      _checkParameter();
      add(PassGeneratorBlocEvent_generatePass());
    });

    ///
    /// TOOGLE SPECIAL SYMBOL
    ///
    on<PassGeneratorBlocEvent_tooglePassSpecial>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i(!currentState.passSpecialSymbol);
        emit(
          currentState.copyWith(
            passSpecialSymbol: !currentState.passSpecialSymbol,
          ),
        );

        _checkParameter();
        add(PassGeneratorBlocEvent_generatePass());
      }
    });

    ///
    /// REMOVE NUMBER DIGIT
    ///
    on<PassGeneratorBlocEvent_removeNumberDigit>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i(currentState.minDigit);
        if (currentState.minDigit - 1 < 0) {
          return;
        } else {
          emit(currentState.copyWith(minDigit: currentState.minDigit - 1));
          add(PassGeneratorBlocEvent_generatePass());
        }
      }
    });

    ///
    /// ADD NUMBER DIGIT
    ///
    on<PassGeneratorBlocEvent_addNumberDigit>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i(currentState.minDigit);
        if (currentState.minDigit + 1 > currentState.length) {
          return;
        } else {
          emit(currentState.copyWith(minDigit: currentState.minDigit + 1));
          add(PassGeneratorBlocEvent_generatePass());
        }
      }
    });

    ///
    /// REMOVE NUMBER SPECIAL
    ///
    on<PassGeneratorBlocEvent_removeNumberSpecial>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i(currentState.minSpecialSymbol);
        if (currentState.minSpecialSymbol - 1 < 0) {
          return;
        } else {
          emit(
            currentState.copyWith(
              minSpecialSymbol: currentState.minSpecialSymbol - 1,
            ),
          );

          add(PassGeneratorBlocEvent_generatePass());
        }
      }
    });

    ///
    /// ADD NUMBER SPECIAL
    ///
    on<PassGeneratorBlocEvent_addNumberSpecial>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i(currentState.minSpecialSymbol);
        if (currentState.minSpecialSymbol + 1 > currentState.length) {
          return;
        } else {
          emit(
            currentState.copyWith(
              minSpecialSymbol: currentState.minSpecialSymbol + 1,
            ),
          );

          add(PassGeneratorBlocEvent_generatePass());
        }
      }
    });

    ///
    /// GENERATE PASS
    ///
    on<PassGeneratorBlocEvent_generatePass>((event, emit) {
      final generatedPass = _generatePassword();
      logger.d(generatedPass);
      final passStrength = passGeneratorRepo.estimateTimeToCrack(
        passLength: generatedPass.length,
        alphabetSize: 3,
      );
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        emit(
          currentState.copyWith(
            generatedPass: generatedPass,
            passwordStrength: passStrength,
          ),
        );
      }
    });

    ///
    /// CHANGE PAGE VIEW INDEX
    ///
    on<PassGeneratorBlocEvent_changePageViewIndex>((event, emit) {
      final currentState = state;
      if (currentState is PassGeneratorBlocState_state) {
        logger.i('Pageview index : ${event.index}');
        emit(currentState.copyWith(pageviewIndex: event.index));
      }
    });
  }

  void _checkParameter() {
    final currentState = state;

    if (currentState is PassGeneratorBlocState_state) {
      if (!currentState.passUpper &&
          !currentState.passLower &&
          !currentState.passDigit &&
          !currentState.passSpecialSymbol) {
        add(PassGeneratorBlocEvent_tooglePassLower());
        add(PassGeneratorBlocEvent_tooglePassUpper());
        add(PassGeneratorBlocEvent_tooglePassDigit());
      }
    }
  }

  String _generatePassword() {
    final currentState = state;

    if (currentState is PassGeneratorBlocState_state) {
      final generatedPass = passGeneratorRepo.generatePassword(
        length: currentState.length,
        passDigits: currentState.passDigit,
        passLower: currentState.passLower,
        passUpper: currentState.passUpper,
        passSafeSymbols: currentState.passSpecialSymbol,
      );
      return generatedPass;
    } else {
      return '';
    }
  }
}
