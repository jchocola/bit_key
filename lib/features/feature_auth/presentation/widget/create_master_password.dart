import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class CreateMasterPassword extends StatelessWidget {
  const CreateMasterPassword({super.key, this.confirmMasterPasswordController,this.masterPasswordController});
  final TextEditingController? masterPasswordController;
  final TextEditingController? confirmMasterPasswordController;
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
            Flexible(
              child: CustomTextfield(
                controller: masterPasswordController,
                hintText: context.tr(AppText.masterKey),
                withEye: true,
                obscure: true,
              ),
            ),

            Flexible(
              child: CustomTextfield(
                controller: confirmMasterPasswordController,
                hintText: context.tr(AppText.comfirmMasterKey),
                withEye: true,
                obscure: true,
              ),
            ),

            Text(
             context.tr(AppText.please_create_master_key_for_your_vault),
              style: theme.textTheme.bodySmall,
            ),
            Text(
              context.tr(AppText.your_master_key_used_for_to),
              style: theme.textTheme.bodySmall,
            ),

            Text(context.tr(AppText.you_cant_change_this_key), style: theme.textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}
