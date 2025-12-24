import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';

class BinWidget extends StatelessWidget {
  const BinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bin'),
        CustomListile(),
       
      ],
    );
  }
}
