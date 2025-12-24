import 'package:bit_key/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTextStyle = GoogleFonts.ubuntu();

final appTheme = ThemeData(
  textTheme: TextTheme(
titleMedium: appTextStyle.copyWith(color: AppColor.secondary),

    bodySmall: appTextStyle.copyWith(color: AppColor.secondary.withOpacity(0.5)),
    bodyMedium: appTextStyle.copyWith(color: AppColor.secondary),
    bodyLarge: appTextStyle.copyWith(color: AppColor.secondary),
  ),

  iconTheme: IconThemeData(color: AppColor.secondary),

  dividerTheme: DividerThemeData(color: AppColor.secondary.withOpacity(0.2)),

  textSelectionTheme: TextSelectionThemeData(
    selectionColor: AppColor.primary,
    selectionHandleColor: AppColor.primary,
  ),

  listTileTheme: ListTileThemeData(
    leadingAndTrailingTextStyle: appTextStyle.copyWith(color: AppColor.secondary.withOpacity(0.5)),
    iconColor: AppColor.primary,
    titleTextStyle: appTextStyle.copyWith(color: AppColor.secondary),
    subtitleTextStyle: appTextStyle.copyWith(color: AppColor.secondary.withOpacity(0.5)),
  ),

  switchTheme: SwitchThemeData(
    trackOutlineColor: WidgetStatePropertyAll(AppColor.transparent),
    thumbColor: WidgetStatePropertyAll(AppColor.primary),
    trackColor: WidgetStatePropertyAll(AppColor.secondary.withOpacity(0.1))
  ),


  sliderTheme: SliderThemeData(
    activeTrackColor: AppColor.primary,
    thumbColor: AppColor.primary,
    inactiveTrackColor: AppColor.secondary.withOpacity(0.1)
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColor.secondary.withOpacity(0.1),
    titleTextStyle: appTextStyle.copyWith(color: AppColor.secondary),
  )
);
