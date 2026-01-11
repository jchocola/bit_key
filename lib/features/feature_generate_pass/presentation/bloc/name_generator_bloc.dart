import 'dart:async';

import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/generator_repo.dart';
import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_name_generator/random_name_generator.dart' show Zone;

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

class NameGeneratorBlocEvent_setZone extends NameGeneratorBlocEvent {
  final Zone zone;
  NameGeneratorBlocEvent_setZone({required this.zone});

  @override
  List<Object?> get props => [zone];
}

class NameGeneratorBlocEvent_generateName extends NameGeneratorBlocEvent {}

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
  final Zone zone;
  final String generatedName;
  NameGeneratorBlocState_loaded({
    required this.isMale,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.zone,
    required this.generatedName,
  });

  @override
  List<Object?> get props => [isMale, firstName, lastName, fullName, zone, generatedName];

  factory NameGeneratorBlocState_loaded.inital() =>
      NameGeneratorBlocState_loaded(
        isMale: true,
        firstName: false,
        lastName: false,
        fullName: true,
        zone: Zone.uk,
        generatedName: '',
      );

  NameGeneratorBlocState_loaded copyWith({
    bool? isMale,
    bool? firstName,
    bool? lastName,
    bool? fullName,
    Zone? zone,
    String? generatedName,
  }) {
    return NameGeneratorBlocState_loaded(
      isMale: isMale ?? this.isMale,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      zone: zone ?? this.zone,
      generatedName: generatedName ?? this.generatedName,
    );
  }
}

///
///BLOC
///
class NameGeneratorBloc
    extends Bloc<NameGeneratorBlocEvent, NameGeneratorBlocState> {
  final GeneratorRepo generatorRepo;
  NameGeneratorBloc({required this.generatorRepo})
    : super(NameGeneratorBlocState_loaded.inital()) {
    ///
    /// TOOGLE ISMALE
    ///
    on<NameGeneratorBlocEvent_toogleIsMale>((event, emit) {
      final currentState = state;

      if (currentState is NameGeneratorBlocState_loaded) {
        emit(currentState.copyWith(isMale: !currentState.isMale));
        logger.i('Changed isMale');
      }

       add(NameGeneratorBlocEvent_generateName());
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
          emit(currentState.copyWith(firstName: nextValue));
        }

         add(NameGeneratorBlocEvent_generateName());
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
          emit(currentState.copyWith(lastName: nextValue));
        }

         add(NameGeneratorBlocEvent_generateName());
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
          emit(currentState.copyWith(fullName: nextValue, firstName: true));
        }
         add(NameGeneratorBlocEvent_generateName());
        logger.i('Changed fulname');
      }
    });

    ///
    /// SET ZONE
    ///
    on<NameGeneratorBlocEvent_setZone>((event, emit) {
      final currentState = state;
      if (currentState is NameGeneratorBlocState_loaded) {
        emit(currentState.copyWith(zone: event.zone));
        add(NameGeneratorBlocEvent_generateName());

        logger.i('Changed Zone : ${event.zone.fullNameStructure}');
      }
    });

    ///
    /// GENERATE NAME
    ///
    on<NameGeneratorBlocEvent_generateName>((event, emit) {
      final currentState = state;
      if (currentState is NameGeneratorBlocState_loaded) {
        final name = generatorRepo.generateName(
          isMan: currentState.isMale,
          firstName: currentState.firstName,
          lastName: currentState.lastName,
          fullName: currentState.fullName,
          zone: currentState.zone,
        );

          // (analytic) track event GENERATE_PROFILE
          unawaited(
            getIt<AnalyticsFacadeRepoImpl>().trackEvent(
              AnalyticEvent.GENERATE_PROFILE.name,
            ),
          );

        emit(currentState.copyWith(generatedName: name));
        logger.d(name);
      }
    });
  }
}
