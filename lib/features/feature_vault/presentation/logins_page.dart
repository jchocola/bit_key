import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/view_info_page.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:family_bottom_sheet/family_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginsPage extends StatelessWidget {
  const LoginsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              BlocProvider.value(value: BlocProvider.of<PickedItemBloc>(context)),
               BlocProvider.value(value: BlocProvider.of<LoginsBloc>(context)),
              BlocProvider.value(
                          value: BlocProvider.of<BinBloc>(context),
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
                  Text('Logins', style: theme.textTheme.titleMedium),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(AppIcon.cancelIcon),
                  ),
                ],
              ),
              SearchTextfiled(),

              BlocBuilder<LoginsBloc, LoginsBlocState>(
                builder: (context, state) {
                  if (state is LoginsBlocState_loaded) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: AppConstant.appPadding,
                          children: List.generate(state.logins.length, (index) {
                            return CustomListile(
                              onTap: () => _onLoginTapped(login: state.logins[index]),
                              icon: AppIcon.loginIcon,
                              title: state.logins[index].itemName,
                              subTitle: state.logins[index].login,
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
