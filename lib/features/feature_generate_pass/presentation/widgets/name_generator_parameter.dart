import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/pass_generator_repo.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/name_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
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
                  leading: Text('Sex'),
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
                  leading: Text('First name'),
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
                  leading: Text('Last name'),

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
                  leading: Text('Full name'),

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
                  leading: Text('Zone'),

                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return List.generate(Zone.all.length, (index) {
                        return PopupMenuItem(child: Text(Zone.all[index].id));
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
