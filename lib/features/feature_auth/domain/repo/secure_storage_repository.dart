abstract class SecureStorageRepository {
  /// SALT
  Future<String?> getSalt();
  Future<void> setSalt(String salt);
  Future<void> deleteSalt();
  Future<String> generateSalt();

  /// HASHED MASTER KEY
  Future<String?> getHashedMasterKey();
  Future<void> setHashedMasterKey(String hashedMasterKey);
  Future<void> deleteControlSumString();
  Future<String> generateHashedMasterKey({
    required String masterKey,
    required String salt,
  });

  /// SESSION KEY
  Future<String?> getSessionKey();
  Future<void> setSessionKey(String sessionKey);
  Future<void> deleteSessionKey();
  Future<String> generateSessionKey();

  // ENCRYPTED MASTER KEY
  Future<String?> getEncryptedMasterKey();
  Future<void> setEncryptedMasterKey(String encryptedMasterKey);
  Future<void> deleteEncryptedMasterKey();
  Future<String> generateEncryptedMasterKey({
    required String masterKey,
    required String sessionKey,
  });
  Future<String?> decryptEncryptedMasterKey({
    required String sessionKey,
    required String encryptedMasterKey,
  });

  // ENCRYPTION
  Future<void> clearAllSecureData();

  // CHECK USER MASTER PASSWORD
  Future<bool> isMasterKeyValid(String masterKey);
}
