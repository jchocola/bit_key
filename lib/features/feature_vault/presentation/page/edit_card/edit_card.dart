import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/enum/card_brand.dart';
import 'package:bit_key/core/enum/exp_month.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/data/model/card_model.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCardPage extends StatefulWidget {
  const EditCardPage({super.key});

  @override
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  late TextEditingController itemNameController;
  late TextEditingController cardHolderNameController;
  late TextEditingController cardNumberController;
  late TextEditingController secCodeController;
  late TextEditingController expYearController;
  String? brand;
  int? expMonth;
  String? folder;

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

  void _setInitialValues() {
    final pickedItemBlocState = context.read<PickedItemBloc>().state;

    if (pickedItemBlocState is PickedItemBlocState_loaded) {
      final pickedCard = pickedItemBlocState.card;
      if (pickedCard != null) {
        setState(() {
          itemNameController.text = pickedCard.itemName;
          cardHolderNameController.text = pickedCard.cardHolderName ?? '';
          cardNumberController.text = pickedCard.number ?? '';
          secCodeController.text = pickedCard.secCode.toString();
          expYearController.text = pickedCard.expYear.toString();
          brand = pickedCard.brand;
          expMonth = pickedCard.expMonth;
          folder = pickedCard.folderName;
        });
      }
    }
  }

  void _onSaveTapped() {
    final pickedItemBlocState = context.read<PickedItemBloc>().state;
    if (pickedItemBlocState is PickedItemBlocState_loaded) {
      final pickedCard = pickedItemBlocState.card;

      if (pickedCard != null) {
        var cardModel = CardModel.fromEntity(pickedCard);

        cardModel = cardModel.copyWith(
          itemName: itemNameController.text,
          cardHolderName: cardHolderNameController.text,
          number: cardNumberController.text,
          secCode: int.parse(secCodeController.text),
          expYear: int.parse(expYearController.text),
          brand: brand,
          folderName: folder,
          expMonth: expMonth,
        );

        context.read<PickedItemBloc>().add(
          PickedItemBloc_Event_editCard(updatedCard: cardModel.toEntity()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // init controllers
    itemNameController = TextEditingController();
    cardHolderNameController = TextEditingController();
    cardNumberController = TextEditingController();
    secCodeController = TextEditingController();
    expYearController = TextEditingController();

    // set value
    _setInitialValues();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            spacing: AppConstant.appPadding,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text('Edit card', style: theme.textTheme.titleMedium),

                  TextButton(
                    onPressed: _onSaveTapped,
                    child: Text('Save', style: theme.textTheme.bodyMedium),
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
                hintText: 'Expiration year',
              ),

              CustomTextfield(
                inputType: TextInputType.number,
                controller: secCodeController,
                hintText: 'Security code',
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
