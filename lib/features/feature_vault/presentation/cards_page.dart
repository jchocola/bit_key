import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/view_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

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
               BlocProvider.value(
                          value: BlocProvider.of<BinBloc>(context),
                        ),
                BlocProvider.value(
                          value: BlocProvider.of<NoFoldersBloc>(context),
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
          child: Column(
            spacing: AppConstant.appPadding,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cards', style: theme.textTheme.titleMedium),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(AppIcon.cancelIcon),
                  ),
                ],
              ),
              SearchTextfiled(),

              BlocBuilder<CardsBloc, CardsBlocState>(
                builder: (context, state) {
                  if (state is CardsBlocState_loaded) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: AppConstant.appPadding,
                          children: List.generate(state.cards.length, (index) {
                            final card = state.cards[index];
                            return CustomListile(
                              onTap: () => _onCardTapped(card: card),
                              title: card.itemName,
                              subTitle: card.cardHolderName,
                            );
                          }),
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
