import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/enum/lang_code_coverter.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/about_page/about_page.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/language_page/bloc/language_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassy_real_navbar/glassy_real_navbar.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class AuthPageAppbar extends StatelessWidget {
  const AuthPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.secondary.withOpacity(0.1),
        blur: 5,
      ),
      shape: LiquidRoundedSuperellipse(borderRadius: 12),
      child: SizedBox(
        width: double.infinity,

        child: Container(
          padding: EdgeInsets.all(AppConstant.appPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.tr(AppText.verifyMasterKey)),
              Spacer(),
              Row(
                spacing: AppConstant.appPadding,
                children: [
                  PopupMenuButton(
                    child: Icon(AppIcon.languageIcon),
                    itemBuilder: (context) {
                      return List.generate(context.supportedLocales.length, (
                        index,
                      ) {
                        final Locale locale = context.supportedLocales[index];
                        return PopupMenuItem(
                          child: Text(langCodeConverter(langCode: locale.languageCode)),
                          onTap: () {
                            context.setLocale(locale);

                            logger.e(context.locale.toString());

                            context.read<LanguageBloc>().add(
                              LanguageBlocEvent_setLangCode(
                                langCode: locale.languageCode,
                              ),
                            );
                          },
                        );
                      });
                    },
                  ),

                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height:
                                MediaQuery.of(context).size.height *
                                AppConstant.modalPageHeight,
                            child: AboutPage(),
                          );
                        },
                      );
                    },
                    icon: Icon(AppIcon.infoIcon),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
