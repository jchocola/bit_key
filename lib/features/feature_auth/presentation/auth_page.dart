// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_auth/presentation/widget/auth_page_appbar.dart';
import 'package:bit_key/features/feature_auth/presentation/widget/create_master_password.dart';
import 'package:bit_key/features/feature_auth/presentation/widget/master_password_input.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
                  BlocConsumer<AuthBloc, AuthBlocState>(
                    listener: (context, state) {
                      if (state is AuthBlocFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.exception?.name ?? '')),
                        );
                      } else if (state is AuthBlocAuthenticated) {
                        logger.i('User authenticated successfully.');

                        context.go('/main');
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthBlocFirstTimeUser) {
                        return _buildFirstTimeSetup(context);
                      } else if (state is AuthBlocUnauthenticated) {
                        return _buildUnlockVault(context);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstTimeSetup(BuildContext context) {
    void _onCreateMasterPassword() {
      try {
        context.read<AuthBloc>().add(
          AppBlocEvent_UserFirstimeRegister(
            USER_MASTER_PASSWORD: 'qwerty',
            CONFIRM_MASTER_PASSWORD: 'qwerty',
          ),
        );
      } catch (e) {
        logger.e('Error creating master password: $e');
      }
    }

    return Column(
      spacing: AppConstant.appPadding,
      children: [
        CreateMasterPassword(),
        BigButton(
          title: 'Create Master Password',
          onTap: _onCreateMasterPassword,
        ),
      ],
    );
  }

  Widget _buildUnlockVault(BuildContext context) {
    void _onUnlockVault() {
      try {
        context.read<AuthBloc>().add(
          AppBlocEvent_UserUnlockVault(USER_MASTER_PASSWORD: 'qwerty'),
        );
      } catch (e) {
        logger.e('Error unlocking vault: $e');
      }
    }

    return Column(
      spacing: AppConstant.appPadding,
      children: [
        MasterPasswordInput(),
        BigButton(title: 'Unlock Vault', onTap: () => _onUnlockVault()),
      ],
    );
  }
}
