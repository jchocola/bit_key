import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generating_appbar.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generator_password.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generator_user.dart';
import 'package:flutter/material.dart';

class GeneratingPage extends StatelessWidget {
  const GeneratingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          GeneratingPageAppbar(),
          Expanded(child: PageView(
            children: [
              GeneratorPassword(),
              GeneratorUser(),
            ],
          )),
        ],
      ),
    );
  }
}
