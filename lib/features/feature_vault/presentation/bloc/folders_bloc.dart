import 'dart:developer';

import 'package:bit_key/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_key/features/feature_vault/domain/repo/folder_repository.dart';

///
/// EVENT
///
abstract class FoldersBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoldersBlocEvent_loadFolders extends FoldersBlocEvent {}

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
  FoldersBlocLoaded({required this.folders});
  @override
  List<Object?> get props => [folders];
}

class FoldersBlocError extends FoldersBlocState {}

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
  }
}
