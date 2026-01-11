import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/events/base_event.dart';

import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';

class AmplitudeAnalyticRepoImpl implements AnalyticClientBase {
  final Amplitude amplitude;
  AmplitudeAnalyticRepoImpl({required this.amplitude});

  @override
  Future<void> identifyUser({required String salt}) async {
    await amplitude.track(BaseEvent('IDENIFY_USER', extra: {"SALT": salt}));
    // amplitude.track("Sign Up");
  }

  @override
  Future<void> resetUser()async {
     await amplitude.track(BaseEvent('RESET_USER',));
  }

  @override
  Future<void> trackAppBackgrounded() async{
     await amplitude.track(BaseEvent('APP_BACKGROUNDED',));
  }

  @override
  Future<void> trackAppCreated() async{
     await amplitude.track(BaseEvent('APP_CREATED',));
  }

  @override
  Future<void> trackAppDeleted() async{
     await amplitude.track(BaseEvent('APP_DELETED',));
  }

  @override
  Future<void> trackAppForegrounded() async{
     await amplitude.track(BaseEvent('APP_FOREGROUNDED',));
  }

  @override
  Future<void> trackAppUpdated() async{
     await amplitude.track(BaseEvent('APP_UPDATED',));
  }

  @override
  Future<void> trackBottomSheetView(
    String routeName, [
    Map<String, Object>? data,
  ]) async{
    await amplitude.track(BaseEvent('BOTTOM_SHEET_VIEW',extra: data));
  }

  @override
  Future<void> trackButtonPressed(
    String buttonName, [
    Map<String, Object>? data,
  ]) async{
     await amplitude.track(BaseEvent('BUTTON_PRESSED',extra: data));
  }

  @override
  Future<void> trackDialogView(String dialogName, [Map<String, Object>? data])async {
     await amplitude.track(BaseEvent('DIALOG_VIEW',extra: data));
  }

  @override
  Future<void> trackEvent(String eventName, [Map<String, Object>? eventData]) async{
      await amplitude.track(BaseEvent(eventName,extra: eventData));
  }

  @override
  Future<void> trackNewAppOnboarding() async{
     await amplitude.track(BaseEvent('NEW_APP_ONBOARDING',));
  }

  @override
  Future<void> trackPermissionRequest(String permission, String status) async{
     await amplitude.track(BaseEvent(permission,extra: {"status": status}));
  }

  @override
  Future<void> trackScreenView(String routeName, String action) async{
     await amplitude.track(BaseEvent(routeName,extra: {"action": action}));
  }
}
