import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class DeleteAllFromBinConfirm extends StatelessWidget {
  const DeleteAllFromBinConfirm({super.key, this.onConfirmPressed});
  final void Function()? onConfirmPressed;
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.primary.withOpacity(0.1),
      ),
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: AlertDialog(
        title: Text(context.tr(AppText.remove_all_from_bin)),
       
        actionsAlignment: MainAxisAlignment.spaceBetween,
        content: SizedBox.fromSize(
          //size: Size.fromHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(context.tr(AppText.cancel),style: theme.textTheme.bodySmall,),
              ),
              ElevatedButton(
                 style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColor.primary)
                ),
                onPressed: onConfirmPressed,
                child: Text(context.tr(AppText.confirm),style: theme.textTheme.bodyMedium,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
