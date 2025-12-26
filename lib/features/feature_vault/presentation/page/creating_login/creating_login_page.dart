import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatingLoginPage extends StatefulWidget {
  const CreatingLoginPage({super.key});

  @override
  State<CreatingLoginPage> createState() => _CreatingLoginPageState();
}

class _CreatingLoginPageState extends State<CreatingLoginPage> {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text('New login', style: theme.textTheme.titleMedium),

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

              Divider(),

              Row(
                spacing: AppConstant.appPadding,
                children: [
                  CustomTextfield(
                    controller: folderController,
                    hintText: 'Item name (required)',
                  ),

                  PopupMenuButton(
                    child: Text('Folder 1'),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(child: Text('Folder 1')),
                        PopupMenuItem(child: Text('Folder 2')),
                        PopupMenuItem(child: Text('Folder 3')),
                      ];
                    },
                  ),
                ],
              ),

              Text('Login Credentials'),
              CustomTextfield(
                controller: folderController,
                hintText: 'Username',
              ),
              CustomTextfield(
                controller: folderController,
                hintText: 'Password',
              ),
              CustomTextfield(
                controller: folderController,
                hintText: 'Website (URI)',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
