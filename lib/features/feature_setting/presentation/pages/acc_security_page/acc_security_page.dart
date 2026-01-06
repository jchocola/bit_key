import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/enum/clean_key_duration.dart';
import 'package:bit_key/core/enum/session_timout.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/bloc/acc_security_bloc.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/widgets/acc_sec_appbar.dart';
import 'package:bit_key/shared/widgets/custom_listile.dart';
import 'package:bit_key/shared/widgets/custom_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccSecurityPage extends StatelessWidget {
  const AccSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstant.appPadding,
            vertical: AppConstant.appPadding,
          ),
          child: BlocBuilder<AccSecurityBloc, AccSecurityBlocState>(
            builder: (context, state) {
              if (state is AccSecurityBlocState_loaded) {
                return Column(
                  spacing: AppConstant.appPadding,
                  children: [
                    AppSecPageAppbar(),
                    SizedBox(height: AppConstant.appPadding),

                    CustomListile2(
                      icon: AppIcon.sessionTimeoutIcon,
                      title: 'Session Timeout',
                      subTitle: state.sessionTimeout.label,
                       trailingWidget: PopupMenuButton(
                        itemBuilder: (context) => List.generate(
                          CLEAN_KEY_DURATION.values.length,
                          (index) {
                            final cleanKeyValue =
                                SESSION_TIMEOUT.values[index];
                            return PopupMenuItem(
                              child: Text(cleanKeyValue.label),
                              onTap: () {
                                context.read<AccSecurityBloc>().add(
                                  AccSecurityBlocEvent_setSessionTimeOut(
                                    value: cleanKeyValue,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    CustomListile2(
                      icon: AppIcon.clearKeyIcon,
                      title: 'Чистка вреенных ключей',
                      subTitle: state.clearKeyDuration.label,
                      trailingWidget: PopupMenuButton(
                        itemBuilder: (context) => List.generate(
                          CLEAN_KEY_DURATION.values.length,
                          (index) {
                            final cleanKeyValue =
                                CLEAN_KEY_DURATION.values[index];
                            return PopupMenuItem(
                              child: Text(cleanKeyValue.label),
                              onTap: () {
                                context.read<AccSecurityBloc>().add(
                                  AccSecurityBlocEvent_setClearKeyDuration(
                                    value: cleanKeyValue,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    CustomListile2(
                      icon: AppIcon.screenShootIcon,
                      title: 'Криншот',
                      subTitle: state.enableScreenShoot ?'Разрешаете сделать скриншот' : 'Запрешаете делать скриншот',
                      trailingWidget: CustomSwitcher(
                        value: state.enableScreenShoot,
                        onChanged: (_) {
                          context.read<AccSecurityBloc>().add(
                            AccSecurityBlocEvent_toogleScreenShoot(),
                          );
                        },
                      ),
                    ),
                    CustomListile2(
                      icon: AppIcon.shakeIcon,
                      title: 'Shake to lock',
                      subTitle: 'Easy to lock you app',
                      trailingWidget: CustomSwitcher(
                        value: state.shakeToLock,
                        onChanged: (_) {
                          context.read<AccSecurityBloc>().add(
                            AccSecurityBlocEvent_toogleShakeToLock(),
                          );
                        },
                      ),
                    ),

                    Text(
                      'Внимание , после очистки временных ключей, потребуется повторный вход во аккаунты. Face ID и Pin Code работать не будут до повторного ввода основных учетных данных.',
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
