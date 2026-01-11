import 'package:wiredash/wiredash.dart';

import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';

class WiredashAnalyticImpl implements AnalyticClientBase {
  final WiredashAnalytics wiredashAnalytic;
  WiredashAnalyticImpl({required this.wiredashAnalytic});

  @override
  Future<void> identifyUser({required String salt}) async {
    await wiredashAnalytic.trackEvent('IDENTIFU_USER', data: {"SALT": salt});
  }

  @override
  Future<void> resetUser() async {
    await wiredashAnalytic.trackEvent('RESET_USER');
  }

  @override
  Future<void> trackAppBackgrounded() async {
    await wiredashAnalytic.trackEvent('APP_BACKGROUNDED');
  }

  @override
  Future<void> trackAppCreated() async {
    await wiredashAnalytic.trackEvent('APP_CREATED');
  }

  @override
  Future<void> trackAppDeleted() async {
    await wiredashAnalytic.trackEvent('APP_DELETED');
  }

  @override
  Future<void> trackAppForegrounded() async {
    await wiredashAnalytic.trackEvent('APP_FOREGROUNDED');
  }

  @override
  Future<void> trackAppUpdated() async {
    await wiredashAnalytic.trackEvent('APP_UPDATED');
  }

  @override
  Future<void> trackBottomSheetView(
    String routeName, [
    Map<String, Object>? data,
  ]) async {
    await wiredashAnalytic.trackEvent('BOTTOM_SHEET_VIEW', data: data);
  }

  @override
  Future<void> trackButtonPressed(
    String buttonName, [
    Map<String, Object>? data,
  ]) async {
    await wiredashAnalytic.trackEvent('BUTTON_PRESSED', data: data);
  }

  @override
  Future<void> trackDialogView(
    String dialogName, [
    Map<String, Object>? data,
  ]) async {
    await wiredashAnalytic.trackEvent('DIALOG_VIEW', data: data);
  }

  @override
  Future<void> trackEvent(
    String eventName, [
    Map<String, Object>? eventData,
  ]) async {
    await wiredashAnalytic.trackEvent(eventName, data: eventData);
  }

  @override
  Future<void> trackNewAppOnboarding() async {
    await wiredashAnalytic.trackEvent('NEW_APP_ONBOARDING');
  }

  @override
  Future<void> trackPermissionRequest(String permission, String status) async {
    await wiredashAnalytic.trackEvent(permission, data: {"status": status});
  }

  @override
  Future<void> trackScreenView(String routeName, String action) async{
     await wiredashAnalytic.trackEvent(routeName, data: {"action": action});
  }
}
