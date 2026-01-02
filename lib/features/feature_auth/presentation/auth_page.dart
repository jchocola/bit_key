import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_auth/presentation/widget/auth_page_appbar.dart';
import 'package:bit_key/features/feature_auth/presentation/widget/create_master_password.dart';
import 'package:bit_key/features/feature_auth/presentation/widget/master_password_input.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AppBg(
          child: Padding(
            padding: const EdgeInsets.all(AppConstant.appPadding),
            child: SafeArea(
              child: Column(
                spacing: AppConstant.appPadding,
                children: [
                 AuthPageAppbar(),
      
               // MasterPasswordInput(),
              CreateMasterPassword(),
                 BigButton(
                  title: 'Unlock',
                 ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
