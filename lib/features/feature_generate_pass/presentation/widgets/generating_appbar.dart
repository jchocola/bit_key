import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:bit_key/shared/widgets/search_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassy_real_navbar/glassy_real_navbar.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class GeneratingPageAppbar extends StatelessWidget {
  const GeneratingPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.secondary.withOpacity(0.1),
        blur: 5,
      ),
      shape: LiquidRoundedSuperellipse(borderRadius: 12),
      child: SizedBox(
        width: double.infinity,

        child: BlocBuilder<PassGeneratorBloc, PassGeneratorBlocState>(
          builder: (context, state) {
            if (state is PassGeneratorBlocState_state) {
              return Container(
                padding: EdgeInsets.all(AppConstant.appPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppConstant.appPadding,
                  children: [
                    Text('Generator'),
                    GlassNavBar(
                      height: 40,
                      // preset: GlassNavBarPreset.gaming,
                      backgroundColor: Colors.transparent,
                      selectedIndex: state.pageviewIndex,
                      onItemSelected: (index) {
                        context.read<PassGeneratorBloc>().add(
                          PassGeneratorBlocEvent_changePageViewIndex(
                            index: index,
                          ),
                        );
                      },
                      blur: 5, // Backdrop blur intensity
                      opacity: 0.1, // Glass tint opacity
                      // refraction: 1.25, // Magnification (1.0 = none)
                      // glassiness: 1.2, // Border shine intensity
                      animationEffect: GlassAnimation.elasticRubber,
                      selectedItemColor: AppColor.primary,
                      unselectedItemColor: AppColor.secondary,

                      items: [
                        GlassNavBarItem(
                          icon: AppIcon.passwordIcon,
                          title: 'Password',
                        ),
                        // GlassNavBarItem(icon: AppIcon.userIcon, title: 'Search'),
                        GlassNavBarItem(
                          icon: AppIcon.userIcon,
                          title: 'Profile',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
