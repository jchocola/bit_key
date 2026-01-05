// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_auth/presentation/widget/master_password_input.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnlockVault extends StatefulWidget {
  const UnlockVault({super.key});

  @override
  State<UnlockVault> createState() => _UnlockVaultState();
}

class _UnlockVaultState extends State<UnlockVault> {
  late TextEditingController masterKeyController;

  @override
  void initState() {
    super.initState();
    masterKeyController = TextEditingController();
  }

  @override
  void dispose() {
    masterKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _onUnlockVault() {
      try {
        context.read<AuthBloc>().add(
          AppBlocEvent_UserUnlockVaultViaMasterKey(
            MASTER_KEY: masterKeyController.text,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    void onFingerPrintTapped() {
      context.read<AuthBloc>().add(
        AuthBlocEvent_UserUnblockVaultViaLocalAuth(),
      );
      logger.i('Finger Print Tapped');
    }

    return Column(
      spacing: AppConstant.appPadding,
      children: [
        MasterPasswordInput(
          masterKeyController: masterKeyController,
          onFingerPrintTapped: onFingerPrintTapped,
        ),
        BigButton(title: 'Unlock Vault', onTap: () => _onUnlockVault()),
      ],
    );
  }
}
