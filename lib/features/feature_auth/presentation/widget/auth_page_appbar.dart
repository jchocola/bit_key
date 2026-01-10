import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppConstant.appPadding,
            children: [
              Text(context.tr(AppText.verifyMasterKey)),
           
            ],
          ),
        ),
      ),
    );
  }
}
