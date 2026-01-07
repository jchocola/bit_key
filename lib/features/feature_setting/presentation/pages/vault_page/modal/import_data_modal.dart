import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:flutter/material.dart';

class ImportDataModal extends StatelessWidget {
  const ImportDataModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppConstant.appPadding,
            children: [
              Text('Import Data'),
              TextButton(onPressed: () {}, child: Text('1) Pick File')),

              TextButton(onPressed: () {}, child: Text('2) Extract File')),

             Row(
              spacing: AppConstant.appPadding,
              children: [
                Expanded(child: BigButton(title: 'Cancel',)),
                Expanded(child: BigButton(title: 'Import to exsiting data',))
              ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
