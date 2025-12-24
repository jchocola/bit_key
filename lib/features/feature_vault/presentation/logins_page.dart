import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/presentation/view_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart';

class LoginsPage extends StatelessWidget {
  const LoginsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            spacing: AppConstant.appPadding,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logins', style: theme.textTheme.titleMedium),
                  IconButton(onPressed: () {
                    FamilyModalSheet.of(context).popPage();
                  }, icon: Icon(AppIcon.cancelIcon)),
                ],
              ),
              SearchTextfiled(),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: AppConstant.appPadding,
                    children: [
                      CustomListile(
                        onTap: () {
                          FamilyModalSheet.of(context).pushPage(ViewInfoPage());
                        },
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                      CustomListile(
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
