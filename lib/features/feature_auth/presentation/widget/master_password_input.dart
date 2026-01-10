import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class MasterPasswordInput extends StatelessWidget {
  const MasterPasswordInput({super.key, this.masterKeyController, this.onFingerPrintTapped});
  final TextEditingController? masterKeyController;
  final void Function()? onFingerPrintTapped;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FakeGlass(
      shape: LiquidRoundedRectangle(borderRadius: AppConstant.appBorder),
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstant.appPadding,
          children: [
            Text(context.tr(AppText.masterKey)),
            Row(
              spacing: AppConstant.appPadding,
              children: [
                CustomTextfield(
                  withEye: true,
                  obscure: true,
                  controller: masterKeyController,
                ),

                IconButton(
                  onPressed: onFingerPrintTapped,
                  icon: Icon(AppIcon.fingerPrintIcon),
                ),
              ],
            ),

            Text(
              'You vault is locked. Please enter your master password to unlock it.',
              style: theme.textTheme.bodySmall,
            ),
            Text(
              'Your master password is used to encrypt and decrypt your data. Make sure to keep it safe and do not share it with anyone.',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
