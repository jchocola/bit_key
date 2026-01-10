import 'package:bit_key/core/theme/app_bg.dart';
import 'package:flutter/material.dart';

class EditCardPage extends StatelessWidget {
  const EditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Column(
          children: [
            Text('Edit Card'),
          ],
        ),
      ),
    );
  }
}
