import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatingFolderPage extends StatefulWidget {
  const CreatingFolderPage({super.key});

  @override
  State<CreatingFolderPage> createState() => _CreatingFolderPageState();
}

class _CreatingFolderPageState extends State<CreatingFolderPage> {
  late TextEditingController folderController;

  @override
  void initState() {
    super.initState();
    folderController = TextEditingController();
  }

  @override
  void dispose() {
    folderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBg(
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: theme.textTheme.bodyMedium),
                ),
                Text('Add Folder', style: theme.textTheme.titleMedium),

                BlocListener<FoldersBloc, FoldersBlocState>(
                  listener: (context, state) {
                    if (state is FoldersBlocError) {
                      logger.e('error');
                    }
                    if (state is FoldersBlocSuccess) {
                      logger.e('success');
                      Navigator.pop(context);
                    }
                  },
                  child: TextButton(
                    onPressed: () {
                      context.read<FoldersBloc>().add(
                        FoldersBlocEvent_createFolder(
                          folderName: folderController.text,
                        ),
                      );
                    },
                    child: Text('Save', style: theme.textTheme.bodyMedium),
                  ),
                ),
              ],
            ),

            CustomTextfield(controller: folderController, hintText: 'Name'),
          ],
        ),
      ),
    );
  }
}
