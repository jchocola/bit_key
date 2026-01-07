import 'package:bit_key/features/feature_auth/domain/repo/local_auth_repository.dart';
import 'package:bit_key/main.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthRepoImpl implements LocalAuthRepository {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Future<bool> authenticate({
    required String reason,
    bool biometricOnly = true,
  }) async {
    try {
      return await auth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<bool> canAuthenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}
