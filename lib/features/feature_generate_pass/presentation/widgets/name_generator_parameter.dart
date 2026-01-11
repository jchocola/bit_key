import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/generator_repo.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/name_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:random_name_generator/random_name_generator.dart';

class NameGeneratorParameters extends StatelessWidget {
  const NameGeneratorParameters({super.key});

  @override
  Widget build(BuildContext context) {
    final passGeneratorBloc_listen = context.watch<PassGeneratorBloc>();
    final passGeneratorBloc_read = context.read<PassGeneratorBloc>();
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: BlocBuilder<NameGeneratorBloc, NameGeneratorBlocState>(
        builder: (context, state) {
          if (state is NameGeneratorBlocState_loaded) {
            return Column(
              children: [
                ListTile(
                  leading: Text(state.isMale ? context.tr(AppText.male) : context.tr(AppText.female)),
                  trailing: Switch.adaptive(
                    value: state.isMale,
                    onChanged: (val) {
                      context.read<NameGeneratorBloc>().add(
                        NameGeneratorBlocEvent_toogleIsMale(),
                      );
                    },
                  ),
                ),

                Divider(),

                ListTile(
                  leading: Text(context.tr(AppText.first_name_generator)),
                  trailing: Switch.adaptive(
                    value: state.firstName,
                    onChanged: (val) {
                      context.read<NameGeneratorBloc>().add(
                        NameGeneratorBlocEvent_toogleFirstName(),
                      );
                    },
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: Text(context.tr(AppText.last_name_generator)),

                  trailing: Switch.adaptive(
                    value: state.lastName,
                    onChanged: (val) {
                      context.read<NameGeneratorBloc>().add(
                        NameGeneratorBlocEvent_toogleLastName(),
                      );
                    },
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: Text(context.tr(AppText.full_name)),

                  trailing: Switch.adaptive(
                    value: state.fullName,
                    onChanged: (val) {
                      context.read<NameGeneratorBloc>().add(
                        NameGeneratorBlocEvent_toogleFullName(),
                      );
                    },
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: Text(context.tr(AppText.zone)),

                  trailing: PopupMenuButton(
                    child: Text(state.zone.id),
                    itemBuilder: (context) {
                      return List.generate(Zone.all.length, (index) {
                        return PopupMenuItem(
                          onTap: () => context.read<NameGeneratorBloc>().add(
                            NameGeneratorBlocEvent_setZone(
                              zone: Zone.all[index],
                            ),
                          ),
                          child: Text(Zone.all[index].id),
                        );
                      });
                    },
                  ),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
