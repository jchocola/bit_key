import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/vault_page/modal/folders_modal_page.dart';
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
              height: MediaQuery.of(context).size.height * AppConstant.modalPageHeight,
              child: FoldersModalPage(),
            ),
          );
        },
      );
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

              CustomListile(title: 'Folders', onTap: _onFoldersTapped,),

              CustomListile(title: 'Export Data'),

              BigButton(title: 'Clear all data', color: AppColor.error),
            ],
          ),
        ),
      ),
    );
  }
}
