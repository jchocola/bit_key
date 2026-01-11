import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/search_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/view_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchedWidget extends StatelessWidget {
  const SearchedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchBlocState>(
      builder: (context, state) {
        if (state is SearchBlocState_searching) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppConstant.appPadding,
              children: [

                Text(context.tr(AppText.found_n_results,args: [state.totalResults.toString()])),
                _builLoginsList(context, state.logins),
                _buildCardsList(context, state.cards),
                _buildIdentitiesList(context, state.identities),
              ],
            ),
          );
        } else {
          return const Text('Start a search to see results.');
        }
      },
    );
  }

  Widget _builLoginsList(BuildContext context, List<Login> logins) {

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
              BlocProvider.value(
                value: BlocProvider.of<PickedItemBloc>(context),
              ),
              BlocProvider.value(value: BlocProvider.of<LoginsBloc>(context)),
              BlocProvider.value(value: BlocProvider.of<BinBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<NoFoldersBloc>(context),
              ),
              BlocProvider.value(value: BlocProvider.of<FoldersBloc>(context)),
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
    return ListView.builder(
      
      shrinkWrap: true,
      itemCount: logins.length,
      itemBuilder: (context, index) {
        final login = logins[index];
        return CustomListile(
          onTap: () => _onLoginTapped(login: login),
          icon: AppIcon.loginIcon,
          title: login.itemName,
          subTitle: login.login,
        );
      },
    );
  }

  Widget _buildCardsList(BuildContext context, List<Card> cards) {
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
               BlocProvider.value(
                          value: BlocProvider.of<BinBloc>(context),
                        ),
                BlocProvider.value(
                          value: BlocProvider.of<NoFoldersBloc>(context),
                        ),   
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

    return ListView.builder(
      shrinkWrap: true,
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return CustomListile(
          onTap: () => _onCardTapped(card: card),
          icon: AppIcon.cardIcon,
          title: card.itemName ,
          subTitle: card.cardHolderName ?? '',
        );
      },
    );
  }

  Widget _buildIdentitiesList(BuildContext context, List identities) {
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
              BlocProvider.value(
                value: BlocProvider.of<PickedItemBloc>(context),
              ),
              BlocProvider.value(
                value: BlocProvider.of<IdentitiesBloc>(context),
              ),
              BlocProvider.value(value: BlocProvider.of<BinBloc>(context)),
              BlocProvider.value(
                value: BlocProvider.of<NoFoldersBloc>(context),
              ),
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: identities.length,
      itemBuilder: (context, index) {
        final identity = identities[index];
        return CustomListile(
          onTap: () => _onIdentityTapped(identity: identity),
          icon: AppIcon.identityIcon,
          title: identity.itemName ?? '',
          subTitle: identity.firstName ?? '',
        );
      },
    );
  }
}
