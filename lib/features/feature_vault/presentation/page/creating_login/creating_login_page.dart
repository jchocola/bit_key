import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_login/bloc/create_login_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CreatingLoginPage extends StatefulWidget {
  const CreatingLoginPage({super.key});

  @override
  State<CreatingLoginPage> createState() => _CreatingLoginPageState();
}

class _CreatingLoginPageState extends State<CreatingLoginPage> {
  late TextEditingController itemNameController;
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController urlController;

  String? selectedFolder;

  @override
  void initState() {
    super.initState();
    itemNameController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    urlController = TextEditingController();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    urlController.dispose();
    super.dispose();
  }

  void onSaveLoginTapped() {
    try {
      // GENERATE LOGIN
      final Login login = Login(
        id: Uuid().v4(),
        itemName: itemNameController.text,
        login: userNameController.text,
        password: passwordController.text,
        url: urlController.text,
        folderName: selectedFolder
      );
      logger.i(login.toString());
      // create login
      context.read<CreateLoginBloc>().add(
        CreateLoginBlocEvent_createLogin(login: login),
      );

      // pop
      Navigator.pop(context);
    } catch (e) {
      logger.e(e);
    }
  }

  void _pickFolder({required String folder}) {
    if (selectedFolder == folder) {
      setState(() {
        selectedFolder = null;
      });
    } else {
      setState(() {
        selectedFolder = folder;
      });
    }
    logger.d(selectedFolder);
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

                  BlocListener<CreateLoginBloc, CreateLoginBlocState>(
                    listener: (context, state) {
                      if (state is CreateLoginBlocState_error) {
                        logger.e('error');
                      }
                      if (state is CreateLoginBlocState_success) {
                        logger.e('success');
                        Navigator.pop(context);
                      }
                    },
                    child: TextButton(
                      onPressed: onSaveLoginTapped,
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
                    controller: itemNameController,
                    hintText: 'Item name (required)',
                  ),

                
                  BlocBuilder<FoldersBloc, FoldersBlocState>(
                    builder: (context, state) => PopupMenuButton(
                      child: Text(selectedFolder ?? 'None'),
                      itemBuilder: (context) {
                        if (state is FoldersBlocLoaded) {
                          return List.generate(state.folders.length, (index) {
                            final folder = state.folders[index];

                            return PopupMenuItem(
                              child: Text(folder),
                              onTap: () {
                                _pickFolder(folder: folder);
                              },
                            );
                          });
                        } else {
                          return [];
                        }
                      },
                    ),
                  ),
                ],
              ),

              Text('Login Credentials'),
              CustomTextfield(
                controller: userNameController,
                hintText: 'Username 🔒',
              ),
              CustomTextfield(
                controller: passwordController,
                withEye: true,
                obscure: true,
                hintText: 'Password 🔒',
              ),
              CustomTextfield(
                controller: urlController,
                hintText: 'Website (URI) 🔒',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
