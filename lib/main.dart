import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/router/app_router_config.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/core/theme/app_theme.dart';
import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/generator_repo.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/name_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/generating_page.dart';
import 'package:bit_key/features/feature_setting/presentation/setting_page.dart';
import 'package:bit_key/features/feature_vault/domain/repo/encryption_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/bin_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/cards_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folder_detail_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/identities_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/logins_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/no_folders_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/picked_item_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/bloc/search_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/my_vault_page.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_card/bloc/create_card_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_card/creating_card_page.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_folder/creating_folder_page.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_identity/bloc/create_identity_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_identity/creating_identity_page.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_login/bloc/create_login_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_login/creating_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassy_real_navbar/glassy_real_navbar.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:logger/web.dart';

final logger = Logger();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DI
  await DI();

  // init local db
  await getIt<LocalDbRepository>().init();

  // run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            secureStorageRepository: getIt<SecureStorageRepository>(),
          )..add(AppBlocEvent_LoadSaltAndHashedMasterKey()),
        ),

        BlocProvider(
          create: (context) =>
              PassGeneratorBloc(passGeneratorRepo: getIt<GeneratorRepo>()),
        ),

        BlocProvider(
          create: (context) =>
              NameGeneratorBloc(generatorRepo: getIt<GeneratorRepo>()),
        ),

        BlocProvider(
          create: (context) => FoldersBloc(
            folderRepository: getIt<FolderRepository>(),
            localDbRepository: getIt<LocalDbRepository>(),
          )..add(FoldersBlocEvent_loadFolders()),
        ),

        BlocProvider(
          create: (context) => CreateLoginBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            encryptionRepository: getIt<EncryptionRepository>(),
            authBloc: context.read<AuthBloc>(),
          ),
        ),

        BlocProvider(
          create: (context) => LoginsBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            encryptionRepository: getIt<EncryptionRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(LoginsBlocEvent_loadLogins()),
        ),

        BlocProvider(
          create: (context) => CardsBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            authBloc: context.read<AuthBloc>(),
            encryptionRepository: getIt<EncryptionRepository>(),
          )..add(CardsBlocEvent_loadCards()),
        ),

        BlocProvider(
          create: (context) => CreateCardBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            encryptionRepository: getIt<EncryptionRepository>(),
            authBloc: context.read<AuthBloc>(),
          ),
        ),

        BlocProvider(
          create: (context) =>
              IdentitiesBloc(localDbRepository: getIt<LocalDbRepository>(),
              encryptionRepository: getIt<EncryptionRepository>(),
              authBloc: context.read<AuthBloc>()
              )
                ..add(IdentitiesBlocEvent_loadIdentities()),
        ),

        BlocProvider(
          create: (context) => CreateIdentityBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            authBloc: context.read<AuthBloc>(),
            encryptionRepository: getIt<EncryptionRepository>(),
          ),
        ),

        BlocProvider(
          create: (context) =>
              NoFoldersBloc(localDbRepository: getIt<LocalDbRepository>())
                ..add(NoFoldersBlocEvent_load()),
        ),

        BlocProvider(
          create: (context) =>
              FolderDetailBloc(localDbRepository: getIt<LocalDbRepository>()),
        ),

        BlocProvider(
          create: (context) =>
              PickedItemBloc(localDbRepository: getIt<LocalDbRepository>()),
        ),

        BlocProvider(
          create: (context) =>
              BinBloc(localDbRepository: getIt<LocalDbRepository>())
                ..add(BinBlocEvent_load()),
        ),
        BlocProvider(
          create: (context) =>
              SearchBloc(localDbRepository: getIt<LocalDbRepository>()),
        ),
      ],

      // child: MainPage(),
      child: MaterialApp.router(
        routerConfig: appRouterConfig,
        title: 'Flutter Demo',
        theme: appTheme,

        // debugShowMaterialGrid: true,
        //  showPerformanceOverlay: true,
        //showSemanticsDebugger: true,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController; // page controller
  int navbarIndex = 0; // navbar index

  void _changePage(int index) {
    setState(() {
      _pageController.jumpToPage(index);
      navbarIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
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
