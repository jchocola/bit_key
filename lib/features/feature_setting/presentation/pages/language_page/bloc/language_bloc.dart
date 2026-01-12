// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_setting/presentation/pages/language_page/data/repo/language_setting_repo_impl.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/language_page/domain/repo/language_setting_repo.dart';
import 'package:bit_key/main.dart';

///
/// event
///
abstract class LanguageBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LanguageBlocEvent_loadCurrentLangCode extends LanguageBlocEvent {}

class LanguageBlocEvent_setLangCode extends LanguageBlocEvent {
  final String langCode;
  LanguageBlocEvent_setLangCode({required this.langCode});

  @override
  List<Object?> get props => [langCode];
}

///
/// state
///
abstract class LanguageBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LanguageBlocState_initial extends LanguageBlocState {}

class LanguageBlocState_loaded extends LanguageBlocState {
  final String currentLangCode;
  LanguageBlocState_loaded({required this.currentLangCode});
  @override
  List<Object?> get props => [currentLangCode];
}

///
/// state
///
class LanguageBloc extends Bloc<LanguageBlocEvent, LanguageBlocState> {
  final LanguageSettingRepo languageSettingRepo;
  LanguageBloc({required this.languageSettingRepo})
    : super(LanguageBlocState_initial()) {
    ///
    /// LOAD CURRENT LANG CODE
    ///
    on<LanguageBlocEvent_loadCurrentLangCode>((event, emit) async {
      try {
        final currentLangCode = await languageSettingRepo.getCurrentLangCode();

        emit(LanguageBlocState_loaded(currentLangCode: currentLangCode));
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// CHANGE CURRENT LANG CODE
    ///
    on<LanguageBlocEvent_setLangCode>((event, emit) async {
      try {
        // chngae lang code on shared prefs
        await languageSettingRepo.setLangCode(langCode: event.langCode);

        // (analytic) track event CHANGE_LANGUAGE
        unawaited(
          getIt<AnalyticsFacadeRepoImpl>().trackEvent(
            AnalyticEvent.CHANGE_LANGUAGE.name,
            {
              "LANG_CODE": event.langCode,
            },
          ),
        );

        // reload
        add(LanguageBlocEvent_loadCurrentLangCode());
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
