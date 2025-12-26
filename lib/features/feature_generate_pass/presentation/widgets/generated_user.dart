import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/name_generator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class GeneratedUser extends StatelessWidget {
  const GeneratedUser({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: BlocBuilder<NameGeneratorBloc, NameGeneratorBlocState>(
          builder: (context, state) {
            if (state is NameGeneratorBlocState_loaded) {
              return Row(
                children: [
                  Expanded(child: Text(state.generatedName)),
                  IconButton(
                    onPressed: () {
                      context.read<NameGeneratorBloc>().add(
                        NameGeneratorBlocEvent_generateName(),
                      );
                    },
                    icon: Icon(AppIcon.generatorIcon),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  Expanded(child: Text('Name')),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(AppIcon.generatorIcon),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
