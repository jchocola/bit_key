import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class BigButton extends StatelessWidget {
  const BigButton({super.key, this.title = 'Title', this.onTap, this.color});
  final String title;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return LiquidGlassLayer(
      settings: LiquidGlassSettings(
        glassColor: color ?? AppColor.primary.withOpacity(0.2),
        blur: 5,
      ),
      child: LiquidStretch(
        // settings: LiquidGlassSettings(
        //   glassColor: AppColor.secondary.withOpacity(0.2)
        // ),
        //  shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
        child: LiquidGlass(
          shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              // width: size.width * 0.5,
              padding: EdgeInsets.all(AppConstant.appPadding),
              child: Center(
                child: Text(title, style: theme.textTheme.titleMedium),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
