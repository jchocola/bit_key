import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folder_detail_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/view_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderInfoPage extends StatelessWidget {
  const FolderInfoPage({super.key});

  @override
  Widget build(BuildContext context) {

     void _onLoginTapped({required Login login}) {
      // SET PICK LOGIN
      context.read<PickedItemBloc>().add(
        PickedItemBlocEvent_pickLogin(login: login),
      );

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (modalContext) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProvider.of<PickedItemBloc>(context)),
              BlocProvider.value(value: BlocProvider.of<LoginsBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<BinBloc>(context),
              ),
              BlocProvider.value(
                value: BlocProvider.of<NoFoldersBloc>(context),
              ),
              BlocProvider.value(value: BlocProvider.of<CardsBloc>(context)),
              BlocProvider.value(value: BlocProvider.of<IdentitiesBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<FoldersBloc>(context),
              ),
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
             BlocProvider.value(value: BlocProvider.of<PickedItemBloc>(context)),
              BlocProvider.value(value: BlocProvider.of<LoginsBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<BinBloc>(context),
              ),
              BlocProvider.value(
                value: BlocProvider.of<NoFoldersBloc>(context),
              ),
              BlocProvider.value(value: BlocProvider.of<CardsBloc>(context)),
              BlocProvider.value(value: BlocProvider.of<IdentitiesBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<FoldersBloc>(context),
              ),
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

      void _onIdentityTapped({required Identity identity}) {
      // SET PICK IDENTITY
      context.read<PickedItemBloc>().add(
        PickedItemBlocEvent_pickIdentity(identity: identity),
      );

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (modalContext) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProvider.of<PickedItemBloc>(context)),
              BlocProvider.value(value: BlocProvider.of<LoginsBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<BinBloc>(context),
              ),
              BlocProvider.value(
                value: BlocProvider.of<NoFoldersBloc>(context),
              ),
              BlocProvider.value(value: BlocProvider.of<CardsBloc>(context)),
              BlocProvider.value(value: BlocProvider.of<IdentitiesBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<FoldersBloc>(context),
              ),
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
          child: BlocBuilder<FoldersBloc, FoldersBlocState>(
            builder: (context, state) {
              if (state is FoldersBlocLoaded) {
                return Column(
                  spacing: AppConstant.appPadding,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.selectedFolder ?? '',
                          style: theme.textTheme.titleMedium,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(AppIcon.cancelIcon),
                        ),
                      ],
                    ),
                    SearchTextfiled(),

                    BlocBuilder<FolderDetailBloc, FolderDetailBlocState>(
                      builder: (context, state) {
                        if (state is FolderDetailBlocState_loaded) {
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
                                    children: List.generate(
                                      state.logins.length,
                                      (index) {
                                        final login = state.logins[index];
                                        return CustomListile(
                                          onTap: ()=> _onLoginTapped(login: login),
                                          title: login.itemName,
                                          icon: AppIcon.loginIcon,
                                        );
                                      },
                                    ),
                                  ),


                                ///
                                /// CARDS
                                ///
                                  Column(
                                    spacing: AppConstant.appPadding,
                                    children: List.generate(
                                      state.cards.length,
                                      (index) {
                                        final card = state.cards[index];
                                        return CustomListile(
                                          onTap: () => _onCardTapped(card: card),
                                          title: card.itemName,
                                          icon: AppIcon.cardIcon,
                                        );
                                      },
                                    ),
                                  ),
                                  

                                  ///
                                  /// IDENTITIES
                                  ///
                                  Column(
                                    spacing: AppConstant.appPadding,
                                    children: List.generate(
                                      state.identities.length,
                                      (index) {
                                        final identity =
                                            state.identities[index];
                                        return CustomListile(
                                          onTap: () => _onIdentityTapped(identity: identity),
                                          title: identity.itemName,
                                          icon: AppIcon.identityIcon,
                                        );
                                      },
                                    ),
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
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
