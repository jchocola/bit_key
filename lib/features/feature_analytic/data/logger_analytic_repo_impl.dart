import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';
import 'package:bit_key/main.dart';

class LoggerAnalyticRepoImpl implements AnalyticClientBase {
  @override
  Future<void> identifyUser({required String salt}) async {
    logger.d('Identify User ${salt}');
  }

  @override
  Future<void> resetUser() async {
    logger.d('Reset User');
  }

  @override
  Future<void> trackAppBackgrounded() async {
    logger.d('Track App Backgrounded');
  }

  @override
  Future<void> trackAppCreated() async {
    logger.d('Track App Created');
  }

  @override
  Future<void> trackAppDeleted() async {
    logger.d('Track app deleted');
  }

  @override
  Future<void> trackAppForegrounded() async {
    logger.d('Track app froegrounded');
  }

  @override
  Future<void> trackAppUpdated() async {
    logger.d('Track app updated');
  }

  @override
  Future<void> trackBottomSheetView(
    String routeName, [
    Map<String, Object>? data,
  ]) async {
    logger.d('Track bottom sheet view');
  }

  @override
  Future<void> trackButtonPressed(
    String buttonName, [
    Map<String, Object>? data,
  ]) async {
    logger.d('Track button pressed');
  }

  @override
  Future<void> trackDialogView(
    String dialogName, [
    Map<String, Object>? data,
  ]) async {
    logger.d('Track dialog view');
  }

  @override
  Future<void> trackEvent(
    String eventName, [
    Map<String, Object>? eventData,
  ]) async {
    logger.d('Track event ${eventName}');
  }

  @override
  Future<void> trackNewAppOnboarding() async {
    logger.d('Track new app onboarding');
  }

  @override
  Future<void> trackPermissionRequest(String permission, String status) async {
    logger.d('Track permission request $permission');
  }

  @override
  Future<void> trackScreenView(String routeName, String action) async {
    logger.d('Track Screen View $routeName');
  }
}
