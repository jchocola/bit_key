import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/search_bloc.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class VaultPageAppbar extends StatelessWidget {
  const VaultPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.secondary.withOpacity(0.1),
        blur: 5
      ),
      shape: LiquidRoundedSuperellipse(
      borderRadius: 12,
    
    ), child: SizedBox(
      width: double.infinity,
      
      child: Container(
        padding: EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My vault'),
            SearchTextfiled(
              onChanged: (value) {
                context.read<SearchBloc>().add(SearchBlocEvent_startSearch(query: value));
              },
            )
          ],
        ))));
  }

}
