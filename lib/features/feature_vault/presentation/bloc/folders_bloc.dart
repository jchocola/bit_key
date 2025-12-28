// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';
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

  final String? selectedFolder;

  FoldersBlocLoaded({required this.folders, this.selectedFolder});

  @override
  List<Object?> get props => [folders, selectedFolder];



  FoldersBlocLoaded copyWith({
    List<String>? folders,
    String? selectedFolder,
  }) {
    return FoldersBlocLoaded(
      folders: folders ?? this.folders,
      selectedFolder: selectedFolder?? this.selectedFolder,
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
  FoldersBloc({required this.folderRepository}) : super(FoldersBlocInit()) {
    ///
    /// LOAD FOLDERS
    ///
    on<FoldersBlocEvent_loadFolders>((event, emit) async {
      logger.d('Load folder');
      try {
        final folders = await folderRepository.getAllFolder();
        logger.i('Folders : ${folders.length}');
        emit(FoldersBlocLoaded(folders: folders));
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
  }
}
