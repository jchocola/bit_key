import 'dart:math';

import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/enum/card_brand.dart';
import 'package:bit_key/core/enum/exp_month.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart'
    show Card;
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_card/bloc/create_card_bloc.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:bit_key/shared/widgets/error_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CreatingCardPage extends StatefulWidget {
  const CreatingCardPage({super.key});

  @override
  State<CreatingCardPage> createState() => _CreatingCardPageState();
}

class _CreatingCardPageState extends State<CreatingCardPage> {
  late TextEditingController itemNameController;
  late TextEditingController cardHolderNameController;
  late TextEditingController cardNumberController;
  late TextEditingController secCodeController;
  late TextEditingController expYearController;
  String? brand;
  int? expMonth;
  String? folder;

  @override
  void initState() {
    super.initState();
    itemNameController = TextEditingController();
    cardHolderNameController = TextEditingController();
    cardNumberController = TextEditingController();
    secCodeController = TextEditingController();
    expYearController = TextEditingController();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    cardHolderNameController.dispose();
    cardNumberController.dispose();
    secCodeController.dispose();
    expYearController.dispose();
    super.dispose();
  }

  void _setBrand({required String value}) {
    if (brand == value) {
      setState(() {
        brand = null;
      });
    } else {
      setState(() {
        brand = value;
      });
    }
  }

  void _setFolder({required String value}) {
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

  void _setExpMonth({required int value}) {
    if (expMonth == value) {
      setState(() {
        expMonth = null;
      });
    } else {
      setState(() {
        expMonth = value;
      });
    }
  }

  void _onSaveTapped() {
    try {
      // generate card
      final Card card = Card(
        id: Uuid().v4(),
        itemName: itemNameController.text,
        folderName: folder,
        cardHolderName: cardHolderNameController.text,
        number: cardNumberController.text,
        brand: brand,
        expMonth: expMonth,
        expYear: expYearController.text.isNotEmpty
            ? int.parse(expYearController.text)
            : null,
        secCode: secCodeController.text.isNotEmpty
            ? int.parse(secCodeController.text)
            : null,
      );

      // CREATINF CARD
      context.read<CreateCardBloc>().add(
        CreateCardBlocEvent_createCard(card: card),
      );

      // Pop
      Navigator.of(context).pop();

      logger.d(card.toString());
    } catch (e) {
      logger.e(e);
    }
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
                    child: Text(
                      context.tr(AppText.cancel),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Text(
                    context.tr(AppText.new_card),
                    style: theme.textTheme.titleMedium,
                  ),

                  BlocListener<CreateCardBloc, CreateCardBlocState>(
                    listener: (context, state) {
                      if (state is CreateCardBlocState_error) {
                        showErrorSnackbar(context, state.error);
                      }
                      if (state is FoldersBlocSuccess) {
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

              Divider(),

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
                          return List.generate(state.folders.length, (index) {
                            final folder = state.folders[index];

                            return PopupMenuItem(
                              child: Text(folder),
                              onTap: () {
                                _setFolder(value: folder);
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

              Text(context.tr(AppText.card_details)),
              CustomTextfield(
                controller: cardHolderNameController,
                hintText: context.tr(AppText.card_holder),
              ),
              CustomTextfield(
                inputType: TextInputType.number,
                controller: cardNumberController,
                hintText: context.tr(AppText.card_number),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: AppConstant.appPadding,
                children: [
                  PopupMenuButton(
                    child: Text(brand ?? context.tr(AppText.brand)),
                    itemBuilder: (context) {
                      return List.generate(CardBrand.values.length, (index) {
                        final value = CardBrand.values[index];
                        return PopupMenuItem(
                          child: Text(value.name),
                          onTap: () {
                            _setBrand(value: value.name);
                          },
                        );
                      });
                    },
                  ),

                  PopupMenuButton(
                    child: Text(
                      expMonth != null
                          ? ExpMonthToString(index: expMonth!)
                          : context.tr(AppText.exp_month),
                    ),
                    itemBuilder: (context) {
                      return List.generate(ExpMonth.values.length, (index) {
                        return PopupMenuItem(
                          onTap: () {
                            _setExpMonth(value: index);
                          },
                          child: Text(ExpMonthToString(index: index)),
                        );
                      });
                    },
                  ),
                ],
              ),
              CustomTextfield(
                inputType: TextInputType.number,
                controller: expYearController,
                hintText: context.tr(AppText.exp_year),
              ),

              CustomTextfield(
                inputType: TextInputType.number,
                controller: secCodeController,
                hintText: context.tr(AppText.security_code),
                withEye: true,
                obscure: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
