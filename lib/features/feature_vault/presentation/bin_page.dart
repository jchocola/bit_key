import 'dart:async';

import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/delete_all_from_bin_confirm.dart';

import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';

class BinPage extends StatelessWidget {
  const BinPage({super.key});

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
            spacing: AppConstant.appPadding,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bin', style: theme.textTheme.titleMedium),
                  TextButton(
                    onPressed: () {
                      showDialog(context: context, builder: (modalContext) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider.value(value: BlocProvider.of<BinBloc>(context)),
                          ],
                          child: DeleteAllFromBinConfirm(
                            onConfirmPressed: () async{
                              final completer = Completer<void>();

                              // delete all from bin
                              BlocProvider.of<BinBloc>(context).add(BinBlocEvent_deleteAllFromBin(completer: completer));

                              // wait until done
                              await completer.future;

                              // close dialog
                              Navigator.pop(context);
                              Navigator.pop(context); 
                            },
                          ),
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
                                //  onTap: () => _onCardTapped(card: card),
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
