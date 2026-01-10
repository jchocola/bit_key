import 'package:bit_key/core/theme/app_bg.dart';
import 'package:flutter/material.dart';

class EditIdentityPage extends StatelessWidget {
  const EditIdentityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Column(
          children: [
            Text('Edit Identity'),
          ],
        ),
      ),
    );
  }
}
