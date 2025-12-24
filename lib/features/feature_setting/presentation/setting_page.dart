import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/features/feature_setting/presentation/widgets/setting_appbar.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          SettingPageAppbar(),
        
          CustomListile(title: 'Account security',),
           CustomListile(title: 'Import/Export data',),
            CustomListile(title: 'About',),
            //  CustomListile(),
            //   CustomListile(),
        ],
      ),
    );
  }
}
