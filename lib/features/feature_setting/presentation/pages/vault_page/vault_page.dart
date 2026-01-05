import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';

class VaultPage extends StatelessWidget {
  const VaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstant.appPadding,
            vertical: AppConstant.appPadding,
          ),
          child: Column(
            spacing: AppConstant.appPadding,
            children: [
              Text('Vault Page'),

              CustomListile(
                title: 'Folders',
              ),

              CustomListile(title: 'Export Data',),

              BigButton(title: 'Clear all data',color: AppColor.error,)
            ],
          ),
        ),
      ),
    );
  }

}
