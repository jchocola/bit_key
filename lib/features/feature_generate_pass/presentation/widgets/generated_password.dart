import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class GeneratedPassword extends StatelessWidget {
  const GeneratedPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('hsjkfhsdkjfhsk')),
                IconButton(onPressed: () {}, icon: Icon(AppIcon.generatorIcon)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
