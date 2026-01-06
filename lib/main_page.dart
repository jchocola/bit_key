import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/enum/session_timout.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/session_manager.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/generating_page.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/domain/repo/app_security_repository.dart';
import 'package:bit_key/features/feature_setting/presentation/setting_page.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/my_vault_page.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_card/bloc/create_card_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_card/creating_card_page.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_folder/creating_folder_page.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_identity/bloc/create_identity_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_identity/creating_identity_page.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_login/bloc/create_login_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_login/creating_login_page.dart';
import 'package:bit_key/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassy_real_navbar/glassy_real_navbar.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:shake/shake.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  final SessionManager _sessionManager = SessionManager();
  late ShakeDetector _shakeDetector;
  late PageController _pageController; // page controller
  int navbarIndex = 0; // navbar index

  void _lockApp() {
    logger.e('Lock app');

    context.read<AuthBloc>().add(AuthBlocEvent_lockApp());
    context.go('/auth');
  }

  void _changePage(int index) {
    setState(() {
      _pageController.jumpToPage(index);
      navbarIndex = index;
    });
  }

  void initSessionManager() async {
    final sessionTimeOut = await getIt<AppSecurityRepository>()
        .getSessionTimeOutValue();

    _sessionManager.initialize(
      timeout: Duration(minutes: sessionTimeOut.minutes),
      onTimeout: _lockApp,
    );
  }

  void shakeDetectorLogicHandler(ShakeEvent event) async {
    final enableShakeToLock = await getIt<AppSecurityRepository>()
        .getEnableShakeToLockValue();

    if (enableShakeToLock) {
       logger.d('Shake direction: ${event.direction}');
    logger.d('Shake force: ${event.force}');
    logger.d('Shake timestamp: ${event.timestamp}');
      logger.d('User shaked');
      _lockApp();
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
    WidgetsBinding.instance.addObserver(this);
    initSessionManager();
    _sessionManager.recordUserActivity();

    _shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: shakeDetectorLogicHandler,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Приложение ушло в фон
      _sessionManager.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _sessionManager.recordUserActivity();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sessionManager.dispose();
    super.dispose();
  }

  void onCreateFolderTapped(BuildContext parentContext) async {
    showModalBottomSheet(
      context: parentContext,
      // showDragHandle: true,
      useRootNavigator: true,
      //isScrollControlled: true,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<FoldersBloc>(parentContext),
          child: CreatingFolderPage(),
        );
      },
    );
  }

  void onCreateLoginTapped(BuildContext parentContext) async {
    showModalBottomSheet(
      context: parentContext,
      // showDragHandle: true,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (modalContext) {
        return SizedBox(
          height:
              MediaQuery.of(context).size.height * AppConstant.modalPageHeight,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<CreateLoginBloc>(parentContext),
              ),
              BlocProvider.value(
                value: BlocProvider.of<FoldersBloc>(parentContext),
              ),
            ],
            child: CreatingLoginPage(),
          ),
        );
      },
    ).then((_) {
      // RELOAD LOGINS LIST WHEN BOMMTOM MODAL CLOSED
      context.read<LoginsBloc>().add(LoginsBlocEvent_loadLogins());

      // RELOAD NO FOLDERS
      context.read<NoFoldersBloc>().add(NoFoldersBlocEvent_load());

      // RELOAD FOLDERS
      context.read<FoldersBloc>().add(FoldersBlocEvent_loadFolders());
    });
  }

  void onCreateCardTapped(BuildContext parentContext) async {
    showModalBottomSheet(
      context: parentContext,
      // showDragHandle: true,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (modalContext) {
        return SizedBox(
          height:
              MediaQuery.of(context).size.height * AppConstant.modalPageHeight,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<FoldersBloc>(parentContext),
              ),

              BlocProvider.value(
                value: BlocProvider.of<CreateCardBloc>(parentContext),
              ),
            ],
            child: CreatingCardPage(),
          ),
        );
      },
    ).then((_) {
      // RELOAD CARDS
      context.read<CardsBloc>().add(CardsBlocEvent_loadCards());

      // RELOAD NO FOLDERS
      context.read<NoFoldersBloc>().add(NoFoldersBlocEvent_load());

      // RELOAD FOLDERS
      context.read<FoldersBloc>().add(FoldersBlocEvent_loadFolders());
    });
  }

  void onCreateIdentityTapped(BuildContext parentContext) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: BlocProvider.of<FoldersBloc>(parentContext),
            ),
            BlocProvider.value(
              value: BlocProvider.of<CreateIdentityBloc>(parentContext),
            ),

            BlocProvider.value(
              value: BlocProvider.of<IdentitiesBloc>(parentContext),
            ),

            BlocProvider.value(
              value: BlocProvider.of<NoFoldersBloc>(parentContext),
            ),
          ],
          child: CreatingIdentityPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AppBg(
          child: Padding(
            padding: const EdgeInsets.all(AppConstant.appPadding),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: SafeArea(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: _changePage,
                      children: [
                        MyVaultPage(),
                        GeneratingPage(),
                        SettingPage(),
                      ],
                    ),
                  ),
                ),

                /// nav bar
                SafeArea(
                  child: Row(
                    spacing: AppConstant.appPadding,
                    children: [
                      Flexible(
                        child: GlassNavBar.preset(
                          preset: GlassNavBarPreset.minimal,
                          backgroundColor: Colors.transparent,
                          selectedIndex: navbarIndex,
                          onItemSelected: _changePage,
                          blur: 5, // Backdrop blur intensity
                          opacity: 0.1, // Glass tint opacity
                          // refraction: 1.25, // Magnification (1.0 = none)
                          // glassiness: 1.2, // Border shine intensity
                          animationEffect: GlassAnimation.elasticRubber,
                          selectedItemColor: AppColor.primary,
                          unselectedItemColor: AppColor.secondary,

                          items: [
                            GlassNavBarItem(
                              icon: AppIcon.vaultIcon,
                              title: 'Home',
                            ),
                            GlassNavBarItem(
                              icon: AppIcon.generatorIcon,
                              title: 'Search',
                            ),
                            GlassNavBarItem(
                              icon: AppIcon.settingIcon,
                              title: 'Profile',
                            ),
                          ],
                        ),
                      ),

                      LiquidGlassLayer(
                        // shape: LiquidRoundedSuperellipse(borderRadius: 20),
                        settings: LiquidGlassSettings(
                          //blur: 5,
                          glassColor: AppColor.secondary.withOpacity(0.1),
                        ),
                        child: LiquidStretch(
                          // shape: LiquidRoundedSuperellipse(borderRadius: 50),
                          child: LiquidGlass(
                            shape: LiquidRoundedSuperellipse(borderRadius: 50),
                            child: SizedBox(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: PopupMenuButton(
                                  child: Icon(AppIcon.addIcon),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text('Login'),
                                        onTap: () {
                                          onCreateLoginTapped(context);
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text('Card'),
                                        onTap: () {
                                          onCreateCardTapped(context);
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text('Identity'),
                                        onTap: () {
                                          onCreateIdentityTapped(context);
                                        },
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          onCreateFolderTapped(context);
                                        },
                                        child: Text('Folder'),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
