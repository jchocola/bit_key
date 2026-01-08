import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/core/router/app_router_config.dart';
import 'package:bit_key/core/theme/app_theme.dart';
import 'package:bit_key/features/feature_auth/domain/repo/local_auth_repository.dart';
import 'package:bit_key/features/feature_auth/domain/repo/secure_storage_repository.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/generator_repo.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/name_generator_bloc.dart';
import 'package:bit_key/features/feature_generate_pass/presentation/bloc/pass_generator_bloc.dart';
import 'package:bit_key/features/feature_import_export_data/domain/repo/import_export_data_repository.dart';
import 'package:bit_key/features/feature_import_export_data/presentation/bloc/export_data_bloc.dart';
import 'package:bit_key/features/feature_import_export_data/presentation/import_data_bloc.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/bloc/acc_security_bloc.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/data/repo/no_screen_shot_repo_impl.dart';
import 'package:bit_key/features/feature_setting/presentation/pages/acc_security_page/domain/repo/app_security_repository.dart';
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
import 'package:bit_key/features/feature_vault/presentation/page/creating_card/bloc/create_card_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_identity/bloc/create_identity_bloc.dart';
import 'package:bit_key/features/feature_vault/presentation/page/creating_login/bloc/create_login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            localAuthRepository: getIt<LocalAuthRepository>(),
            folderRepository: getIt<FolderRepository>(),
            localDbRepository: getIt<LocalDbRepository>(),
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
          create: (context) => IdentitiesBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            encryptionRepository: getIt<EncryptionRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(IdentitiesBlocEvent_loadIdentities()),
        ),

        BlocProvider(
          create: (context) => CreateIdentityBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            authBloc: context.read<AuthBloc>(),
            encryptionRepository: getIt<EncryptionRepository>(),
          ),
        ),

        BlocProvider(
          create: (context) => NoFoldersBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            encryptionRepository: getIt<EncryptionRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(NoFoldersBlocEvent_load()),
        ),

        BlocProvider(
          create: (context) => FolderDetailBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            encryptionRepository: getIt<EncryptionRepository>(),
            authBloc: context.read<AuthBloc>(),
          ),
        ),

        BlocProvider(
          create: (context) =>
              PickedItemBloc(localDbRepository: getIt<LocalDbRepository>()),
        ),

        BlocProvider(
          create: (context) => BinBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            encryptionRepository: getIt<EncryptionRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(BinBlocEvent_load()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            localDbRepository: getIt<LocalDbRepository>(),
            encryptionRepository: getIt<EncryptionRepository>(),
            authBloc: context.read<AuthBloc>(),
          ),
        ),

        BlocProvider(
          create: (context) => AccSecurityBloc(
            appSecurityRepository: getIt<AppSecurityRepository>(),
            noScreenShotRepoImpl: getIt<NoScreenShotRepoImpl>(),
          )..add(AccSecurityBlocEvent_load()),
        ),

        BlocProvider(
          create: (context) => ExportDataBloc(
            importExportDataRepository: getIt<ImportExportDataRepository>(),
            localDBRepository: getIt<LocalDbRepository>(),
            authBloc: context.read<AuthBloc>(),
            folderRepository: getIt<FolderRepository>(),
            encryptionRepository: getIt<EncryptionRepository>(),
          ),
        ),

        BlocProvider(
          create: (context) => ImportDataBloc(
            importExportDataRepository: getIt<ImportExportDataRepository>(),
            localDbRepository: getIt<LocalDbRepository>(),
            folderRepository: getIt<FolderRepository>()
          ),
        ),
      ],

      // child: MainPage(),
      child: MaterialApp.router(
        routerConfig: appRouterConfig,
        title: 'Flutter Demo',
        theme: appTheme,

        // debugShowMaterialGrid: true,
        // showPerformanceOverlay: true,
        //showSemanticsDebugger: true,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
