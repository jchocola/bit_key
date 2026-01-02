import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_vault/presentation/bin_page.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart'
    show LoginsBloc;
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BinWidget extends StatelessWidget {
  const BinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void onBinTapped() {
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
                BlocProvider.value(value: BlocProvider.of<BinBloc>(context)),
                BlocProvider.value(
                  value: BlocProvider.of<PickedItemBloc>(context),
                ),
                BlocProvider.value(value: BlocProvider.of<LoginsBloc>(context)),
                BlocProvider.value(value: BlocProvider.of<CardsBloc>(context)),
                BlocProvider.value(
                  value: BlocProvider.of<IdentitiesBloc>(context),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<FoldersBloc>(context),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<NoFoldersBloc>(context),
                ),
              ],
              child: BinPage(),
            ),
          );
        },
      );
    }

    return Column(
      spacing: AppConstant.appPadding,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bin'),
        BlocBuilder<BinBloc, BinBlocState>(
          builder: (context, state) => CustomListile(
            onTap: onBinTapped,
            icon: AppIcon.deleteIcon,
            title: 'Bin',
            trailingValue: state is BinBlocState_loaded
                ? state.totalCount.toString()
                : '',
          ),
        ),
      ],
    );
  }
}
