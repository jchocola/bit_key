import 'dart:ffi';

import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_identity/bloc/create_identity_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:bit_key/shared/widgets/error_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CreatingIdentityPage extends StatefulWidget {
  const CreatingIdentityPage({super.key});
  @override
  State<CreatingIdentityPage> createState() => _CreatingIdentityPageState();
}

class _CreatingIdentityPageState extends State<CreatingIdentityPage> {
  late TextEditingController itemNameController;
  late TextEditingController firstNameController;
  late TextEditingController middleNameController;
  late TextEditingController lastNameController;
  late TextEditingController userNameController;
  late TextEditingController companyController;
  late TextEditingController nationalInsuranceNumberController;
  late TextEditingController passportController;
  late TextEditingController licenseNumberController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController address1Controller;
  late TextEditingController address2Controller;
  late TextEditingController address3Controller;
  late TextEditingController cityController;
  late TextEditingController countryController;
  late TextEditingController postcodeController;

  String? folder;

  void _pickFolder({required String value}) {
    if (folder == value) {
      setState(() {
        folder = null;
      });
    } else {
      setState(() {
        folder = value;
      });
    }
  }

  void _onSaveTapped() async {
    try {
      // generate identity
      final identity = Identity(
        id: Uuid().v4(),
        itemName: itemNameController.text,
        folderName: folder,
        firstName: firstNameController.text,
        middleName: middleNameController.text,
        lastName: lastNameController.text,
        userName: userNameController.text,
        company: companyController.text,
        nationalInsuranceNumber: nationalInsuranceNumberController.text,
        passportName: passportController.text,
        licenseNumber: licenseNumberController.text,
        email: emailController.text,
        phone: phoneController.text,
        address1: address1Controller.text,
        address2: address2Controller.text,
        address3: address3Controller.text,
        cityTown: cityController.text,
        country: countryController.text,
        postcode: postcodeController.text,
      );

      logger.e(identity.toString());

      // CREATE IDENTITY
      context.read<CreateIdentityBloc>().add(
        CreateIdentityEvent_createIdentity(identity: identity),
      );

      //POP
      Navigator.pop(context);

      // RELOAD IDENTITES
      context.read<IdentitiesBloc>().add(IdentitiesBlocEvent_loadIdentities());

      // RELOAD NO FOLDERS
      context.read<NoFoldersBloc>().add(NoFoldersBlocEvent_load());

      // RELOAD FOLDERS
      context.read<FoldersBloc>().add(FoldersBlocEvent_loadFolders());
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void initState() {
    super.initState();
    itemNameController = TextEditingController();
    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    userNameController = TextEditingController();
    companyController = TextEditingController();
    nationalInsuranceNumberController = TextEditingController();
    passportController = TextEditingController();
    licenseNumberController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    address1Controller = TextEditingController();
    address2Controller = TextEditingController();
    address3Controller = TextEditingController();
    cityController = TextEditingController();
    countryController = TextEditingController();
    postcodeController = TextEditingController();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    companyController.dispose();
    nationalInsuranceNumberController.dispose();
    passportController.dispose();
    licenseNumberController.dispose();
    emailController.dispose();
    phoneController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    address3Controller.dispose();
    cityController.dispose();
    countryController.dispose();
    postcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: AppBg(
          child: Padding(
            padding: const EdgeInsets.all(AppConstant.appPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //spacing: AppConstant.appPadding,
              children: [
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          context.tr(AppText.cancel),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        context.tr(AppText.new_indetity),
                        style: theme.textTheme.titleMedium,
                      ),

                      BlocListener<CreateIdentityBloc, CreateIdentityState>(
                        listener: (context, state) {
                          if (state is CreateIdentityState_error) {
                            showErrorSnackbar(context, state.error);
                          }
                          if (state is CreateIdentityState_success) {
                            logger.e('success');
                            Navigator.pop(context);
                          }
                        },
                        child: TextButton(
                          onPressed: _onSaveTapped,
                          child: Text(
                            context.tr(AppText.save),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(),

                Expanded(
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      Text(context.tr(AppText.item_details)),
                      Row(
                        spacing: AppConstant.appPadding,
                        children: [
                          Flexible(
                            child: CustomTextfield(
                              controller: itemNameController,
                              hintText: context.tr(AppText.item_name),
                            ),
                          ),

                          BlocBuilder<FoldersBloc, FoldersBlocState>(
                            builder: (context, state) => PopupMenuButton(
                              child: Text(folder ?? context.tr(AppText.folder)),
                              itemBuilder: (context) {
                                if (state is FoldersBlocLoaded) {
                                  return List.generate(state.folders.length, (
                                    index,
                                  ) {
                                    final folder = state.folders[index];
                                    return PopupMenuItem(
                                      child: Text(folder),
                                      onTap: () {
                                        _pickFolder(value: folder);
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

                      Text(context.tr(AppText.personal_detail)),
                      CustomTextfield(
                        controller: firstNameController,
                        hintText: context.tr(AppText.first_name),
                      ),
                      CustomTextfield(
                        controller: middleNameController,
                        hintText: context.tr(AppText.middle_name),
                      ),
                      CustomTextfield(
                        controller: lastNameController,
                        hintText: context.tr(AppText.last_name),
                      ),
                      CustomTextfield(
                        controller: userNameController,
                        hintText: context.tr(AppText.user_name),
                      ),

                      CustomTextfield(
                        controller: companyController,
                        hintText: context.tr(AppText.company),
                      ),

                      Text(context.tr(AppText.identification)),
                      CustomTextfield(
                        controller: nationalInsuranceNumberController,
                        hintText: context.tr(AppText.national_insurance_number),
                      ),

                      CustomTextfield(
                        controller: passportController,
                        hintText: context.tr(AppText.passport_number),
                      ),

                      CustomTextfield(
                        controller: licenseNumberController,
                        hintText: context.tr(AppText.license_number),
                      ),

                      Text(context.tr(AppText.contact_info)),

                      CustomTextfield(
                        controller: emailController,
                        hintText: context.tr(AppText.email),
                      ),

                      CustomTextfield(
                        controller: phoneController,
                        hintText: context.tr(AppText.phone),
                      ),

                      Text(context.tr(AppText.address)),
                      CustomTextfield(
                        controller: address1Controller,
                        hintText: context.tr(AppText.address1),
                      ),
                      CustomTextfield(
                        controller: address2Controller,
                        hintText: context.tr(AppText.address2),
                      ),
                      CustomTextfield(
                        controller: address3Controller,
                        hintText: context.tr(AppText.address3),
                      ),

                      CustomTextfield(
                        controller: cityController,
                        hintText: context.tr(AppText.city_town),
                      ),

                      CustomTextfield(
                        controller: countryController,
                        hintText: context.tr(AppText.country),
                      ),

                      CustomTextfield(
                        controller: postcodeController,
                        hintText: context.tr(AppText.post_code),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
