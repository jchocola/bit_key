import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class MasterPasswordInput extends StatelessWidget {
  const MasterPasswordInput({super.key});

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
            Text('Master Password'),
            CustomTextfield(
              withEye: true,
              obscure: true,
            ),
            
            Text('You vault is locked. Please enter your master password to unlock it.', style: theme.textTheme.bodySmall,),
           Text('Your master password is used to encrypt and decrypt your data. Make sure to keep it safe and do not share it with anyone.',style: theme.textTheme.bodySmall),


          ],
        ),
      ),
    );
  }
}
