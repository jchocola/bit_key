// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_import_export_data/presentation/bloc/export_data_bloc.dart';
import 'package:bit_key/features/feature_import_export_data/presentation/import_data_bloc.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/vault_page/modal/confirm_delete_all_data.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/vault_page/modal/export_data_modal.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/vault_page/modal/folders_modal_page.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/vault_page/modal/import_data_modal.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VaultPage extends StatelessWidget {
  const VaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    void _onFoldersTapped() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (modalContext) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProvider.of<FoldersBloc>(context)),
            ],
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                  AppConstant.modalPageHeight,
              child: FoldersModalPage(),
            ),
          );
        },
      );
    }

    void _deleteEveryThingTapped() {
      showDialog(
        context: context,
        builder: (modalContext) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProvider.of<AuthBloc>(context)),
            ],
            child: DeleteAllDataConfirm(),
          );
        },
      );
    }

    void _exportDataTapped() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<ExportDataBloc>(context),
              ),
            ],
            child: ExportDataModal(),
          );
        },
      );
    }

    void _exportImportTapped() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (context) {
          return SizedBox(
            height:
                MediaQuery.of(context).size.height *
                AppConstant.modalPageHeight,
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<ImportDataBloc>(context),
                ),
              ],
              child: ImportDataModal(),
            ),
          );
        },
      ).then((_) {
        context.read<ImportDataBloc>().add(ImportDataBlocEvent_clear());
      });
    }

    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstant.appPadding,
            vertical: AppConstant.appPadding,
          ),
          child: Column(
            spacing: AppConstant.appPadding,
            children: [
              Text('Vault Page'),

              CustomListile(title: 'Folders', onTap: _onFoldersTapped),

              CustomListile(title: 'Export Data', onTap: _exportDataTapped),

              CustomListile(title: 'Import Data', onTap: _exportImportTapped),

              BigButton(
                title: 'Clear all data',
                color: AppColor.error,
                onTap: _deleteEveryThingTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
