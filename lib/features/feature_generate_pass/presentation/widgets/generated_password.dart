import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class GeneratedPassword extends StatelessWidget {
  const GeneratedPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: BlocBuilder<PassGeneratorBloc, PassGeneratorBlocState>(
          builder: (context, state) {
            if (state is PassGeneratorBlocState_state) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(state.generatedPass)),
                      IconButton(
                        onPressed: () {
                          context.read<PassGeneratorBloc>().add(
                            PassGeneratorBlocEvent_generatePass(),
                          );
                        },
                        icon: Icon(AppIcon.generatorIcon),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
