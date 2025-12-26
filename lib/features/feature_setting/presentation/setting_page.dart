import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
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
        
          CustomListile(title: 'Account security', icon: AppIcon.securityIcon,),
           CustomListile(title: 'Language', icon: AppIcon.languageIcon,),
           CustomListile(title: 'Vault', icon: AppIcon.vaultIcon,),
            CustomListile(title: 'About', icon: AppIcon.infoIcon,),
            //  CustomListile(),
            //   CustomListile(),
        ],
      ),
    );
  }
}
