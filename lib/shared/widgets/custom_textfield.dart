import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    this.controller,
    this.hintText,
    this.obscure = false,
    this.withEye = false,
  });
  final TextEditingController? controller;
  final String? hintText;
  final bool obscure;
  final bool withEye;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool obscureValue;

  @override
  void initState() {
    super.initState();
    obscureValue = widget.obscure;
  }

  void toogleObscureValue() {
    setState(() {
      obscureValue = !obscureValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Flexible(
      child: TextField(
        controller: widget.controller,
        obscureText: obscureValue,
        cursorColor: AppColor.primary,
        mouseCursor: MouseCursor.defer,
        decoration: InputDecoration(
          hintText: widget.hintText,

          suffixIcon: widget.withEye
              ? IconButton(onPressed: toogleObscureValue, icon: Icon(obscureValue ? AppIcon.closedEyeIcon : AppIcon.openEyeIcon))
              : null,

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
