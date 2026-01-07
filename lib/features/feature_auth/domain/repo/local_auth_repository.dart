abstract class LocalAuthRepository {
  Future<bool> canAuthenticate();
  Future<bool> authenticate({required String reason, bool biometricOnly});
}
