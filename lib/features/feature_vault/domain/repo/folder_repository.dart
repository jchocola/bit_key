abstract class FolderRepository {
  Future<List<String>> getAllFolder();

  Future<void> createNewFolder({required String folderName});

  Future<void> addListFolder({required List<String> folderList});

  Future<void> deleteFolder({required String folderName});
}
