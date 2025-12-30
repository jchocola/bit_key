import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/delete_all_from_bin_confirm.dart';
import 'package:bit_key/features/feature_vault/presentation/view_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';

class BinPage extends StatelessWidget {
  const BinPage({super.key});

  @override
  Widget build(BuildContext context) {
    void _onCardTapped({required Card card}) {
      // SET PICK CARD
      context.read<PickedItemBloc>().add(
        PickedItemBlocEvent_pickCard(card: card),
      );

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (modalContext) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<PickedItemBloc>(context),
              ),
              BlocProvider.value(value: BlocProvider.of<CardsBloc>(context)),
              BlocProvider.value(value: BlocProvider.of<BinBloc>(context)),
            ],
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                  AppConstant.modalPageHeight,
              child: ViewInfoPage(),
            ),
          );
        },
      );
    }

    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            spacing: AppConstant.appPadding,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bin', style: theme.textTheme.titleMedium),
                  TextButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return DeleteAllFromBinConfirm(
                          onConfirmPressed: () {
                            // context.read<BinBloc>().add(
                            //       BinBlocEvent_deleteAllFromBin(),
                            //     );
                            Navigator.pop(context);
                          },
                        );
                      });
                    },
                    child: Text('Clear all', style: theme.textTheme.bodySmall,),
                  ),
                ],
              ),

              // SearchTextfiled(),
              BlocBuilder<BinBloc, BinBlocState>(
                builder: (context, state) {
                  if (state is BinBlocState_loaded) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: AppConstant.appPadding,
                          children: [
                            ///
                            /// LOGINS
                            ///
                            Column(
                              spacing: AppConstant.appPadding,
                              children: List.generate(state.logins.length, (
                                index,
                              ) {
                                final login = state.logins[index];
                                return CustomListile(
                                  //onTap: () => _onCardTapped(card: card),
                                  title: login.itemName,
                                  subTitle: login.login,
                                  icon: AppIcon.loginIcon,
                                );
                              }),
                            ),

                            ///
                            /// CARDS
                            ///
                            Column(
                              spacing: AppConstant.appPadding,
                              children: List.generate(state.cards.length, (
                                index,
                              ) {
                                final card = state.cards[index];
                                return CustomListile(
                                  onTap: () => _onCardTapped(card: card),
                                  title: card.itemName,
                                  subTitle: card.cardHolderName,
                                  icon: AppIcon.cardIcon,
                                );
                              }),
                            ),

                            ///
                            /// IDENTITIES
                            ///
                            Column(
                              spacing: AppConstant.appPadding,
                              children: List.generate(state.identities.length, (
                                index,
                              ) {
                                final identities = state.identities[index];
                                return CustomListile(
                                  // onTap: () => _onCardTapped(card: card),
                                  title: identities.itemName,
                                  subTitle: identities.firstName,
                                  icon: AppIcon.identityIcon,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
