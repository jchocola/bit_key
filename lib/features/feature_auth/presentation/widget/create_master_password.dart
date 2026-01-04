import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
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
            CustomTextfield(
              controller: masterPasswordController,
              hintText: 'Master Password',
              withEye: true,
              obscure: true,
            ),

            CustomTextfield(
              controller: confirmMasterPasswordController,
              hintText: 'Confirm Master Password',
              withEye: true,
              obscure: true,
            ),

            Text(
              'Please create a master password for your vault.',
              style: theme.textTheme.bodySmall,
            ),
            Text(
              'Your master password is used to encrypt and decrypt your data. Make sure to keep it safe and do not share it with anyone.',
              style: theme.textTheme.bodySmall,
            ),

            Text('You cant change this masterkey . Please ', style: theme.textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}
