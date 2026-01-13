import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';

class FirebaseAnalyticRepoImpl implements AnalyticClientBase {
  final FirebaseAnalytics firebaseAnalytics;
  FirebaseAnalyticRepoImpl({required this.firebaseAnalytics});

  @override
  Future<void> identifyUser({required String salt}) async {
    await firebaseAnalytics.logEvent(
      name: "IDENTIFY_USER",
      parameters: {"SALT": salt},
    );
  }

  @override
  Future<void> resetUser() async {
    await firebaseAnalytics.logEvent(name: "RESET_USER");
  }

  @override
  Future<void> trackAppBackgrounded() async {
    await firebaseAnalytics.logEvent(name: "TRACK_APP_BACKGROUNDED");
  }

  @override
  Future<void> trackAppCreated() async {
    await firebaseAnalytics.logEvent(name: "TRACK_APP_CREATED");
  }

  @override
  Future<void> trackAppDeleted() async {
    await firebaseAnalytics.logEvent(name: "APP_DELETED");
  }

  @override
  Future<void> trackAppForegrounded() async {
    await firebaseAnalytics.logEvent(name: "APP_FOREGROUNDED");
  }

  @override
  Future<void> trackAppUpdated() async {
    await firebaseAnalytics.logEvent(name: "APP_UPDATED");
  }

  @override
  Future<void> trackBottomSheetView(
    String routeName, [
    Map<String, Object>? data,
  ]) async {
    await firebaseAnalytics.logEvent(name: routeName, parameters: data);
  }

  @override
  Future<void> trackButtonPressed(
    String buttonName, [
    Map<String, Object>? data,
  ]) async {
    await firebaseAnalytics.logEvent(name: "BUTTON_PRESSED", parameters: data);
  }

  @override
  Future<void> trackDialogView(
    String dialogName, [
    Map<String, Object>? data,
  ]) async {
    await firebaseAnalytics.logEvent(name: dialogName, parameters: data);
  }

  @override
  Future<void> trackEvent(
    String eventName, [
    Map<String, Object>? eventData,
  ]) async {
    await firebaseAnalytics.logEvent(name: eventName, parameters: eventData);
  }

  @override
  Future<void> trackNewAppOnboarding() async {
    await firebaseAnalytics.logEvent(name: "NEW_APP_ONBOARDING");
  }

  @override
  Future<void> trackPermissionRequest(String permission, String status) async {
    await firebaseAnalytics.logEvent(
      name: permission,
      parameters: {"STATUS": status},
    );
  }

  @override
  Future<void> trackScreenView(String routeName, String action) async {
    await firebaseAnalytics.logEvent(name: "SCREEN_VIEW", parameters: {
      "ROUTE_NAME": routeName,
      "ACTION":action,
    });
  }
}
