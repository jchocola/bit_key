import 'dart:async';

import 'package:bit_key/core/app_text/app_text.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart'
    show Card;
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/move_to_bin_confirm.dart';
import 'package:bit_key/features/feature_vault/presentation/page/edit_card/edit_card.dart';
import 'package:bit_key/features/feature_vault/presentation/page/edit_identity/edit_identity.dart';
import 'package:bit_key/features/feature_vault/presentation/page/edit_login/edit_login_page.dart';
import 'package:bit_key/main.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class ViewInfoPage extends StatelessWidget {
  const ViewInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(AppIcon.arrowBackIcon),
                  ),
                  Text(context.tr(AppText.details), style: theme.textTheme.titleMedium),
                  IconButton(onPressed: () {}, icon: Icon(AppIcon.moreIcon)),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<PickedItemBloc, PickedItemBlocState>(
                    builder: (context, state) {
                      if (state is PickedItemBlocState_loaded) {
                        if (state.login != null) {
                          return _buildLogin(context, login: state.login!);
                        }

                        if (state.card != null) {
                          return _buildCard(context, card: state.card!);
                        }

                        if (state.identity != null) {
                          return _buildIdentity(
                            context,
                            identity: state.identity!,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// LOGINS
  ///
  Widget _buildLogin(BuildContext context, {required Login login}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        CustomListile(
          icon: AppIcon.loginIcon,
          onTap: () {},
          title: login.itemName,
          subTitle: login.login,
          trailingValue: login.folderName ?? '',
        ),

        Text(context.tr(AppText.login_credentials)),
        _loginCredentialsInfo(login: login),

        // Text('Created : 9 Nov 2022 , 21:59', style: theme.textTheme.bodySmall),
        // Text(
        //   'Last Edited : 9 Nov 2022 , 21:59',
        //   style: theme.textTheme.bodySmall,
        // ),
        Row(
          spacing: AppConstant.appPadding,
          children: [
            Expanded(
              flex: 1,
              child: BigButton(
                title: context.tr(AppText.delete),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (modalContext) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<PickedItemBloc>(context),
                        ),

                        BlocProvider.value(
                          value: BlocProvider.of<LoginsBloc>(context),
                        ),
                      ],
                      child: MoveToBinConfirm(
                        onConfirmPressed: () async {
                          try {
                            final completer = Completer<void>();

                            // MOVE LOGIN TO BIN
                            context.read<PickedItemBloc>().add(
                              PickedItemBlocEvent_moveLoginToBin(
                                completer: completer,
                              ),
                            );
                            // wait until moved to bin
                            await completer.future;

                            // reload cards
                            context.read<LoginsBloc>().add(
                              LoginsBlocEvent_loadLogins(),
                            );

                            // reload bin
                            context.read<BinBloc>().add(BinBlocEvent_load());

                            // reload no folder
                            context.read<NoFoldersBloc>().add(
                              NoFoldersBlocEvent_load(),
                            );

                            // reload folders
                            context.read<FoldersBloc>().add(
                              FoldersBlocEvent_loadFolders(),
                            );

                            // POP
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } catch (e) {
                            logger.e(e);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: BigButton(
                title: context.tr(AppText.edit),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (modalContext) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: BlocProvider.of<PickedItemBloc>(context),
                          ),
                        ],
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height *
                              AppConstant.modalPageHeight,
                          child: EditLoginPage(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///
  /// CARDS
  ///
  Widget _buildCard(BuildContext context, {required Card card}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        CustomListile(
          icon: AppIcon.cardIcon,
          onTap: () {},
          title: card.itemName,
          subTitle: card.cardHolderName,
          trailingValue: card.folderName ?? '',
        ),

        Text(context.tr(AppText.card_credentials)),
        _cardCredentialsInfo(card: card),

        Row(
          spacing: AppConstant.appPadding,
          children: [
            Expanded(
              flex: 1,
              child: BigButton(
                title: context.tr(AppText.delete),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (modalContext) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<PickedItemBloc>(context),
                        ),

                        BlocProvider.value(
                          value: BlocProvider.of<CardsBloc>(context),
                        ),
                      ],
                      child: MoveToBinConfirm(
                        onConfirmPressed: () async {
                          try {
                            final completer = Completer<void>();
                            // MOVE CARD TO BIN
                            context.read<PickedItemBloc>().add(
                              PickedItemBlocEvent_moveCardToBin(
                                completer: completer,
                              ),
                            );

                            // wait until moved to bin
                            await completer.future;

                            // reload cards
                            context.read<CardsBloc>().add(
                              CardsBlocEvent_loadCards(),
                            );

                            // reload bin
                            context.read<BinBloc>().add(BinBlocEvent_load());

                            // reload no folder
                            context.read<NoFoldersBloc>().add(
                              NoFoldersBlocEvent_load(),
                            );

                            // reload folders
                            context.read<FoldersBloc>().add(
                              FoldersBlocEvent_loadFolders(),
                            );

                            // POP
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } catch (e) {
                            logger.e(e);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: BigButton(
                title: context.tr(AppText.edit),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (modalContext) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: BlocProvider.of<PickedItemBloc>(context),
                          ),
                        ],
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height *
                              AppConstant.modalPageHeight,
                          child: EditCardPage(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///
  /// IDENTITY
  ///
  Widget _buildIdentity(BuildContext context, {required Identity identity}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        CustomListile(
          icon: AppIcon.cardIcon,
          onTap: () {},
          title: identity.itemName,
          subTitle: identity.firstName,
          trailingValue: identity.folderName ?? '',
        ),

        Text(context.tr(AppText.identity_credentials)),

        _identityCredentialsInfo(identity: identity),

        Row(
          spacing: AppConstant.appPadding,
          children: [
            Expanded(
              flex: 1,
              child: BigButton(
                title: context.tr(AppText.delete),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (modalContext) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<PickedItemBloc>(context),
                        ),

                        BlocProvider.value(
                          value: BlocProvider.of<IdentitiesBloc>(context),
                        ),
                      ],
                      child: MoveToBinConfirm(
                        onConfirmPressed: () async {
                          try {
                            final completer = Completer<void>();
                            // MOVE IDENTITY TO BIN
                            context.read<PickedItemBloc>().add(
                              PickedItemBlocEvent_moveIdentityToBin(
                                completer: completer,
                              ),
                            );

                            // wait until moved to bin
                            await completer.future;

                            // reload identities
                            context.read<IdentitiesBloc>().add(
                              IdentitiesBlocEvent_loadIdentities(),
                            );

                            // reload bin
                            context.read<BinBloc>().add(BinBlocEvent_load());

                            // reload no folder
                            context.read<NoFoldersBloc>().add(
                              NoFoldersBlocEvent_load(),
                            );

                            // reload folders
                            context.read<FoldersBloc>().add(
                              FoldersBlocEvent_loadFolders(),
                            );
                            // POP
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } catch (e) {
                            logger.e(e);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: BigButton(
                title: context.tr(AppText.edit),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (modalContext) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: BlocProvider.of<PickedItemBloc>(context),
                          ),
                        ],
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height *
                              AppConstant.modalPageHeight,
                          child: EditIdentityPage(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _loginCredentialsInfo extends StatelessWidget {
  const _loginCredentialsInfo({super.key, this.login});
  final Login? login;
  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: Column(
        children: [
          // login
          _specialListile(
            withHide: false,
            title: context.tr(AppText.user_name),
            value: login?.login,
          ),

          const Divider(),
          // password
          _specialListile(
            withHide: true,
            title: context.tr(AppText.password),
            value: login?.password,
          ),

          const Divider(),
          // password
          _specialListile(withHide: false, title: context.tr(AppText.website), value: login?.url),
        ],
      ),
    );
  }
}

class _cardCredentialsInfo extends StatelessWidget {
  const _cardCredentialsInfo({super.key, this.card});
  final Card? card;
  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: Column(
        children: [
          // number
          _specialListile(
            withHide: false,
            title: context.tr(AppText.card_number),
            value: card?.number,
          ),

          const Divider(),
          // brand
          _specialListile(withHide: false, title: context.tr(AppText.brand), value: card?.brand),

          const Divider(),
          // expMonth / expYear
          Row(
            children: [
              Flexible(
                child: _specialListile(
                  title: context.tr(AppText.exp_month),
                  value: card?.expMonth.toString(),
                ),
              ),

              Flexible(
                child: _specialListile(
                  title: context.tr(AppText.exp_year),
                  value: card?.expYear.toString(),
                ),
              ),
            ],
          ),

          const Divider(),
          _specialListile(
            title: context.tr(AppText.security_code),
            value: card?.secCode.toString(),
            withHide: true,
          ),
        ],
      ),
    );
  }
}

class _identityCredentialsInfo extends StatelessWidget {
  const _identityCredentialsInfo({super.key, this.identity});
  final Identity? identity;
  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr(AppText.personal_detail)),
          // Firstname
          _specialListile(
            withHide: false,
            title: context.tr(AppText.first_name),
            value: identity?.firstName,
          ),

          const Divider(),
          // middle name
          _specialListile(title: context.tr(AppText.middle_name), value: identity?.middleName),

          const Divider(),
          // last name
          _specialListile(title: context.tr(AppText.last_name), value: identity?.lastName),

          const Divider(),
          // user name
          _specialListile(title: context.tr(AppText.user_name_identity), value: identity?.userName),

          const Divider(),
          // Company name
          _specialListile(title: context.tr(AppText.company), value: identity?.company),

          SizedBox(height: AppConstant.appPadding),
          Text(context.tr(AppText.identification)),

          // last name
          _specialListile(
            title: context.tr(AppText.national_insurance_number),
            value: identity?.nationalInsuranceNumber,
            withHide: true,
          ),
          const Divider(),
          // last name
          _specialListile(
            title: context.tr(AppText.passport_number),
            value: identity?.passportName,
            withHide: true,
          ),
          const Divider(),
          // last name
          _specialListile(
            title: context.tr(AppText.license_number),
            value: identity?.licenseNumber,
          ),

          SizedBox(height: AppConstant.appPadding),
          Text(context.tr(AppText.contact_info)),

          // last name
          _specialListile(title: context.tr(AppText.email), value: identity?.email),
          const Divider(),
          // last name
          _specialListile(title: context.tr(AppText.phone), value: identity?.phone),

          SizedBox(height: AppConstant.appPadding),
          Text(context.tr(AppText.address)),
          // last name
          _specialListile(title: context.tr(AppText.address1), value: identity?.address1),

          const Divider(),
          // last name
          _specialListile(title: context.tr(AppText.address2),value: identity?.address2),

          const Divider(),
          // last name
          _specialListile(title: context.tr(AppText.address3), value: identity?.address3),

          const Divider(),
          // last name
          _specialListile(title:context.tr(AppText.city_town), value: identity?.cityTown),

          const Divider(),
          // last name
          _specialListile(title:context.tr(AppText.country), value: identity?.country),
          const Divider(),
          // last name
          _specialListile(title: context.tr(AppText.post_code), value: identity?.postcode),
        ],
      ),
    );
  }
}

class _specialListile extends StatefulWidget {
  const _specialListile({
    super.key,
    this.withHide = false,
    this.title,
    this.value,
  });
  final bool withHide;
  final String? title;
  final String? value;
  @override
  State<_specialListile> createState() => _specialListileState();
}

class _specialListileState extends State<_specialListile> {
  bool isHide = true;

  void toogleHide() {
    setState(() {
      isHide = !isHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(widget.title ?? '', style: theme.textTheme.bodySmall),
      subtitle: Text(
        isHide && widget.withHide ? '' : widget.value ?? '',
        style: theme.textTheme.bodyMedium,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.withHide
              ? IconButton(
                  onPressed: toogleHide,
                  icon: Icon(
                    isHide ? AppIcon.openEyeIcon : AppIcon.closedEyeIcon,
                  ),
                )
              : SizedBox(),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.value ?? ''));
            },
            icon: Icon(AppIcon.copyIcon),
          ),
        ],
      ),
    );
  }
}
