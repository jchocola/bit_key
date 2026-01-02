// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart'
    show Card;
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/delete_all_from_bin_confirm.dart';
import 'package:bit_key/main.dart';

import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';

class BinPage extends StatelessWidget {
  const BinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void _onItemTapped(Login login) {
      // set a picked login
      context.read<PickedItemBloc>().add(
        PickedItemBlocEvent_pickLogin(login: login),
      );

      // show snackbar 'restore' and 'delete permanently' actions
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        builder: (modalContext) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProvider.of<BinBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<PickedItemBloc>(context),
              ),
            ],
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                  AppConstant.modalPageHeight /
                  4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: AppConstant.appPadding,
                children: [
                  TextButton(
                    onPressed: () async {
                      try {
                        final Completer<void> _completer = Completer<void>();
                        // restore login
                        BlocProvider.of<BinBloc>(context).add(
                          BinBlocEvent_restoreItem(
                            item: login,
                            completer: _completer,
                          ),
                        );

                        // close modal
                        Navigator.pop(modalContext);

                        // wait until done
                        await _completer.future;

                        // reload login
                        context.read<LoginsBloc>().add(
                          LoginsBlocEvent_loadLogins(),
                        );
                        // reload cards and identities
                        context.read<CardsBloc>().add(
                          CardsBlocEvent_loadCards(),
                        );
                        context.read<IdentitiesBloc>().add(
                          IdentitiesBlocEvent_loadIdentities(),
                        );

                        // reload folders
                        context.read<FoldersBloc>().add(
                          FoldersBlocEvent_loadFolders(),
                        );

                        // reload no folders
                        context.read<NoFoldersBloc>().add(
                          NoFoldersBlocEvent_load(),
                        );
                      } catch (e) {
                        logger.e(e);
                      }
                    },
                    child: Text('RESTORE', style: theme.textTheme.bodyMedium),
                  ),

                  TextButton(
                    onPressed: () async {
                      try {
                        final Completer<void> _completer = Completer<void>();
                        // delete login permanently
                        context.read<BinBloc>().add(
                          BinBlocEvent_deletePermantlyItem(
                            item: login,
                            completer: _completer,
                          ),
                        );

                        // close modal
                        Navigator.pop(modalContext);

                        // wait until done
                        await _completer.future;

                        // reload bin
                        context.read<BinBloc>().add(BinBlocEvent_load());
                      } catch (e) {
                        logger.e(e);
                      }
                    },
                    child: Text(
                      'DELETE',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    void _onCardTapped(Card card) {
      // set a picked card
      context.read<PickedItemBloc>().add(
        PickedItemBlocEvent_pickCard(card: card),
      );

      // show snackbar 'restore' and 'delete permanently' actions
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        builder: (modalContext) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProvider.of<BinBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<PickedItemBloc>(context),
              ),
            ],
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                  AppConstant.modalPageHeight /
                  4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: AppConstant.appPadding,
                children: [
                  TextButton(
                    onPressed: () async {
                      try {
                        final Completer<void> _completer = Completer<void>();
                        // restore login
                        BlocProvider.of<BinBloc>(context).add(
                          BinBlocEvent_restoreItem(
                            item: card,
                            completer: _completer,
                          ),
                        );

                        // close modal
                        Navigator.pop(modalContext);

                        // wait until done
                        await _completer.future;

                        // reload login
                        context.read<LoginsBloc>().add(
                          LoginsBlocEvent_loadLogins(),
                        );
                        // reload cards and identities
                        context.read<CardsBloc>().add(
                          CardsBlocEvent_loadCards(),
                        );
                        context.read<IdentitiesBloc>().add(
                          IdentitiesBlocEvent_loadIdentities(),
                        );

                        // reload folders
                        context.read<FoldersBloc>().add(
                          FoldersBlocEvent_loadFolders(),
                        );

                        // reload no folders
                        context.read<NoFoldersBloc>().add(
                          NoFoldersBlocEvent_load(),
                        );
                      } catch (e) {
                        logger.e(e);
                      }
                    },
                    child: Text('RESTORE', style: theme.textTheme.bodyMedium),
                  ),

                  TextButton(
                    onPressed: () async {
                      try {
                        final Completer<void> _completer = Completer<void>();
                        // delete login permanently
                        context.read<BinBloc>().add(
                          BinBlocEvent_deletePermantlyItem(
                            item: card,
                            completer: _completer,
                          ),
                        );

                        // close modal
                        Navigator.pop(modalContext);

                        // wait until done
                        await _completer.future;

                        // reload bin
                        context.read<BinBloc>().add(BinBlocEvent_load());
                      } catch (e) {
                        logger.e(e);
                      }
                    },
                    child: Text(
                      'DELETE',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    void _onIdentityTapped(Identity identity) {
      // set a picked identity
      context.read<PickedItemBloc>().add(
        PickedItemBlocEvent_pickIdentity(identity: identity),
      );

      // show snackbar 'restore' and 'delete permanently' actions
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        builder: (modalContext) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProvider.of<BinBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<PickedItemBloc>(context),
              ),
            ],
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                  AppConstant.modalPageHeight /
                  4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: AppConstant.appPadding,
                children: [
                  TextButton(
                    onPressed: () async {
                      try {
                        final Completer<void> _completer = Completer<void>();
                        // restore login
                        BlocProvider.of<BinBloc>(context).add(
                          BinBlocEvent_restoreItem(
                            item: identity,
                            completer: _completer,
                          ),
                        );

                        // close modal
                        Navigator.pop(modalContext);

                        // wait until done
                        await _completer.future;

                        // reload login
                        context.read<LoginsBloc>().add(
                          LoginsBlocEvent_loadLogins(),
                        );
                        // reload cards and identities
                        context.read<CardsBloc>().add(
                          CardsBlocEvent_loadCards(),
                        );
                        context.read<IdentitiesBloc>().add(
                          IdentitiesBlocEvent_loadIdentities(),
                        );

                        // reload folders
                        context.read<FoldersBloc>().add(
                          FoldersBlocEvent_loadFolders(),
                        );

                        // reload no folders
                        context.read<NoFoldersBloc>().add(
                          NoFoldersBlocEvent_load(),
                        );
                      } catch (e) {
                        logger.e(e);
                      }
                    },
                    child: Text('RESTORE', style: theme.textTheme.bodyMedium),
                  ),

                  TextButton(
                    onPressed: () async {
                      try {
                        final Completer<void> _completer = Completer<void>();
                        // delete login permanently
                        context.read<BinBloc>().add(
                          BinBlocEvent_deletePermantlyItem(
                            item: identity,
                            completer: _completer,
                          ),
                        );

                        // close modal
                        Navigator.pop(modalContext);

                        // wait until done
                        await _completer.future;

                        // reload bin
                        context.read<BinBloc>().add(BinBlocEvent_load());
                      } catch (e) {
                        logger.e(e);
                      }
                    },
                    child: Text(
                      'DELETE',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

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
                      showDialog(
                        context: context,
                        builder: (modalContext) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: BlocProvider.of<BinBloc>(context),
                              ),
                            ],
                            child: DeleteAllFromBinConfirm(
                              onConfirmPressed: () async {
                                final completer = Completer<void>();

                                // delete all from bin
                                BlocProvider.of<BinBloc>(context).add(
                                  BinBlocEvent_deleteAllFromBin(
                                    completer: completer,
                                  ),
                                );

                                // wait until done
                                await completer.future;

                                // close dialog
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Clear all', style: theme.textTheme.bodySmall),
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
                                  onTap: () => _onItemTapped(login),
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
                                  onTap: () => _onCardTapped(card),
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
                                final identity = state.identities[index];
                                return CustomListile(
                                  onTap: () => _onIdentityTapped(identity),
                                  title: identity.itemName,
                                  subTitle: identity.firstName,
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
