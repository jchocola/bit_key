import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class CustomListile extends StatelessWidget {
  const CustomListile({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.secondary.withOpacity(0.1)
      ),
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder, ),
      child: ListTile(
        leading: Icon(AppIcon.vaultIcon),
      title: Text('Title'),
      subtitle: Text('Subtitle'),
      trailing: Text('12'),
      
      ));
  }
}
