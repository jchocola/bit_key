import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

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
                  Text('Cards', style: theme.textTheme.titleMedium),
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
