// ignore_for_file: camel_case_types, unnecessary_brace_in_string_interps

import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/data/repo/no_screen_shot_repo_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/core/enum/clean_key_duration.dart';
import 'package:bit_key/core/enum/session_timout.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/domain/repo/app_security_repository.dart';
import 'package:bit_key/main.dart';

///
/// EVENT
///
abstract class AccSecurityBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccSecurityBlocEvent_load extends AccSecurityBlocEvent {}

class AccSecurityBlocEvent_toogleShakeToLock extends AccSecurityBlocEvent {}

class AccSecurityBlocEvent_toogleScreenShoot extends AccSecurityBlocEvent {}

class AccSecurityBlocEvent_setClearKeyDuration extends AccSecurityBlocEvent {
  final CLEAN_KEY_DURATION value;
  AccSecurityBlocEvent_setClearKeyDuration({required this.value});

  @override
  List<Object?> get props => [value];
}

class AccSecurityBlocEvent_setSessionTimeOut extends AccSecurityBlocEvent {
  final SESSION_TIMEOUT value;
  AccSecurityBlocEvent_setSessionTimeOut({required this.value});

  @override
  List<Object?> get props => [value];
}

///
/// STATE
///
abstract class AccSecurityBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccSecurityBlocState_initial extends AccSecurityBlocState {}

class AccSecurityBlocState_loading extends AccSecurityBlocState {}

class AccSecurityBlocState_loaded extends AccSecurityBlocState {
  final SESSION_TIMEOUT sessionTimeout;
  final CLEAN_KEY_DURATION clearKeyDuration;
  final bool enableScreenShoot;
  final bool shakeToLock;
  AccSecurityBlocState_loaded({
    required this.sessionTimeout,
    required this.clearKeyDuration,
    required this.enableScreenShoot,
    required this.shakeToLock,
  });

  @override
  List<Object?> get props => [
    sessionTimeout,
    clearKeyDuration,
    enableScreenShoot,
    shakeToLock,
  ];

  AccSecurityBlocState_loaded copyWith({
    SESSION_TIMEOUT? sessionTimeout,
    CLEAN_KEY_DURATION? clearKeyDuration,
    bool? enableScreenShoot,
    bool? shakeToLock,
  }) {
    return AccSecurityBlocState_loaded(
      sessionTimeout: sessionTimeout ?? this.sessionTimeout,
      clearKeyDuration: clearKeyDuration ?? this.clearKeyDuration,
      enableScreenShoot: enableScreenShoot ?? this.enableScreenShoot,
      shakeToLock: shakeToLock ?? this.shakeToLock,
    );
  }
}

///
/// BLOC
///
class AccSecurityBloc extends Bloc<AccSecurityBlocEvent, AccSecurityBlocState> {
  final AppSecurityRepository appSecurityRepository;
  final NoScreenShotRepoImpl noScreenShotRepoImpl;
  AccSecurityBloc({
    required this.appSecurityRepository,
    required this.noScreenShotRepoImpl,
  }) : super(AccSecurityBlocState_initial()) {
    ///
    /// LOAD
    ///
    on<AccSecurityBlocEvent_load>((event, emit) async {
      // load from shared prefs
      final sessionTimeout = await appSecurityRepository
          .getSessionTimeOutValue();
      final clearKey = await appSecurityRepository.getCleanKeyDurationValue();
      final enableScreenShoot = await appSecurityRepository
          .getAllowScreenShootValue();
      final shakeToLock = await appSecurityRepository
          .getEnableShakeToLockValue();

      logger.f(
        'sessionTimeOut : ${sessionTimeout}, clearKey : ${clearKey} , enableScreenshoot ${enableScreenShoot}, shake to lock ${shakeToLock}',
      );

      emit(
        AccSecurityBlocState_loaded(
          sessionTimeout: sessionTimeout,
          clearKeyDuration: clearKey,
          enableScreenShoot: enableScreenShoot,
          shakeToLock: shakeToLock,
        ),
      );
    });

    ///
    /// tooggle shake to lock
    ///
    on<AccSecurityBlocEvent_toogleShakeToLock>((event, emit) async {
      final currentState = state;

      if (currentState is AccSecurityBlocState_loaded) {
        await appSecurityRepository.toogleShakeToLockValue();
        final currentValue = await appSecurityRepository
            .getEnableShakeToLockValue();

        logger.d('Changed shake to lock value : $currentValue');
        emit(currentState.copyWith(shakeToLock: currentValue));
      }
    });

    ///
    /// Toogle screenshot
    ///
    on<AccSecurityBlocEvent_toogleScreenShoot>((event, emit) async {
      final currentState = state;

      if (currentState is AccSecurityBlocState_loaded) {
        await appSecurityRepository.toogleAllowScreenShootValue();
        final currentValue = await appSecurityRepository
            .getAllowScreenShootValue();

        if (currentValue == true) {
          await noScreenShotRepoImpl.enableScreenshot();
        } else {
          await noScreenShotRepoImpl.disableScreenshot();
        }

        logger.d('Changed Screenshot value: $currentValue');

        emit(currentState.copyWith(enableScreenShoot: currentValue));
      }
    });

    ///
    /// Set clean key value
    ///
    on<AccSecurityBlocEvent_setClearKeyDuration>((event, emit) async {
      final currentState = state;

      if (currentState is AccSecurityBlocState_loaded) {
        emit(currentState.copyWith(clearKeyDuration: event.value));

        await appSecurityRepository.changeCleanKeyDurationValue(
          value: event.value,
        );
        final currentValue = await appSecurityRepository
            .getCleanKeyDurationValue();

        logger.d('Changed Screenshot value: $currentValue');
        emit(currentState.copyWith(clearKeyDuration: currentValue));
      }
    });

    ///
    /// Set SESSION TIME OUT VALUE
    ///
    on<AccSecurityBlocEvent_setSessionTimeOut>((event, emit) async {
      final currentState = state;

      if (currentState is AccSecurityBlocState_loaded) {
        emit(currentState.copyWith(sessionTimeout: event.value));

        await appSecurityRepository.changeSessionTimeOutValue(
          value: event.value,
        );
        final currentValue = await appSecurityRepository
            .getSessionTimeOutValue();

        logger.d('Changed Screenshot value: $currentValue');
        emit(currentState.copyWith(sessionTimeout: currentValue));
      }
    });
  }
}
