import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/name_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generated_password.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generated_user.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/name_generator_parameter.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/pass_generator_parameters.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
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
            title: 'Copy',
            onTap: () {
              if (currentState is NameGeneratorBlocState_loaded) {
                Clipboard.setData(ClipboardData(text: currentState.generatedName));
              }
              
            },
          ),

          // BlocBuilder<PassGeneratorBloc, PassGeneratorBlocState>(
          //   builder: (context, state) {
          //     if (state is PassGeneratorBlocState_state) {
          //       return Text(state.passwordStrength?.strength ?? '');
          //     } else {
          //       return CircleAvatar();
          //     }
          //   },
          // ),
          NameGeneratorParameters(),
        ],
      ),
    );
  }
}