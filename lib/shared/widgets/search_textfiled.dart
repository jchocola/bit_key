import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class SearchTextfiled extends StatelessWidget {
  const SearchTextfiled({super.key, this.onChanged});

  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppConstant.appPadding,
      children: [
        Icon(AppIcon.searchIcon),
        Flexible(
          child: TextField(
            onChanged: onChanged,
            cursorColor: AppColor.primary,
            mouseCursor: MouseCursor.defer,
            decoration: InputDecoration(
              hoverColor: AppColor.secondary,
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.primary.withOpacity(0.2),
                ),
              ),

              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.primary.withOpacity(0.5)
                )
              ),

              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
