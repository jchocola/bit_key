// ignore_for_file: camel_case_types

import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_import_export_data/presentation/import_data_bloc.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ImportDataModal extends StatelessWidget {
  const ImportDataModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppConstant.appPadding,
            children: [
              Text('Import Data'),
              TextButton(
                onPressed: () {
                  context.read<ImportDataBloc>().add(
                    ImportDataBlocEvent_pickFile(),
                  );
                },
                child: Text('1) Pick File'),
              ),

              BlocBuilder<ImportDataBloc, ImportDataBlocState>(
                builder: (context, state) {
                  if (state is ImportDataBlocState_pickedFile) {
                    return Text(state.file.path);
                  } else {
                    return SizedBox();
                  }
                },
              ),

              TextButton(
                onPressed: () {
                  context.read<ImportDataBloc>().add(
                    ImportDataBlocEvent_extractFile(),
                  );
                },
                child: Text('2) Extract File'),
              ),
              _buildFolders(),
              Divider(),
              _buildLogins(),
              _buildCards(),
              _buildIdentities(),

              Row(
                spacing: AppConstant.appPadding,
                children: [
                  Expanded(
                    child: BigButton(
                      title: 'Cancel',
                      onTap: () {
                        context.pop();
                      },
                    ),
                  ),
                  Expanded(
                    child: BigButton(
                      title: 'Import to exsiting data',
                      onTap: () {
                        context.read<ImportDataBloc>().add(
                          ImportDataBlocEvent_importToExistingData(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildLogins extends StatelessWidget {
  const _buildLogins({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportDataBloc, ImportDataBlocState>(
      builder: (event, state) {
        if (state is ImportDataBlocState_pickedFile) {
          if (state.logins != null) {
            return Column(
              children: List.generate(state.logins!.length, (index) {
                final login = state.logins![index];
                return CustomListile2(
                  title: login.itemName,
                  subTitle: login.login,
                  icon: AppIcon.loginIcon,
                  trailingWidget: IconButton(
                    onPressed: () {
                      context.read<ImportDataBloc>().add(
                        ImportDataBlocEvent_removeLogin(index: index),
                      );
                    },
                    icon: Icon(AppIcon.deleteIcon),
                  ),
                );
              }),
            );
          } else {
            return SizedBox();
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class _buildCards extends StatelessWidget {
  const _buildCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportDataBloc, ImportDataBlocState>(
      builder: (event, state) {
        if (state is ImportDataBlocState_pickedFile) {
          if (state.cards != null) {
            return Column(
              children: List.generate(state.cards!.length, (index) {
                final card = state.cards![index];
                return CustomListile2(
                  title: card.itemName,
                  subTitle: card.cardHolderName,
                  icon: AppIcon.cardIcon,
                  trailingWidget: IconButton(
                    onPressed: () {
                      context.read<ImportDataBloc>().add(
                        ImportDataBlocEvent_removeCard(index: index),
                      );
                    },
                    icon: Icon(AppIcon.deleteIcon),
                  ),
                );
              }),
            );
          } else {
            return SizedBox();
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class _buildIdentities extends StatelessWidget {
  const _buildIdentities({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportDataBloc, ImportDataBlocState>(
      builder: (event, state) {
        if (state is ImportDataBlocState_pickedFile) {
          if (state.identities != null) {
            return Column(
              children: List.generate(state.identities!.length, (index) {
                final identity = state.identities![index];
                return CustomListile2(
                  title: identity.itemName,
                  subTitle: identity.firstName,
                  icon: AppIcon.identityIcon,
                  trailingWidget: IconButton(
                    onPressed: () {
                      context.read<ImportDataBloc>().add(
                        ImportDataBlocEvent_removeIdentity(index: index),
                      );
                    },
                    icon: Icon(AppIcon.deleteIcon),
                  ),
                );
              }),
            );
          } else {
            return SizedBox();
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class _buildFolders extends StatelessWidget {
  const _buildFolders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportDataBloc, ImportDataBlocState>(
      builder: (event, state) {
        if (state is ImportDataBlocState_pickedFile) {
          if (state.folders != null) {
            return Column(
              spacing: AppConstant.appPadding,
              children: List.generate(state.folders!.length, (index) {
                final folder = state.folders![index];
                return CustomListile2(
                  title: folder,

                  icon: AppIcon.identityIcon,
                  trailingWidget: IconButton(
                    onPressed: () {
                      context.read<ImportDataBloc>().add(
                        ImportDataBlocEvent_removeFolder(index: index),
                      );
                    },
                    icon: Icon(AppIcon.deleteIcon),
                  ),
                );
              }),
            );
          } else {
            return SizedBox();
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}
