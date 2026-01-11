import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/enum/lang_code_coverter.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/language_page/bloc/language_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
          child: Column(
            spacing: AppConstant.appPadding,
            children: [
              Text(context.tr(AppText.language)),
              buildSupportedLocales(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSupportedLocales(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageBlocState>(
      builder: (context, state) => Column(
        spacing: AppConstant.appPadding,
        children: List.generate(context.supportedLocales.length, (index) {
          final Locale locale = context.supportedLocales[index];
          return BigButton(
            onTap: () {
              context.setLocale(locale);

            logger.e(context.locale.toString());
            
              context.read<LanguageBloc>().add(
                LanguageBlocEvent_setLangCode(langCode: locale.languageCode),
              );

            },
            title: langCodeConverter(langCode: locale.languageCode),
            color: state is LanguageBlocState_loaded
                ? state.currentLangCode == locale.languageCode
                      ? AppColor.error
                      : null
                : null,
          );
        }),
      ),
    );
  }
}
