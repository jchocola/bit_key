import 'package:flutter/material.dart';

class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({super.key,required this.value, this.onChanged});
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(value: value, onChanged: onChanged);
  }
}
