import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/data/model/login_model.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditLoginPage extends StatefulWidget {
  const EditLoginPage({super.key});

  @override
  State<EditLoginPage> createState() => _EditLoginPageState();
}

class _EditLoginPageState extends State<EditLoginPage> {
  String? selectedFolder;
  late TextEditingController itemNameController;
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController urlController;

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

  void _initAInitialControllerValues() {
    logger.d('Init intitial values');
    final pickedItemBlocState = context.read<PickedItemBloc>().state;

    if (pickedItemBlocState is PickedItemBlocState_loaded) {
      final pickedLogin = pickedItemBlocState.login;
      if (pickedLogin != null) {
        setState(() {
          itemNameController.text = pickedLogin.itemName;
          userNameController.text = pickedLogin.login ?? '';
          passwordController.text = pickedLogin.password ?? '';
          urlController.text = pickedLogin.url ?? '';
          selectedFolder = pickedLogin.folderName;
        });
      }
    }
  }

  void _onSaveTapped() {
    final pickedItemBlocState = context.read<PickedItemBloc>().state;
    if (pickedItemBlocState is PickedItemBlocState_loaded) {
      final pickedLogin = pickedItemBlocState.login;
      if (pickedLogin != null) {
        var loginModel = LoginModel.fromEntity(pickedLogin);

        loginModel =  loginModel.copyWith(
          itemName: itemNameController.text,
          login: userNameController.text,
          password: passwordController.text,
          url: urlController.text,
          folderName: selectedFolder
        );
        logger.f('Edited model : ${loginModel.toString()}');

        context.read<PickedItemBloc>().add(
          PickedItemBlocEvent_editLogin(updatedLogin: loginModel.toEntity()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // init controller
    itemNameController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    urlController = TextEditingController();

    // set a initial value
    _initAInitialControllerValues();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AppBg(
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
                    Text('Edit login', style: theme.textTheme.titleMedium),

                    TextButton(
                      onPressed: _onSaveTapped,
                      child: Text('Save', style: theme.textTheme.bodyMedium),
                    ),
                  ],
                ),

                Divider(),

                Row(
                  spacing: AppConstant.appPadding,
                  children: [
                    CustomTextfield(
                      hintText: 'Item name (required)',
                      controller: itemNameController,
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
                  hintText: 'Username 🔒',
                  controller: userNameController,
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
      ),
    );
  }
}
