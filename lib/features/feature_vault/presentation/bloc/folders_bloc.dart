// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:developer';

import 'package:bit_key/core/di/di.dart';
import 'package:bit_key/features/feature_analytic/data/analytics_facade_repo_impl.dart';
import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';

///
/// EVENT
///
abstract class FoldersBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoldersBlocEvent_loadFolders extends FoldersBlocEvent {}

class FoldersBlocEvent_createFolder extends FoldersBlocEvent {
  final String folderName;

  FoldersBlocEvent_createFolder({required this.folderName});
  @override
  List<Object?> get props => [folderName];
}

class FolderBlocEvent_selectFolder extends FoldersBlocEvent {
  final String folderName;
  FolderBlocEvent_selectFolder({required this.folderName});

  @override
  List<Object?> get props => [folderName];
}

class FolderBlocEvent_deleteFolder extends FoldersBlocEvent {
  final String folderName;
  FolderBlocEvent_deleteFolder({required this.folderName});

  @override
  List<Object?> get props => [folderName];
}

///
/// STATE
///
abstract class FoldersBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoldersBlocInit extends FoldersBlocState {}

class FoldersBlocLoading extends FoldersBlocState {}

class FoldersBlocLoaded extends FoldersBlocState {
  final List<String> folders;
  final List<int> counts;
  final String? selectedFolder;

  FoldersBlocLoaded({
    required this.folders,
    this.selectedFolder,
    required this.counts,
  });

  @override
  List<Object?> get props => [folders, selectedFolder, counts];

  FoldersBlocLoaded copyWith({
    List<String>? folders,
    String? selectedFolder,
    List<int>? counts,
  }) {
    return FoldersBlocLoaded(
      folders: folders ?? this.folders,
      selectedFolder: selectedFolder ?? this.selectedFolder,
      counts: counts ?? this.counts,
    );
  }
}

class FoldersBlocError extends FoldersBlocState {}

class FoldersBlocSuccess extends FoldersBlocState {}

///
/// BLOC
///
class FoldersBloc extends Bloc<FoldersBlocEvent, FoldersBlocState> {
  final FolderRepository folderRepository;
  final LocalDbRepository localDbRepository;
  FoldersBloc({required this.folderRepository, required this.localDbRepository})
    : super(FoldersBlocInit()) {
    ///
    /// LOAD FOLDERS
    ///
    on<FoldersBlocEvent_loadFolders>((event, emit) async {
      logger.d('Load folder');
      try {
        // get all folders
        final folders = await folderRepository.getAllFolder();
        logger.i('Folders : ${folders.length}');

        //get counts for every folder
        final List<int> counts = [];
        for (var i in folders) {
          final cardCount = await localDbRepository.getCardsWithFolderName(
            folderName: i,
          );
          final loginCount = await localDbRepository.getLoginsWithFolderName(
            folderName: i,
          );
          final identityCount = await localDbRepository
              .getIdentitiesWithFolderName(folderName: i);

          counts.add(
            cardCount.length + loginCount.length + identityCount.length,
          );
        }

        emit(FoldersBlocLoaded(folders: folders, counts: counts));
      } catch (e) {
        logger.e(e);
        emit(FoldersBlocError());
      }
    });

    ///
    /// CREATE FOLDER
    ///
    on<FoldersBlocEvent_createFolder>((event, emit) async {
      logger.d('Create folder');
      try {
        await folderRepository
            .createNewFolder(folderName: event.folderName)
            .then((_) {
              emit(FoldersBlocSuccess());
            });

        // (analytic) track event CREATE_FOLDER
        unawaited(getIt<AnalyticsFacadeRepoImpl>().trackEvent(AnalyticEvent.CREATE_FOLDER.name));

        add(FoldersBlocEvent_loadFolders());
      } catch (e) {
        logger.e(e);
        emit(FoldersBlocError());
      }
    });

    ///
    /// SELECT FOLDER
    ///
    on<FolderBlocEvent_selectFolder>((event, emit) {
      logger.d(event.folderName);

      final currentState = state;
      if (currentState is FoldersBlocLoaded) {
        emit(currentState.copyWith(selectedFolder: event.folderName));
      }
    });

    ///
    /// DELTE FOLDER
    ///
    on<FolderBlocEvent_deleteFolder>((event, emit) async {
      try {
        await folderRepository.deleteFolder(folderName: event.folderName);

          // (analytic) track event DELETE_FOLDER
        unawaited(getIt<AnalyticsFacadeRepoImpl>().trackEvent(AnalyticEvent.DELETE_FOLDER.name));

        add(FoldersBlocEvent_loadFolders());
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
