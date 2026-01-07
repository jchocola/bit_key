// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:bit_key/features/feature_auth/domain/repo/local_auth_repository.dart';
import 'package:bit_key/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bit_key/features/feature_import_export_data/domain/repo/import_export_data_repository.dart';

///
/// EVENT
///
abstract class ExportDataBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExportDataBlocEvent_exportPureData extends ExportDataBlocEvent {}

class ExportDataBlocEvent_exportEncryptedData extends ExportDataBlocEvent {}

///
/// STATE
///
abstract class ExportDataBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExportDataBlocState_initial extends ExportDataBlocState {}

class ExportDataBlocState_error extends ExportDataBlocState {}

class ExportDataBlocState_success extends ExportDataBlocState {}

///
/// BLOC
///
class ExportDataBloc extends Bloc<ExportDataBlocEvent, ExportDataBlocState> {
  final ImportExportDataRepository importExportDataRepository;
  final LocalDbRepository localDBRepository;
  final AuthBloc authBloc;
  final FolderRepository folderRepository;
  ExportDataBloc({
    required this.importExportDataRepository,
    required this.localDBRepository,
    required this.authBloc,
    required this.folderRepository,
  }) : super(ExportDataBlocState_initial()) {
    ///
    /// EXPORT PURE DATA
    ///
    on<ExportDataBlocEvent_exportPureData>((event, emit) async {
      try {
        // get pure
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// EXPORT ENCRYPTED DATA
    ///
    on<ExportDataBlocEvent_exportEncryptedData>((event, emit) async {
      try {
        final authBlocState = authBloc.state;

        if (authBlocState is AuthBlocAuthenticated) {
          // get decrypted data
          final logins = await localDBRepository.getAllLogin();
          final cards = await localDBRepository.getAllCard();
          final identities = await localDBRepository.getAllIdentity();
          final folders = await folderRepository.getAllFolder();

          final masterKey = authBlocState.MASTER_KEY;

          // generate file
          final File file = await importExportDataRepository.generateFile();

          // convert data to string
          final convertedData = await importExportDataRepository
              .convertDataToJsonString(
                logins: logins,
                cards: cards,
                identities: identities,
                masterKey: masterKey,
                folders: folders,
              );

          await importExportDataRepository.exportJsonData(
            dataStr: convertedData,
            file: file,
          );
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
