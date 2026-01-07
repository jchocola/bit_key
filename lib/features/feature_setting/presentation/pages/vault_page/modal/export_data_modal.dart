import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:flutter/material.dart';

class ExportDataModal extends StatelessWidget {
  const ExportDataModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            spacing: AppConstant.appPadding,
            children: [
              Text('Export Data'),
              BigButton(title: 'Export Pure Data (for human, high risk) .json'),
              BigButton(title: 'Export Encrypted Data (for security/import) .json'),
            ],
          ),
        ),
      ),
    );
  }
}
