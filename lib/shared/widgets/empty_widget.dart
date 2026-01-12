import 'package:bit_key/core/constants/app_constant.dart';
import 'package:flutter/widgets.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.5;
    return SizedBox(
      height: size,
      width: size,
      child: Image.asset(AppConstant.emptyWidget));
  }
}
