import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/acc_security_page.dart';
import 'package:bit_key/features/feature_setting/presentation/widgets/setting_appbar.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    height:
                        MediaQuery.of(context).size.height *
                        AppConstant.modalPageHeight,
                    child: const AccSecurityPage(),
                  );
                },
              );
            },
          ),
          CustomListile(title: 'Language', icon: AppIcon.languageIcon),
          CustomListile(title: 'Vault', icon: AppIcon.vaultIcon),
          CustomListile(title: 'About', icon: AppIcon.infoIcon),

          //  CustomListile(),
          //   CustomListile(),
          BigButton(
            title: 'Clear SALT  and SumControlStr data',
            onTap: () async {
              await getIt<SecureStorageRepository>().deleteControlSumString();
              await getIt<SecureStorageRepository>().deleteSalt();
            },
          ),

          BlocBuilder<AuthBloc, AuthBlocState>(
            builder: (context, state) => BigButton(
              title: 'Get Master Key Via SessionKey and Encrypted Master Key',
              onTap: () async {
                if (state is AuthBlocAuthenticated) {
                  final masterKey = await getIt<SecureStorageRepository>()
                      .decryptEncryptedMasterKey(
                        sessionKey: state.SESSION_KEY,
                        encryptedMasterKey: state.ENCRYPTED_MASTER_KEY,
                      );

                  logger.f('Master key : ${masterKey}');
                }
              },
            ),
          ),

          BigButton(
            title: 'Enctypt: HELLO WORLD ',
            onTap: () async {
              await getIt<EncryptionRepository>().encrypt(
                str: 'HELLO WORLD',
                masterKey: 'qwerty',
              );
            },
          ),

          BigButton(
            title: 'Decrypt: HELLO WORLD ',
            onTap: () async {
              await getIt<EncryptionRepository>().decrypt(
                encryptedStr: 'rbYfL+0BfeARk469V74QgTyWJYl/q4nobQQyJ4S61Mw=',
                masterKey: 'qwerty',
              );
            },
          ),
        ],
      ),
    );
  }
}
