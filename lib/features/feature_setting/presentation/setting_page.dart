import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/acc_security_page.dart';
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

          CustomListile(
            title: 'Account security',
            icon: AppIcon.securityIcon,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * AppConstant.modalPageHeight,
                    child: const AccSecurityPage());
                },
              );
            },
          ),
          CustomListile(title: 'Language', icon: AppIcon.languageIcon),
          CustomListile(title: 'Vault', icon: AppIcon.vaultIcon),
          CustomListile(title: 'About', icon: AppIcon.infoIcon),
          //  CustomListile(),
          //   CustomListile(),
        ],
      ),
    );
  }
}
