import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folder_detail_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/folder_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoldersWidget extends StatelessWidget {
  const FoldersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoldersBloc, FoldersBlocState>(
      builder: (context, state) {
        if (state is FoldersBlocLoaded) {
          if (state.folders.isEmpty) {
            return SizedBox();
          } else {
            return Column(
              spacing: AppConstant.appPadding,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.tr(AppText.folders, namedArgs: {'count': state.folders.length.toString()}) ),
                ...List.generate(state.folders.length, (index) {
                  return CustomListile(
                    title: state.folders[index],
                    icon: AppIcon.folderIcon,
                    trailingValue: state.counts[index].toString(),
                    onTap: () {
                      // set selected folder
                      context.read<FoldersBloc>().add(
                        FolderBlocEvent_selectFolder(
                          folderName: state.folders[index],
                        ),
                      );

                      // load folder detail info
                      context.read<FolderDetailBloc>().add(
                        FolderDetailBlocEvent_load(
                          folderName: state.folders[index],
                        ),
                      );

                      // show modal sheet
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (modalContext) {
                          return SizedBox(
                            height:
                                MediaQuery.of(context).size.height *
                                AppConstant.modalPageHeight,
                            child: MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: BlocProvider.of<FoldersBloc>(context),
                                ),
                                BlocProvider.value(
                                  value: BlocProvider.of<FolderDetailBloc>(context),
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
                                  value: BlocProvider.of<LoginsBloc>(context),
                                 ),
                                  BlocProvider.value(
                                  value: BlocProvider.of<CardsBloc>(context),
                                 ),
                                  BlocProvider.value(
                                  value: BlocProvider.of<IdentitiesBloc>(context),
                                 ),
                              ],
                              child: FolderInfoPage(),
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              ],
            );
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}
