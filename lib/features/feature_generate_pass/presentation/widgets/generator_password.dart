import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generated_password.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/pass_generator_parameters.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratorPassword extends StatelessWidget {
  const GeneratorPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<PassGeneratorBloc>().state;
    return SingleChildScrollView(
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          GeneratedPassword(),
          BigButton(
            title: context.tr(AppText.copy),
            onTap: () {
              if (currentState is PassGeneratorBlocState_state) {
                Clipboard.setData(ClipboardData(text: currentState.generatedPass));
              }
              
            },
          ),
          PassGeneratorParameters(),
        ],
      ),
    );
  }
}
