import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';

class LoggerAnalyticRepoImpl implements AnalyticClientBase{
  @override
  Future<void> identifyUser({required String salt}) {
    // TODO: implement identifyUser
    throw UnimplementedError();
  }

  @override
  Future<void> resetUser() {
    // TODO: implement resetUser
    throw UnimplementedError();
  }

  @override
  Future<void> trackAppBackgrounded() {
    // TODO: implement trackAppBackgrounded
    throw UnimplementedError();
  }

  @override
  Future<void> trackAppCreated() {
    // TODO: implement trackAppCreated
    throw UnimplementedError();
  }

  @override
  Future<void> trackAppDeleted() {
    // TODO: implement trackAppDeleted
    throw UnimplementedError();
  }

  @override
  Future<void> trackAppForegrounded() {
    // TODO: implement trackAppForegrounded
    throw UnimplementedError();
  }

  @override
  Future<void> trackAppUpdated() {
    // TODO: implement trackAppUpdated
    throw UnimplementedError();
  }

  @override
  Future<void> trackBottomSheetView(String routeName, [Map<String, Object>? data]) {
    // TODO: implement trackBottomSheetView
    throw UnimplementedError();
  }

  @override
  Future<void> trackButtonPressed(String buttonName, [Map<String, Object>? data]) {
    // TODO: implement trackButtonPressed
    throw UnimplementedError();
  }

  @override
  Future<void> trackDialogView(String dialogName, [Map<String, Object>? data]) {
    // TODO: implement trackDialogView
    throw UnimplementedError();
  }

  @override
  Future<void> trackEvent(String eventName, [Map<String, Object>? eventData]) {
    // TODO: implement trackEvent
    throw UnimplementedError();
  }

  @override
  Future<void> trackNewAppOnboarding() {
    // TODO: implement trackNewAppOnboarding
    throw UnimplementedError();
  }

  @override
  Future<void> trackPermissionRequest(String permission, String status) {
    // TODO: implement trackPermissionRequest
    throw UnimplementedError();
  }

  @override
  Future<void> trackScreenView(String routeName, String action) {
    // TODO: implement trackScreenView
    throw UnimplementedError();
  }
}