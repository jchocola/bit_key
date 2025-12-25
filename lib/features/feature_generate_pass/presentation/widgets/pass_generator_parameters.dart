import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/pass_generator_repo.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class PassGeneratorParameters extends StatelessWidget {
  const PassGeneratorParameters({super.key});

  @override
  Widget build(BuildContext context) {
    final passGeneratorBloc_listen = context.watch<PassGeneratorBloc>();
    final passGeneratorBloc_read = context.read<PassGeneratorBloc>();
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: BlocBuilder<PassGeneratorBloc, PassGeneratorBlocState>(
        builder: (context, state) {
          if (state is PassGeneratorBlocState_state) {
            return Column(
              children: [
                ListTile(
                  leading: Text('Length'),
                  title: Slider.adaptive(
                    value: state.length.toDouble(),
                    onChanged: (value) {
                      passGeneratorBloc_read.add(
                        PassGeneratorBlocEvent_changeLength(value: value),
                      );
                    },
                    min: AppConstant.minPassLength,
                    max: AppConstant.maxPassLength,
                  ),
                  trailing: Text(state.length.toString()),
                ),

                const Divider(),

                ListTile(
                  leading: Text('A-Z'),
                  trailing: Switch.adaptive(
                    value: state.passUpper,
                    onChanged: (val) {
                      passGeneratorBloc_read.add(
                        PassGeneratorBlocEvent_tooglePassUpper(),
                      );
                    },
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: Text('a-z'),

                  trailing: Switch.adaptive(
                    value: state.passLower,
                    onChanged: (val) {
                      passGeneratorBloc_read.add(
                        PassGeneratorBlocEvent_tooglePassLower(),
                      );
                    },
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: Text('0-9'),

                  trailing: Switch.adaptive(
                    value: state.passDigit,
                    onChanged: (val) {
                      passGeneratorBloc_read.add(
                        PassGeneratorBlocEvent_tooglePassDigit(),
                      );
                    },
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: Text(passSafeSymbols),

                  trailing: Switch.adaptive(
                    value: state.passSpecialSymbol,
                    onChanged: (val) {
                      passGeneratorBloc_read.add(
                        PassGeneratorBlocEvent_tooglePassSpecial(),
                      );
                    },
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: Text('Maximum numbers'),
                  trailing: _qtyWidget(
                    value: state.maxDigit.toString(),
                    onRemove: () => passGeneratorBloc_read.add(
                      PassGeneratorBlocEvent_removeNumberDigit(),
                    ),

                    onAdd: () => passGeneratorBloc_read.add(
                      PassGeneratorBlocEvent_addNumberDigit(),
                    ),
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: Text('Maximum special'),
                  trailing: _qtyWidget(
                    value: state.maxSpecialSymbol.toString(),

                    onRemove: () => passGeneratorBloc_read.add(
                      PassGeneratorBlocEvent_removeNumberSpecial(),
                    ),
                    onAdd: () => passGeneratorBloc_read.add(
                      PassGeneratorBlocEvent_addNumberSpecial(),
                    ),
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

class _qtyWidget extends StatelessWidget {
  const _qtyWidget({super.key, required this.value, this.onRemove, this.onAdd});
  final String value;
  final void Function()? onRemove;
  final void Function()? onAdd;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: onRemove, icon: Icon(AppIcon.removeIcon)),
        Text(value),
        IconButton(onPressed: onAdd, icon: Icon(AppIcon.addIcon)),
      ],
    );
  }
}
