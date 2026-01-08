import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_bg.dart';
import 'package:bit_key/features/feature_import_export_data/presentation/import_data_bloc.dart';
import 'package:bit_key/shared/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImportDataModal extends StatelessWidget {
  const ImportDataModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppConstant.appPadding,
            children: [
              Text('Import Data'),
              TextButton(
                onPressed: () {
                  context.read<ImportDataBloc>().add(
                    ImportDataBlocEvent_pickFile(),
                  );
                },
                child: Text('1) Pick File'),
              ),

              BlocBuilder<ImportDataBloc, ImportDataBlocState>(
                builder: (context, state) {
                  if (state is ImportDataBlocState_pickedFile) {
                    return Text(state.file.path);
                  } else {
                    return SizedBox();
                  }
                },
              ),

              TextButton(onPressed: () {}, child: Text('2) Extract File')),

              Row(
                spacing: AppConstant.appPadding,
                children: [
                  Expanded(child: BigButton(title: 'Cancel')),
                  Expanded(child: BigButton(title: 'Import to exsiting data')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
