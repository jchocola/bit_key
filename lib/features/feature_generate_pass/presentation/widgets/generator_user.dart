import 'dart:async';

import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/name_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generated_password.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generated_user.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/name_generator_parameter.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/pass_generator_parameters.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratorUser extends StatelessWidget {
  const GeneratorUser({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<NameGeneratorBloc>().state;
    return SingleChildScrollView(
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          GeneratedUser(),
          BigButton(
            title: context.tr(AppText.copy),
            onTap: () {
              if (currentState is NameGeneratorBlocState_loaded) {
                Clipboard.setData(ClipboardData(text: currentState.generatedName));
              }
                // (analytic) track event COPY_TAPPED
                unawaited(
                  getIt<AnalyticsFacadeRepoImpl>().trackEvent(
                    AnalyticEvent.COPY_TAPPED.name,
                  ),
                );
            },
          ),

          NameGeneratorParameters(),
        ],
      ),
    );
  }
}