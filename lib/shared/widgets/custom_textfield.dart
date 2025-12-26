import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({super.key, this.controller, this.hintText});
  final TextEditingController? controller;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Flexible(
      child: TextField(
        controller: controller,

        cursorColor: AppColor.primary,
        mouseCursor: MouseCursor.defer,
        decoration: InputDecoration(
          hintText: hintText,

          hintStyle: theme.bodySmall,
          hoverColor: AppColor.secondary,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary.withOpacity(0.2)),
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary.withOpacity(0.5)),
          ),

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary),
          ),
        ),
      ),
    );
  }
}
