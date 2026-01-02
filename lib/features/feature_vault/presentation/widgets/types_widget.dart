import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/search_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/cards_page.dart';
import 'package:bit_key/features/feature_vault/presentation/identify_page.dart';
import 'package:bit_key/features/feature_vault/presentation/logins_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypesWidget extends StatelessWidget {
  const TypesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Types'),

        ///
        /// LOGIN
        ///
        BlocBuilder<LoginsBloc, LoginsBlocState>(
          builder: (context, state) => CustomListile(
            icon: AppIcon.loginIcon,
            title: 'Login',
            onTap: () async {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (modalContext) {
                  return SizedBox(
                    height:
                        MediaQuery.of(context).size.height *
                        AppConstant.modalPageHeight,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<LoginsBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<PickedItemBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<BinBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<NoFoldersBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<FoldersBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<SearchBloc>(context),
                        ),
                      ],
                      child: LoginsPage(),
                    ),
                  );
                },
              );
            },
            trailingValue: state is LoginsBlocState_loaded
                ? state.logins.length.toString()
                : '',
          ),
        ),

        ///
        /// CARDS
        ///
        BlocBuilder<CardsBloc, CardsBlocState>(
          builder: (context, state) => CustomListile(
            icon: AppIcon.cardIcon,
            title: 'Card',
            trailingValue: state is CardsBlocState_loaded
                ? state.cards.length.toString()
                : '',
            onTap: () async {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (modalContext) {
                  return SizedBox(
                    height:
                        MediaQuery.of(context).size.height *
                        AppConstant.modalPageHeight,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<CardsBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<PickedItemBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<BinBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<NoFoldersBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<FoldersBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<SearchBloc>(context),
                        ),
                      ],
                      child: CardsPage(),
                    ),
                  );
                },
              );
            },
          ),
        ),

        ///
        /// IDENTITIES
        ///
        BlocBuilder<IdentitiesBloc, IdentitiesBlocState>(
          builder: (context, state) => CustomListile(
            icon: AppIcon.identityIcon,
            title: 'Identity',
            trailingValue: state is IdentitiesBlocState_loaded
                ? state.identities.length.toString()
                : '',
            onTap: () async {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (modalContext) {
                  return SizedBox(
                    height:
                        MediaQuery.of(context).size.height *
                        AppConstant.modalPageHeight,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<IdentitiesBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<PickedItemBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<BinBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<NoFoldersBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<FoldersBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<SearchBloc>(context),
                        ),
                      ],
                      child: IdentifyPage(),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
