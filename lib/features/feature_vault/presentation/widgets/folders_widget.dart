import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/folder_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
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
                Text('Folders'),
                ...List.generate(state.folders.length, (index) {
                  return CustomListile(
                    title: state.folders[index],
                    icon: AppIcon.folderIcon,
                    trailingValue: '0',
                    onTap: () {
                      // set selected folder
                      context.read<FoldersBloc>().add(
                        FolderBlocEvent_selectFolder(
                          folderName: state.folders[index],
                        ),
                      );

                      // show modal sheet
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (modalContext) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * AppConstant.modalPageHeight,
                            child: BlocProvider.value(
                              value: BlocProvider.of<FoldersBloc>(context),
                              child: FolderInfoPage()),
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
