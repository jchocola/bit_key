// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:bit_key/features/feature_import_export_data/data/repo/import_export_data_repo_impl.dart';
import 'package:bit_key/features/feature_import_export_data/domain/repo/import_export_data_repository.dart';
import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';

///
/// EVENT
///
abstract class ImportDataBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImportDataBlocEvent_pickFile extends ImportDataBlocEvent {}

class ImportDataBlocEvent_clear extends ImportDataBlocEvent {}

///
/// STATE
///
abstract class ImportDataBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImportDataBlocState_initial extends ImportDataBlocState {}

class ImportDataBlocState_pickedFile extends ImportDataBlocState {
  final File file;
  final List<Login>? logins;
  final List<Card>? cards;
  final List<Identity>? identities;
  final List<String>? folders;
  ImportDataBlocState_pickedFile({
    required this.file,
    this.logins,
    this.cards,
    this.identities,
    this.folders,
  });
  @override
  List<Object?> get props => [file, logins, cards, identities, folders];

  ImportDataBlocState_pickedFile copyWith({
    File? file,
    ValueGetter<List<Login>?>? logins,
    ValueGetter<List<Card>?>? cards,
    ValueGetter<List<Identity>?>? identities,
    ValueGetter<List<String>?>? folders,
  }) {
    return ImportDataBlocState_pickedFile(
      file: file ?? this.file,
      logins: logins != null ? logins() : this.logins,
      cards: cards != null ? cards() : this.cards,
      identities: identities != null ? identities() : this.identities,
      folders: folders != null ? folders() : this.folders,
    );
  }
}

///
/// BLOC
///
class ImportDataBloc extends Bloc<ImportDataBlocEvent, ImportDataBlocState> {
  final ImportExportDataRepository importExportDataRepository;
  ImportDataBloc({required this.importExportDataRepository})
    : super(ImportDataBlocState_initial()) {
    ///
    /// PICK FILE
    ///
    on<ImportDataBlocEvent_pickFile>((event, emit) async {
      try {
        final file = await importExportDataRepository.pickeFile();

        if (file != null) {
          emit(ImportDataBlocState_pickedFile(file: file));
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    /// CLEAR
    ///
    on<ImportDataBlocEvent_clear>((event, emit) {
      emit(ImportDataBlocState_initial());
    });
  }
}
