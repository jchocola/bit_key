import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/widgets/acc_sec_appbar.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';

class AccSecurityPage extends StatelessWidget {
  const AccSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding, vertical: AppConstant.appPadding),
          child: Column(
            spacing: AppConstant.appPadding,
            children: [
              AppSecPageAppbar(),
              SizedBox(height: AppConstant.appPadding),
              CustomListile(
                icon: Icons.fingerprint,
                title: 'Face ID',
                trailingValue: 'Enabled',
              ),

              CustomListile(
                icon: Icons.fingerprint,
                title: 'Pin Code',
                trailingValue: 'Enabled',
              ),

              CustomListile(
                icon: Icons.fingerprint,
                title: 'Session Timeout',
                trailingValue: 'Enabled',
              ),

               CustomListile(
                icon: Icons.fingerprint,
                title: 'Change Master Password',
                trailingValue: 'Enabled',
              ),


                CustomListile(
                icon: Icons.fingerprint,
                title: 'Чистка вреенных ключей',
                trailingValue: 'каждый час',
              ),

                CustomListile(
                icon: Icons.fingerprint,
                title: 'Криншот',
                trailingValue: 'каждый час',
              ), 
               CustomListile(
                icon: Icons.fingerprint,
                title: 'Shake to close',
                trailingValue: 'каждый час',
              ),   

              Text('Внимание , после очистки временных ключей, потребуется повторный вход во аккаунты. Face ID и Pin Code работать не будут до повторного ввода основных учетных данных.'), 

            ],
          ),
        ),
      ),
    );
  }
}
