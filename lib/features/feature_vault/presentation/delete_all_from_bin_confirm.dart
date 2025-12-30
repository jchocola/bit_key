import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class DeleteAllFromBinConfirm extends StatelessWidget {
  const DeleteAllFromBinConfirm({super.key, this.onConfirmPressed});
  final void Function()? onConfirmPressed;
  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.primary.withOpacity(0.1),
      ),
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: AlertDialog(
        title: Text('Do you really want to delete all items from the bin?'),
       
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
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: onConfirmPressed,
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
