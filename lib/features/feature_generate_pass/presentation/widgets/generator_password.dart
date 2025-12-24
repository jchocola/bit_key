import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generated_password.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/pass_generator_parameters.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:flutter/material.dart';

class GeneratorPassword extends StatelessWidget {
  const GeneratorPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          GeneratedPassword(),
          BigButton(title: 'Copy',),
          PassGeneratorParameters(),
        
        ],
      ),
    );
  }
}
