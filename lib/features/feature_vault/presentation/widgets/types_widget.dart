import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_vault/presentation/cards_page.dart';
import 'package:bit_key/features/feature_vault/presentation/identify_page.dart';
import 'package:bit_key/features/feature_vault/presentation/logins_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart';

class TypesWidget extends StatelessWidget {
  const TypesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Types'),
        CustomListile(
          icon: AppIcon.loginIcon,
          title: 'Login',
          onTap: () async {
            await FamilyModalSheet.show<void>(
              context: context,
              contentBackgroundColor: AppColor.transparent,
              builder: (ctx) {
                return LoginsPage();
              },
            );
          },
        ),
        CustomListile(icon: AppIcon.cardIcon, title: 'Card' , onTap: () async{
           await FamilyModalSheet.show<void>(
              context: context,
              contentBackgroundColor: AppColor.transparent,
              builder: (ctx) {
                return CardsPage();
              },
            );
        },),
        CustomListile(icon: AppIcon.identityIcon, title: 'Identity',
        onTap: () async{
            await FamilyModalSheet.show<void>(
              context: context,
              contentBackgroundColor: AppColor.transparent,
              builder: (ctx) {
                return IdentifyPage();
              },
            );
        },
        ),
      ],
    );
  }
}
