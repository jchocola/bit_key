import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class DeleteAllDataConfirm extends StatefulWidget {
  const DeleteAllDataConfirm({super.key, this.onConfirmPressed});
  final void Function()? onConfirmPressed;

  @override
  State<DeleteAllDataConfirm> createState() => _DeleteAllDataConfirmState();
}

class _DeleteAllDataConfirmState extends State<DeleteAllDataConfirm> {
  late TextEditingController _masterKeyController;

  @override
  void initState() {
    super.initState();
    _masterKeyController = TextEditingController();
  }

  @override
  void dispose() {
    _masterKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      settings: LiquidGlassSettings(
        glassColor: AppColor.primary.withOpacity(0.1),
      ),
      shape: LiquidRoundedSuperellipse(borderRadius: AppConstant.appBorder),
      child: AlertDialog(
        title: Text('Do you really want to delete all data?'),

        actionsAlignment: MainAxisAlignment.spaceBetween,
        content: SizedBox.fromSize(
          //size: Size.fromHeight(60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Will delete everything'),
              CustomTextfield(
                hintText: 'Please',
                controller: _masterKeyController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  BlocListener<AuthBloc, AuthBlocState>(
                    listener: (context, state) {
                      if (state is AuthBlocFirstTimeUser) {
                        context.go('/auth');
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          AuthBlocEvent_DELETE_ALL_DATA(
                            masterKey: _masterKeyController.text,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: Text('Confirm'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
