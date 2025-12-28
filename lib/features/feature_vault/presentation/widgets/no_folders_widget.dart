import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoFoldersWidget extends StatelessWidget {
  const NoFoldersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<NoFoldersBloc,NoFoldersBlocState>(builder:(context,state)=> Text(state is NoFoldersBlocState_loaded ? 'No Folders (${state.total})' :'')),

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
                  return CustomListile(title: login.itemName, icon: AppIcon.loginIcon,);
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
                  final login = state.cardsWithoutFolder[index];
                  return CustomListile(title: login.itemName, icon: AppIcon.cardIcon,);
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
                  final login = state.identitiesWithoutFolder[index];
                  return CustomListile(title: login.itemName, icon: AppIcon.identityIcon,);
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
