import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/view_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentifyPage extends StatelessWidget {
  const IdentifyPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text('Identifys', style: theme.textTheme.titleMedium),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(AppIcon.cancelIcon),
                  ),
                ],
              ),
              SearchTextfiled(),

              BlocBuilder<IdentitiesBloc, IdentitiesBlocState>(
                builder: (context, state) {
                  if (state is IdentitiesBlocState_loaded) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: AppConstant.appPadding,
                          children: List.generate(state.identities.length, (
                            index,
                          ) {
                            final identity = state.identities[index];
                            return CustomListile(
                              title: identity.itemName,
                              subTitle: identity.firstName,
                              onTap: () =>
                                  _onIdentityTapped(identity: identity),
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
