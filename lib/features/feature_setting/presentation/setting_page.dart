import 'dart:async';

import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_import_export_data/presentation/bloc/export_data_bloc.dart';
import 'package:bit_key/features/feature_import_export_data/presentation/import_data_bloc.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/about_page/about_page.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/acc_security_page.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/bloc/acc_security_bloc.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/faq_page/faq_page.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/language_page/bloc/language_bloc.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/language_page/language_page.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/vault_page/vault_page.dart';
import 'package:bit_key/features/feature_setting/presentation/widgets/setting_appbar.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            SettingPageAppbar(),

            CustomListile(
              title: context.tr(AppText.account_security),
              icon: AppIcon.securityIcon,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<AccSecurityBloc>(context),
                        ),
                      ],
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height *
                            AppConstant.modalPageHeight,
                        child: const AccSecurityPage(),
                      ),
                    );
                  },
                );
              },
            ),
            CustomListile(
              title: context.tr(AppText.language),
              icon: AppIcon.languageIcon,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (modalContext) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<LanguageBloc>(context),
                        ),
                      ],
                      child: LanguagePage(),
                    );
                  },
                );
              },
            ),
            CustomListile(
              title: context.tr(AppText.vault),
              icon: AppIcon.vaultIcon,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  // isScrollControlled: true,
                  builder: (context) {
                    return SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          AppConstant.modalPageHeight,
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: BlocProvider.of<FoldersBloc>(context),
                          ),
                          BlocProvider.value(
                            value: BlocProvider.of<ExportDataBloc>(context),
                          ),
                          BlocProvider.value(
                            value: BlocProvider.of<ImportDataBloc>(context),
                          ),
                        ],
                        child: const VaultPage(),
                      ),
                    );
                  },
                );
              },
            ),
            CustomListile(
              title: context.tr(AppText.FAQs),
              icon: AppIcon.faqIcon,
              onTap: () {
                // (analytic) track event READ_FAQ_PAGE
                unawaited(
                  getIt<AnalyticsFacadeRepoImpl>().trackEvent(
                    AnalyticEvent.READ_FAQ_PAGE.name,
                  ),
                );

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          AppConstant.modalPageHeight,
                      child: const FaqPage(),
                    );
                  },
                );
              },
            ),
            CustomListile(
              title: context.tr(AppText.about_app),
              icon: AppIcon.infoIcon,
              onTap: () {

                // (analytic) track event READ_APP_ABOUT_PAGE
                unawaited(
                  getIt<AnalyticsFacadeRepoImpl>().trackEvent(
                    AnalyticEvent.READ_APP_ABOUT_PAGE.name,
                  ),
                );
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          AppConstant.modalPageHeight,
                      child: const AboutPage(),
                    );
                  },
                );
              },
            ),

            //  CustomListile(),
            //   CustomListile(),
            // BigButton(
            //   title: 'Clear SALT  and SumControlStr data',
            //   onTap: () async {
            //     await getIt<SecureStorageRepository>().deleteControlSumString();
            //     await getIt<SecureStorageRepository>().deleteSalt();
            //   },
            // ),

            // BlocBuilder<AuthBloc, AuthBlocState>(
            //   builder: (context, state) => BigButton(
            //     title: 'Get Master Key Via SessionKey and Encrypted Master Key',
            //     onTap: () async {
            //       if (state is AuthBlocAuthenticated) {
            //         final masterKey = await getIt<SecureStorageRepository>()
            //             .decryptEncryptedMasterKey(
            //               sessionKey: state.SESSION_KEY,
            //               encryptedMasterKey: state.ENCRYPTED_MASTER_KEY,
            //             );

            //         logger.f('Master key : ${masterKey}');
            //       }
            //     },
            //   ),
            // ),

            // BigButton(
            //   title: 'Enctypt: HELLO WORLD ',
            //   onTap: () async {
            //     await getIt<EncryptionRepository>().encrypt(
            //       str: 'HELLO WORLD',
            //       masterKey: 'qwerty',
            //     );
            //   },
            // ),

            // BigButton(
            //   title: 'Decrypt: HELLO WORLD ',
            //   onTap: () async {
            //     await getIt<EncryptionRepository>().decrypt(
            //       encryptedStr: 'rbYfL+0BfeARk469V74QgTyWJYl/q4nobQQyJ4S61Mw=',
            //       masterKey: 'qwerty',
            //     );
            //   },
            // ),
            BlocListener<AuthBloc, AuthBlocState>(
              listener: (context, state) {
                if (state is AuthBlocUnauthenticated) {
                  context.go('/auth');
                }
              },
              child: BigButton(
                title: context.tr(AppText.lock_app),
                onTap: () {
                  context.read<AuthBloc>().add(AuthBlocEvent_lockApp());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
