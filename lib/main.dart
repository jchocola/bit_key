import 'package:animate_gradient/animate_gradient.dart';
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/core/theme/app_theme.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/generator_repo.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/name_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/generating_page.dart';
import 'package:bit_key/features/feature_setting/presentation/setting_page.dart';
import 'package:bit_key/features/feature_vault/presentation/my_vault_page.dart';
import 'package:bit_key/features/feature_vault/presentation/widgets/vault_page_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassy_real_navbar/glassy_real_navbar.dart';
import 'package:liquid_glass_renderer/experimental.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:logger/web.dart';

final logger = Logger();
Future<void> main() async {
  await DI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PassGeneratorBloc(passGeneratorRepo: getIt<GeneratorRepo>()),
          ),

          BlocProvider(
            create: (context) =>
                NameGeneratorBloc(generatorRepo: getIt<GeneratorRepo>()),
          ),
        ],
        child: MainPage(),
      ),
      // debugShowMaterialGrid: true,
      //  showPerformanceOverlay: true,
      //showSemanticsDebugger: true,
      debugShowCheckedModeBanner: false,
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
                                      PopupMenuItem(child: Text('Login')),
                                       PopupMenuItem(child: Text('Card')),
                                        PopupMenuItem(child: Text('Identity')),
                                         PopupMenuItem(child: Text('Folder')),
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
