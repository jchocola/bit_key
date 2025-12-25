import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generating_appbar.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generator_password.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/widgets/generator_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratingPage extends StatefulWidget {
  const GeneratingPage({super.key});

  @override
  State<GeneratingPage> createState() => _GeneratingPageState();
}

class _GeneratingPageState extends State<GeneratingPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          GeneratingPageAppbar(),
          Expanded(
            child: BlocListener<PassGeneratorBloc, PassGeneratorBlocState>(
              listenWhen: (previous, current) {
                final prevIndex = previous is PassGeneratorBlocState_state
                    ? previous.pageviewIndex
                    : 0;
                final currIndex = current is PassGeneratorBlocState_state
                    ? current.pageviewIndex
                    : 0;
                return prevIndex != currIndex;
              },

              listener: (context, state) {
                if (state is PassGeneratorBlocState_state) {
                  // Синхронизируем ValueNotifier
                  if (state.pageviewIndex != _pageController.page) {
                    _pageController.jumpToPage(state.pageviewIndex);
                  }
                }
              },

              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  context.read<PassGeneratorBloc>().add(
                    PassGeneratorBlocEvent_changePageViewIndex(index: value),
                  );
                },
                children: [GeneratorPassword(), GeneratorUser()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
