import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/icon/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class PassGeneratorParameters extends StatelessWidget {
  const PassGeneratorParameters({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: Column(
        children: [
          ListTile(
            leading: Text('Length'),
            title: Slider.adaptive(value: 0.3, onChanged: (value) {}),
            trailing: Text('5'),
          ),

          const Divider(),

          ListTile(
            leading: Text('A-Z'),

            trailing: Switch.adaptive(value: true, onChanged: (val) {}),
          ),

          const Divider(),

          ListTile(
            leading: Text('a-z'),

            trailing: Switch.adaptive(value: true, onChanged: (val) {}),
          ),

          const Divider(),

          ListTile(
            leading: Text('0-9'),

            trailing: Switch.adaptive(value: true, onChanged: (val) {}),
          ),

          const Divider(),

          ListTile(
            leading: Text('!@#%&*'),

            trailing: Switch.adaptive(value: false, onChanged: (val) {}),
          ),

          const Divider(),

          ListTile(
            leading: Text('Minimum numbers'),

            trailing: _qtyWidget()
          ),

          const Divider(),

          ListTile(
            leading: Text('Minimum special'),

            trailing: _qtyWidget()
          ),
        ],
      ),
    );
  }
}

class _qtyWidget extends StatelessWidget {
  const _qtyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: () {}, icon: Icon(AppIcon.removeIcon)),
        Text('1'),
        IconButton(onPressed: () {}, icon: Icon(AppIcon.addIcon)), 
        ],
    );
  }
}
