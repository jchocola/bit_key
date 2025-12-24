import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_vault/presentation/delete_confirm.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class ViewInfoPage extends StatelessWidget {
  const ViewInfoPage({super.key});

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
                  IconButton(
                    onPressed: () {
                      FamilyModalSheet.of(context).popPage();
                    },
                    icon: Icon(AppIcon.arrowBackIcon),
                  ),
                  Text('Info Page', style: theme.textTheme.titleMedium),
                  IconButton(onPressed: () {}, icon: Icon(AppIcon.moreIcon)),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppConstant.appPadding,
                    children: [
                      CustomListile(
                        onTap: () {},
                        title: 'github',
                        subTitle: 'sangsangden@gmail',
                        trailingValue: 'IT',
                      ),

                      Text('CREDENTIALS'),
                      _credentialsInfo(),

                      Text(
                        'Created : 9 Nov 2022 , 21:59',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        'Last Edited : 9 Nov 2022 , 21:59',
                        style: theme.textTheme.bodySmall,
                      ),

                      Row(
                        spacing: AppConstant.appPadding,
                        children: [
                          Expanded(
                            flex: 1,
                            child: BigButton(
                              title: 'Delete',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DeleteConfirm(),
                                );
                              },
                            ),
                          ),
                          Expanded(flex: 3, child: BigButton(title: 'Edit')),
                        ],
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

class _credentialsInfo extends StatelessWidget {
  const _credentialsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: Column(
        children: [
          _specialListile(withHide: true),

          const Divider(),
          _specialListile(withHide: false),
        ],
      ),
    );
  }
}

class _specialListile extends StatefulWidget {
  const _specialListile({super.key, this.withHide = false});
  final bool withHide;
  @override
  State<_specialListile> createState() => _specialListileState();
}

class _specialListileState extends State<_specialListile> {
  bool isHide = true;

  void toogleHide() {
    setState(() {
      isHide = !isHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text('Username', style: theme.textTheme.bodySmall),
      subtitle: Text(
        isHide && widget.withHide ? '' : 'Username',
        style: theme.textTheme.bodyMedium,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.withHide
              ? IconButton(
                  onPressed: toogleHide,
                  icon: Icon(
                    isHide ? AppIcon.openEyeIcon : AppIcon.closedEyeIcon,
                  ),
                )
              : SizedBox(),
          IconButton(onPressed: () {}, icon: Icon(AppIcon.copyIcon)),
        ],
      ),
    );
  }
}
