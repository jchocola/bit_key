import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/search_bloc.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchedWidget extends StatelessWidget {
  const SearchedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchBlocState>(
      builder: (context, state) {
        if (state is SearchBlocState_searching) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppConstant.appPadding,
            children: [
              Text('Found ${state.totalResults} results:'),
              _builLoginsList(context, state.logins),
              _buildCardsList(context, state.cards),
              _buildIdentitiesList(context, state.identities),
            ],
          );
        } else {
          return const Text('Start a search to see results.');
        }
      },
    );
  }

  Widget _builLoginsList(BuildContext context, List<Login> logins) {
    return ListView.builder(
      
      shrinkWrap: true,
      itemCount: logins.length,
      itemBuilder: (context, index) {
        final login = logins[index];
        return CustomListile(
          icon: AppIcon.loginIcon,
          title: login.itemName,
          subTitle: login.login,
        );
      },
    );
  }

  Widget _buildCardsList(BuildContext context, List<Card> cards) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return CustomListile(
          icon: AppIcon.cardIcon,
          title: card.itemName ,
          subTitle: card.cardHolderName ?? '',
        );
      },
    );
  }

  Widget _buildIdentitiesList(BuildContext context, List identities) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: identities.length,
      itemBuilder: (context, index) {
        final identity = identities[index];
        return CustomListile(
          icon: AppIcon.identityIcon,
          title: identity.itemName ?? '',
          subTitle: identity.firstName ?? '',
        );
      },
    );
  }
}
