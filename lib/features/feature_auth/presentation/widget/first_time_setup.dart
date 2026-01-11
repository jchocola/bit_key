import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_auth/presentation/widget/create_master_password.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';

class FirstTimeSetup extends StatefulWidget {
  const FirstTimeSetup({super.key});

  @override
  State<FirstTimeSetup> createState() => _FirstTimeSetupState();
}

class _FirstTimeSetupState extends State<FirstTimeSetup> {
  late TextEditingController masterController;
  late TextEditingController confirmMaterController;

  @override
  void initState() {
    super.initState();

    masterController = TextEditingController();
    confirmMaterController = TextEditingController();
  }

  @override
  void dispose() {
    masterController.dispose();
    confirmMaterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _onCreateMasterPassword() {
      try {
        context.read<AuthBloc>().add(
          AppBlocEvent_UserFirstimeRegister(
            MASTER_KEY: masterController.text,
            CONFIRM_MASTER_KEY: confirmMaterController.text,
          ),
        );
      } catch (e) {
        logger.e('Error creating master password: $e');
      }
    }

    return Column(
      spacing: AppConstant.appPadding,
      children: [
        CreateMasterPassword(
          masterPasswordController: masterController,
          confirmMasterPasswordController: confirmMaterController,
        ),
        BigButton(
          title: context.tr(AppText.create_master_key),
          onTap: _onCreateMasterPassword,
        ),
      ],
    );
  }
}
