import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class CustomListile extends StatelessWidget {
  const CustomListile({
    super.key,
    this.icon = Icons.abc,
    this.title = 'Title',
    this.subTitle,
    this.trailingValue = '',
    this.onTap
  });
  final IconData icon;
  final String title;
  final String? subTitle;
  final String trailingValue;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.secondary.withOpacity(0.1),
      ),
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(title),
        subtitle: subTitle != null ?  Text(subTitle ?? '') : null ,
        trailing: Text(trailingValue),
      ),
    );
  }
}



class CustomListile2 extends StatelessWidget {
  const CustomListile2({
    super.key,
    this.icon = Icons.abc,
    this.title = 'Title',
    this.subTitle,
    this.trailingWidget ,
    this.onTap
  });
  final IconData icon;
  final String title;
  final String? subTitle;
  final Widget? trailingWidget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.secondary.withOpacity(0.1),
      ),
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(title),
        subtitle: subTitle != null ?  Text(subTitle ?? '') : null ,
        trailing: trailingWidget,
      ),
    );
  }
}
