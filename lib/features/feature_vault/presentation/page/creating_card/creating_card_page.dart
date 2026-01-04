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
                    child: Text('Cancel', style: theme.textTheme.bodyMedium),
                  ),
                  Text('New card', style: theme.textTheme.titleMedium),

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

              Divider(),

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

              Text('Card Details'),
              CustomTextfield(
                controller: cardHolderNameController,
                hintText: 'Cardholder name 🔒',
              ),
              CustomTextfield(
                inputType: TextInputType.number,
                controller: cardNumberController,
                hintText: 'Number 🔒',
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: AppConstant.appPadding,
                children: [
                  PopupMenuButton(
                    child: Text(brand ?? 'Brand'),
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
                          : 'Exp. month',
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
                hintText: 'Expiration year 🔒',
              ),

              CustomTextfield(
                inputType: TextInputType.number,
                controller: secCodeController,
                hintText: 'Security code 🔒',
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
