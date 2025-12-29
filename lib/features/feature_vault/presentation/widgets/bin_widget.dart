import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BinWidget extends StatelessWidget {
  const BinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bin'),
        BlocBuilder<BinBloc, BinBlocState>(
          builder: (context, state) => CustomListile(
            icon: AppIcon.deleteIcon,
            title: 'Bin',
            trailingValue: state is BinBlocState_loaded
                ? state.totalCount.toString()
                : '',
          ),
        ),
      ],
    );
  }
}
