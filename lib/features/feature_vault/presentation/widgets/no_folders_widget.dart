import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart' show Card;
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/view_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';

class NoFoldersWidget extends StatelessWidget {
  const NoFoldersWidget({super.key});

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
              BlocProvider.value(value: BlocProvider.of<PickedItemBloc>(context))
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
              BlocProvider.value(value: BlocProvider.of<PickedItemBloc>(context))
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
              BlocProvider.value(value: BlocProvider.of<PickedItemBloc>(context))
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

    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<NoFoldersBloc, NoFoldersBlocState>(
          builder: (context, state) => Text(
            state is NoFoldersBlocState_loaded
                ? 'No Folders (${state.total})'
                : '',
          ),
        ),

        ///
        /// Logins
        ///
        BlocBuilder<NoFoldersBloc, NoFoldersBlocState>(
          builder: (context, state) {
            if (state is NoFoldersBlocState_loaded) {
              return Column(
                spacing: AppConstant.appPadding,
                children: List.generate(state.loginsWihtoutFolder.length, (
                  index,
                ) {
                  final login = state.loginsWihtoutFolder[index];
                  return CustomListile(
                    onTap: ()=> _onLoginTapped(login: login),
                    title: login.itemName,
                    icon: AppIcon.loginIcon,
                  );
                }),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

        ///
        /// CARD
        ///
        BlocBuilder<NoFoldersBloc, NoFoldersBlocState>(
          builder: (context, state) {
            if (state is NoFoldersBlocState_loaded) {
              return Column(
                spacing: AppConstant.appPadding,
                children: List.generate(state.cardsWithoutFolder.length, (
                  index,
                ) {
                  final card = state.cardsWithoutFolder[index];
                  return CustomListile(
                      onTap: ()=> _onCardTapped(card: card),
                    title: card.itemName,
                    icon: AppIcon.cardIcon,
                  );
                }),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

        ///
        /// IDENTITY
        ///
        BlocBuilder<NoFoldersBloc, NoFoldersBlocState>(
          builder: (context, state) {
            if (state is NoFoldersBlocState_loaded) {
              return Column(
                spacing: AppConstant.appPadding,
                children: List.generate(state.identitiesWithoutFolder.length, (
                  index,
                ) {
                  final identity = state.identitiesWithoutFolder[index];
                  return CustomListile(
                      onTap: ()=> _onIdentityTapped(identity: identity),
                    title: identity.itemName,
                    icon: AppIcon.identityIcon,
                  );
                }),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
