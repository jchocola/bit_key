import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart'
    show Card;
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/delete_confirm.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
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
                  Text('Info Page', style: theme.textTheme.titleMedium),
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

        Text('LOGIN CREDENTIALS'),
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
                title: 'Delete',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteConfirm(),
                  );
                },
              ),
            ),
            Expanded(flex: 3, child: BigButton(title: 'Edit')),
          ],
        ),
      ],
    );
  }

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

        Text('CARD CREDENTIALS'),
        _cardCredentialsInfo(card: card),

        Row(
          spacing: AppConstant.appPadding,
          children: [
            Expanded(
              flex: 1,
              child: BigButton(
                title: 'Delete',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteConfirm(),
                  );
                },
              ),
            ),
            Expanded(flex: 3, child: BigButton(title: 'Edit')),
          ],
        ),
      ],
    );
  }

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

        Text('IDENTITY CREDENTIALS'),

        _identityCredentialsInfo(identity: identity),

        Row(
          spacing: AppConstant.appPadding,
          children: [
            Expanded(
              flex: 1,
              child: BigButton(
                title: 'Delete',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteConfirm(),
                  );
                },
              ),
            ),
            Expanded(flex: 3, child: BigButton(title: 'Edit')),
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
            title: 'Username',
            value: login?.login,
          ),

          const Divider(),
          // password
          _specialListile(
            withHide: true,
            title: 'Password',
            value: login?.password,
          ),

          const Divider(),
          // password
          _specialListile(withHide: false, title: 'URL', value: login?.url),
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
            title: 'Number',
            value: card?.number,
          ),

          const Divider(),
          // brand
          _specialListile(withHide: false, title: 'Brand', value: card?.brand),

          const Divider(),
          // expMonth / expYear
          Row(
            children: [
              Flexible(
                child: _specialListile(
                  title: 'Exp. Month',
                  value: card?.expMonth.toString(),
                ),
              ),

              Flexible(
                child: _specialListile(
                  title: 'Exp. Year',
                  value: card?.expYear.toString(),
                ),
              ),
            ],
          ),

          const Divider(),
          _specialListile(
            title: 'Sec. Code',
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
          Text('Personal Details'),
          // Firstname
          _specialListile(
            withHide: false,
            title: 'First name',
            value: identity?.firstName,
          ),

          const Divider(),
          // middle name
          _specialListile(title: 'Middle name', value: identity?.middleName),

          const Divider(),
          // last name
          _specialListile(title: 'Last name', value: identity?.lastName),

          const Divider(),
          // user name
          _specialListile(title: 'User name', value: identity?.userName),

          const Divider(),
          // Company name
          _specialListile(title: 'Company', value: identity?.company),

            SizedBox(height: AppConstant.appPadding,),
          Text('Identification'),

          // last name
          _specialListile(
            title: 'National Insurance Number',
            value: identity?.nationalInsuranceNumber,
            withHide: true,
          ),
          const Divider(),
          // last name
          _specialListile(title: 'Passport', value: identity?.passportName, withHide: true,),
          const Divider(),
          // last name
          _specialListile(
            title: 'License number',
            value: identity?.licenseNumber,
          ),

           SizedBox(height: AppConstant.appPadding,),
          Text('Contact Info'),

          // last name
          _specialListile(title: 'Email', value: identity?.email),
          const Divider(),
          // last name
          _specialListile(title: 'Phone', value: identity?.phone),


           SizedBox(height: AppConstant.appPadding,),
          Text('Address'),
          // last name
          _specialListile(title: 'Address1', value: identity?.address1),

          const Divider(),
          // last name
          _specialListile(title: 'Address2', value: identity?.address2),

          const Divider(),
          // last name
          _specialListile(title: 'Address3', value: identity?.address3),

          const Divider(),
          // last name
          _specialListile(title: 'City/Town', value: identity?.cityTown),

          const Divider(),
          // last name
          _specialListile(title: 'Country', value: identity?.country),
          const Divider(),
          // last name
          _specialListile(title: 'Postcode', value: identity?.postcode),
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
