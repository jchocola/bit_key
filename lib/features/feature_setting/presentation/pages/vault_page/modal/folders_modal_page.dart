import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class FoldersModalPage extends StatelessWidget {
  const FoldersModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            children: [
              Text('Folders', style: theme.textTheme.titleMedium),
              _buildFolders(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFolders(BuildContext context) {
    void _showDeletingConfirm({required String folder}) {
      showDialog(
        context: context,
        builder: (context) => _deleteFolderConfirm(
          onConfirmPressed: () {
            context.read<FoldersBloc>().add(
              FolderBlocEvent_deleteFolder(folderName: folder),
            );
            Navigator.pop(context);
          },
        ),
      );
    }

    return BlocBuilder<FoldersBloc, FoldersBlocState>(
      builder: (context, state) {
        if (state is FoldersBlocLoaded) {
          return Column(
            spacing: AppConstant.appPadding,
            children: List.generate(
              state.folders.length,
              (index) => CustomListile2(
                icon: AppIcon.folderIcon,
                title: state.folders[index],
                trailingWidget: IconButton(
                  onPressed: () {
                    _showDeletingConfirm(folder: state.folders[index]);
                  },
                  icon: Icon(AppIcon.deleteIcon),
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class _deleteFolderConfirm extends StatelessWidget {
  const _deleteFolderConfirm({super.key, this.onConfirmPressed});
  final void Function()? onConfirmPressed;
  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.primary.withOpacity(0.1),
      ),
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: AlertDialog(
        title: Text('Do you really want to delete this folder?'),

        actionsAlignment: MainAxisAlignment.spaceBetween,
        content: SizedBox.fromSize(
          //size: Size.fromHeight(60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Items on this folder will not be delete'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: onConfirmPressed,
                    child: Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
