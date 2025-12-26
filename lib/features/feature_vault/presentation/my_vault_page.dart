import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/features/feature_vault/presentation/widgets/bin_widget.dart';
import 'package:bit_key/features/feature_vault/presentation/widgets/folders_widget.dart';
import 'package:bit_key/features/feature_vault/presentation/widgets/no_folders_widget.dart';
import 'package:bit_key/features/feature_vault/presentation/widgets/types_widget.dart';
import 'package:bit_key/features/feature_vault/presentation/widgets/vault_page_appbar.dart';
import 'package:flutter/material.dart';

class MyVaultPage extends StatelessWidget {
  const MyVaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VaultPageAppbar(),

          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                spacing: AppConstant.appPadding,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TypesWidget(),
                  FoldersWidget(),
                  NoFoldersWidget(),
                  BinWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
