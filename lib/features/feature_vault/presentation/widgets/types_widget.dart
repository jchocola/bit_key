import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';

class TypesWidget extends StatelessWidget {
  const TypesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Types'),
        CustomListile(icon: AppIcon.loginIcon,title: 'Login',),
         CustomListile(icon: AppIcon.cardIcon, title: 'Card',),
          CustomListile(icon: AppIcon.identityIcon,title: 'Identity',),
      ],
    );
  }
}
