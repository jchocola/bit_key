
abstract class SecureStorageRepository {
  /// SALT
  Future<String?> getSalt();
  Future<void> setSalt(String salt);
  Future<void> deleteSalt();
  Future<String> generateSalt();

  /// CONTROL SUM STRING
  Future<String?> getControlSumString();
  Future<void> setControlSumString(String controlSumString);
  Future<void> deleteControlSumString();

  /// SESSION KEY
  Future<String?> getSessionKey();
  Future<void> setSessionKey(String sessionKey);
  Future<void> deleteSessionKey();

  // ENCRYPTION
  Future<void> clearAllSecureData();


}
