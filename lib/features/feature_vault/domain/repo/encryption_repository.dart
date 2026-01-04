abstract class EncryptionRepository {
  Future<String> encrypt({required String str, required String masterKey});

  Future<String> decrypt({
    required String encryptedStr,
    required String masterKey,
  });

  Future<String> convertKeyToValidForUse({required String masterKey});
}
