// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bit_key/features/feature_import_export_data/domain/repo/import_export_data_repository.dart';
import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/main.dart';

///
/// EVENT
///
abstract class ImportDataBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImportDataBlocEvent_pickFile extends ImportDataBlocEvent {}

class ImportDataBlocEvent_clear extends ImportDataBlocEvent {}

class ImportDataBlocEvent_extractFile extends ImportDataBlocEvent {}

class ImportDataBlocEvent_removeLogin extends ImportDataBlocEvent {
  final int index;
  ImportDataBlocEvent_removeLogin({required this.index});
}

class ImportDataBlocEvent_removeCard extends ImportDataBlocEvent {
  final int index;
  ImportDataBlocEvent_removeCard({required this.index});
}

class ImportDataBlocEvent_removeIdentity extends ImportDataBlocEvent {
  final int index;
  ImportDataBlocEvent_removeIdentity({required this.index});
}

class ImportDataBlocEvent_removeFolder extends ImportDataBlocEvent {
  final int index;
  ImportDataBlocEvent_removeFolder({required this.index});
}

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
    List<Login>? logins,
    List<Card>? cards,
    List<Identity>? identities,
    List<String>? folders,
  }) {
    return ImportDataBlocState_pickedFile(
      file: file ?? this.file,
      logins: logins ?? this.logins,
      cards: cards ?? this.cards,
      identities: identities ?? this.identities,
      folders: folders ?? this.folders,
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

    ///
    /// Extract File
    ///
    on<ImportDataBlocEvent_extractFile>((event, emit) async {
      final currentState = state;

      if (currentState is ImportDataBlocState_pickedFile) {
        try {
          // extract data
          final logins = await importExportDataRepository
              .retrieveLoginsFromFile(file: currentState.file);
          final cards = await importExportDataRepository.retrieveCardsFromFile(
            file: currentState.file,
          );
          final identities = await importExportDataRepository
              .retrieveIdentitiesFromFile(file: currentState.file);

          final folders = await importExportDataRepository
              .retrieveFoldersFromFile(file: currentState.file);

          emit(
            currentState.copyWith(
              logins: logins,
              cards: cards,
              identities: identities,
              folders: folders,
            ),
          );
        } catch (e) {
          logger.e(e);
        }
      } else {
        logger.e('Not picked file');
      }
    });

    ///
    /// REMOVE LOGIN
    ///
    on<ImportDataBlocEvent_removeLogin>((event, emit) {
      final currentState = state;
      if (currentState is ImportDataBlocState_pickedFile) {
        logger.d('Remove login ${event.index}');
        try {
          if (currentState.logins != null) {
            final logins = List<Login>.from(currentState.logins!);
            logins.removeAt(event.index);

            logger.d(logins.length);
            emit(currentState.copyWith(logins: logins));
          }
        } catch (e) {
          logger.e(e);
        }
      }
    });

    ///
    /// REMOVE CARD
    ///
    on<ImportDataBlocEvent_removeCard>((event, emit) {
      final currentState = state;
      if (currentState is ImportDataBlocState_pickedFile) {
        logger.d('Remove card ${event.index}');
        try {
          if (currentState.cards != null) {
            final cards = List<Card>.from(currentState.cards!);
            cards.removeAt(event.index);

            logger.d(cards.length);
            emit(currentState.copyWith(cards: cards));
          }
        } catch (e) {
          logger.e(e);
        }
      }
    });

    ///
    /// REMOVE IDENTITY
    ///
    on<ImportDataBlocEvent_removeIdentity>((event, emit) {
      final currentState = state;
      if (currentState is ImportDataBlocState_pickedFile) {
        logger.d('Remove identity ${event.index}');
        try {
          if (currentState.identities != null) {
            final idetities = List<Identity>.from(currentState.identities!);
            idetities.removeAt(event.index);

            logger.d(idetities.length);
            emit(currentState.copyWith(identities: idetities));
          }
        } catch (e) {
          logger.e(e);
        }
      }
    });

    ///
    /// REMOVE FOLDER
    ///
    on<ImportDataBlocEvent_removeFolder>((event, emit) {
      final currentState = state;
      if (currentState is ImportDataBlocState_pickedFile) {
        logger.d('Remove folder ${event.index}');
        try {
          if (currentState.identities != null) {
            final folders = List<String>.from(currentState.folders!);
            folders.removeAt(event.index);

            logger.d(folders.length);
            emit(currentState.copyWith(folders: folders));
          }
        } catch (e) {
          logger.e(e);
        }
      }
    });
  }
}
