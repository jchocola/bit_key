import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppBg extends StatelessWidget {
  const AppBg({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox.expand(
      child: Stack(
        children: [
          Container(
            color: Color(0xff1B211A),
            child: Stack(
              children: [
                Positioned(
                  left: -size.width * 0.35,
                  top: -size.width * 0.7,
                  child: Container(
                    width: size.width * 0.9,
                    height: size.width * 0.9,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 100,
                          color: AppColor.primary.withOpacity(0.3),
                        ),
                      ],
                      //border: Border.all(color: AppColor.primary.withOpacity(0.2)),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          
                Positioned(
                  left: -size.width * 0.3,
                  top: -size.width * 0.44,
                  child: Container(
                    width: size.width * 0.9,
                    height: size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primary.withOpacity(0.2)),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          
                Positioned(
                  left: -size.width * 0.1,
                  top: -size.width * 0.65,
                  child: Container(
                    width: size.width * 0.9,
                    height: size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primary.withOpacity(0.2)),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          
                Positioned(
                  right: size.width * 0.1,
                  top: size.height * 0.08,
                  child: Icon(
                    AppIcon.starIcon,
                    size: 60,
                    color: AppColor.primary.withOpacity(0.7),
                  ),
                ),
          
                Positioned(
                  right: size.width * 0.3,
                  top: size.height * 0.15,
                  child: Icon(
                    AppIcon.starIcon,
                    size: 30,
                    color: AppColor.primary.withOpacity(0.7),
                  ),
                ),
          
                Positioned(
                  right: size.width * 0.077,
                  top: size.height * 0.07,
                  child: Container(
                    width: size.width * 0.2,
                    height: size.width * 0.2,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 120, color: AppColor.primary),
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          
                Positioned(
                  right: size.width * 0.3,
                  top: size.height * 0.14,
                  child: Container(
                    width: size.width * 0.1,
                    height: size.width * 0.1,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 90, color: AppColor.primary),
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          
                Positioned(
                  left: -size.width * 0.3,
                  bottom: size.height * 0.2,
                  child: Container(
                    width: size.width * 0.6,
                    height: size.width * 0.6,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          // spreadRadius: 40,
                          blurRadius: 200,
                          color: AppColor.primary.withOpacity(0.7),
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          
                Positioned(
                  left: size.width * 0.3,
                  bottom: -size.height * 0.22,
                  child: Container(
                    width: size.width * 0.8,
                    height: size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primary.withOpacity(0.2)),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          
                Positioned(
                  left: size.width * 0.1,
                  bottom: -size.height * 0.25,
                  child: Container(
                    width: size.width * 0.6,
                    height: size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primary.withOpacity(0.2)),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          
                Positioned(
                  right: size.width * 0.18,
                  bottom: size.height * 0.1,
                  child: Container(
                    width: size.width * 0.1,
                    height: size.width * 0.1,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 60, color: AppColor.primary),
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          
                Positioned(
                  right: size.width * 0.18,
                  bottom: size.height * 0.1,
                  child: Icon(
                    AppIcon.starIcon,
                    size: 50,
                    color: AppColor.primary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          child ?? SizedBox()
        ],
      ),
    );
  }
}
