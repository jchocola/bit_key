import 'package:bit_key/core/exception/app_exception.dart';
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
      throw AppException.failed_to_authenticate;
    }
  }

  @override
  Future<bool> canAuthenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      if (!canAuthenticateWithBiometrics) {
         throw AppException.no_biometric_enrolled;
      }
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      logger.e(e);
      throw AppException.device_not_supported_local_auth;
      //return false;
    }
  }
}
