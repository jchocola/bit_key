import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/data/model/identity_model.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditIdentityPage extends StatefulWidget {
  const EditIdentityPage({super.key});

  @override
  State<EditIdentityPage> createState() => _EditIdentityPageState();
}

class _EditIdentityPageState extends State<EditIdentityPage> {
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

  void _setInitialValues() {
    final pickedItemBlocState = context.read<PickedItemBloc>().state;
    if (pickedItemBlocState is PickedItemBlocState_loaded) {
      final pickedIdentity = pickedItemBlocState.identity;

      if (pickedIdentity != null) {
        setState(() {
          itemNameController.text = pickedIdentity.itemName;
          firstNameController.text = pickedIdentity.firstName ?? '';
          middleNameController.text = pickedIdentity.middleName ?? '';
          lastNameController.text = pickedIdentity.lastName ?? '';
          userNameController.text = pickedIdentity.userName ?? '';
          companyController.text = pickedIdentity.company ?? '';
          nationalInsuranceNumberController.text =
              pickedIdentity.nationalInsuranceNumber ?? '';
          passportController.text = pickedIdentity.passportName ?? '';
          licenseNumberController.text = pickedIdentity.licenseNumber ?? '';
          emailController.text = pickedIdentity.email ?? '';
          phoneController.text = pickedIdentity.phone ?? '';
          address1Controller.text = pickedIdentity.address1 ?? '';
          address2Controller.text = pickedIdentity.address2 ?? '';
          address3Controller.text = pickedIdentity.address3 ?? '';
          cityController.text = pickedIdentity.cityTown ?? '';
          countryController.text = pickedIdentity.country ?? '';
          postcodeController.text = pickedIdentity.postcode ?? '';

          folder = pickedIdentity.folderName;
        });
      }
    }
  }

  void _onSaveTapped() {
    final pickedItemBlocState = context.read<PickedItemBloc>().state;
    if (pickedItemBlocState is PickedItemBlocState_loaded) {
      final pickedIdentity = pickedItemBlocState.identity;

      if (pickedIdentity != null) {
        var identityModel = IdentityModel.fromEntity(pickedIdentity);

        identityModel = identityModel.copyWith(
          itemName: itemNameController.text,
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
          folderName: folder,
        );

        context.read<PickedItemBloc>().add(
          PickedItemBloc_Event_editIdentity(
            updatedIdentity: identityModel.toEntity(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // init comtrollers
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

    // set intitial values

    _setInitialValues();
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
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            spacing: AppConstant.appPadding,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel', style: theme.textTheme.bodyMedium),
                    ),
                    Text('Edit Identity', style: theme.textTheme.titleMedium),

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
                        onPressed: _onSaveTapped,
                        child: Text('Save', style: theme.textTheme.bodyMedium),
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
                    Text('Item Details'),
                    Row(
                      spacing: AppConstant.appPadding,
                      children: [
                        CustomTextfield(
                          controller: itemNameController,
                          hintText: 'Item name (required)',
                        ),

                        BlocBuilder<FoldersBloc, FoldersBlocState>(
                          builder: (context, state) => PopupMenuButton(
                            child: Text(folder ?? 'Folder'),
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

                    Text('Personal Details'),
                    CustomTextfield(
                      controller: firstNameController,
                      hintText: 'First name',
                    ),
                    CustomTextfield(
                      controller: middleNameController,
                      hintText: 'Middle name',
                    ),
                    CustomTextfield(
                      controller: lastNameController,
                      hintText: 'Last name',
                    ),
                    CustomTextfield(
                      controller: userNameController,
                      hintText: 'Username 🔒',
                    ),

                    CustomTextfield(
                      controller: companyController,
                      hintText: 'Company 🔒',
                    ),

                    Text('Identification'),
                    CustomTextfield(
                      controller: nationalInsuranceNumberController,
                      hintText: 'National Insurance number 🔒',
                    ),

                    CustomTextfield(
                      controller: passportController,
                      hintText: 'Passport number 🔒',
                    ),

                    CustomTextfield(
                      controller: licenseNumberController,
                      hintText: 'License number 🔒',
                    ),

                    Text('Contact info'),

                    CustomTextfield(
                      controller: emailController,
                      hintText: 'Email 🔒',
                    ),

                    CustomTextfield(
                      controller: phoneController,
                      hintText: 'Phone 🔒',
                    ),

                    Text('Address'),
                    CustomTextfield(
                      controller: address1Controller,
                      hintText: 'Address 1 🔒',
                    ),
                    CustomTextfield(
                      controller: address2Controller,
                      hintText: 'Address 2 🔒',
                    ),
                    CustomTextfield(
                      controller: address3Controller,
                      hintText: 'Address 3 🔒',
                    ),

                    CustomTextfield(
                      controller: cityController,
                      hintText: 'City/Town',
                    ),

                    CustomTextfield(
                      controller: countryController,
                      hintText: 'Country',
                    ),

                    CustomTextfield(
                      controller: postcodeController,
                      hintText: 'Postcode',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
